// HCR 3.03 - 9th September, 2005 - SE
//  ----------------------------------------------------------------------------
//  nw_s0_raisdead
//  ----------------------------------------------------------------------------
/*
    Spell script to bring a PC or an NPC back to life with full health.

    In HCR, death has many variants:
    ----------------------------------

    - Death, Limbo: PC dies and is in due course transferred to limbo. In their
      place a static Corpse NPC, an "invisible" DeathCorpse placeable and an PCT
      (Player Corpse Token) item are created. A caster can use the DeathCorpse
      to revive the PC.  Currently if the caster tries to revive a PC before
      they are transferred to limbo they will be informed that this is not
      possible. The DeathCorpse can be used to revive a PC who is off-line.

    - Death, No Limbo: PC dies and remains where they fell.  At their location
      the same 3 components are created (Corpse, DeathCorpse and PCT). A caster
      can use the DeathCorpse to revive the PC or cast directly onto the PC. The
      DeathCorpse can be used to revive a PC who is off-line.

    - No Death, No Limbo: PC dies and remains where they fell.  They have the
      option to respawn however if they choose to wait for help a caster can
      cast directly onto the PC to revive them.

    - NPC: NPC dies and remains where they fell (depending on other options). A
      Caster can cast directly onto the NPC to revive them.


    HCR 3.02.05 - Unresolved Issues
    -------------------------------
    - NOTFUGUE is used to prevent a PC from being transfered to fugue while in
      the process of being revived. The flag is checked by a delayed function
      in hc_on_play_death which otherwise transfers the PC to fugue. However as
      noted above MOVING pre-empts all attempts to revive a PC who has not yet
      been transfered to Fugue.  NOTFUGUE appears to have been rendered
      redundant.


    HCR 3.02.05 - TODO List
    -----------------------
    - replace literals with DEATH and REVIVAL constants when available


    Original BW Notes
    -----------------
    When cast on placeables, you get a default error message.
    * You can specify a different message in X2_L_RESURRECT_SPELL_MSG_RESREF
    * You can turn off the message by setting the variable to -1

*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 06 September 2005 - Sir Elric
    - bug fix not checking target is dead

    HCR 3.02 - 05 August 2004 - Sunjammer
    - modified for use with NPC Corpse system

    HCR 3.02 - 21 March 2004 - Sunjammer
    - rewritten

    Credits:
    - Georg Zeoller
    - Preston Watamaniuk
*/
//  ----------------------------------------------------------------------------
#include "hc_inc"
#include "hc_inc_dcorpse"
#include "hc_inc_npccorpse"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_text_activate"
#include "x2_inc_spellhook"


//  ----------------------------------------------------------------------------
//  MAIN
//  ----------------------------------------------------------------------------

void main()
{
    // if code within the PreSpellCastHook reports FALSE, do not run this spell
    if (X2PreSpellCastCode() == FALSE)
        return;

    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oCreature;

    // get system being used, oMod courtesy of hc_inc
    int bUsingDeath      = GetLocalInt(oMod, "DEATHSYSTEM");
    int bUsingCorpses    = GetLocalInt(oMod, "NPCCORPSE");
    int bUsingLimbo      = GetLocalInt(oMod, "LIMBO");
    int bUsingRezPenalty = GetLocalInt(oMod, "REZPENALTY");

    // cast at DeathCorpse flag
    int bCastAtDC = FALSE;


    // -------------------------------------------------------------------------
    // Part 1: find the creature to revive
    // -------------------------------------------------------------------------

    int nType = GetObjectType(oTarget);
    string sTag = GetTag(oTarget);

    if(nType == OBJECT_TYPE_CREATURE && GetIsDead(oTarget))
    {
        // target is a PC or an NPC and hence the creature to revive
        oCreature = oTarget;
    }
    else if(nType == OBJECT_TYPE_PLACEABLE)
    {
        // target is a DeathCorpse (requires Death System) or other placeable
        if(bUsingDeath && sTag == "DeathCorpse")
        {
            // valid: get creature to revive and raise cast at DC flag
            oCreature = GetLocalObject(oTarget, "Owner");
            bCastAtDC = TRUE;
        }
        else if(bUsingCorpses && sTag == HC_TAG_NPCCORPSE_CORPSE)
        {
            // valid: get creature to revive
            oCreature = GetLocalObject(oTarget, HC_VAR_NPCCORPSE_BODY);
        }
        else
        {
            // invalid: send "can't revive that" message to caster and abort
            int nStrRef = GetLocalInt(oTarget, "X2_L_RESURRECT_SPELL_MSG_RESREF");
            if(nStrRef == 0)
            {
                nStrRef = 83861;
            }
            if(nStrRef != -1)
            {
                // inform caster that they cannot revive this object
                FloatingTextStrRefOnCreature(nStrRef, oCaster);
            }
            return;
        }
    }
    else
    {
        // target is invalid or an invalid type: abort
        return;
    }

    // pre-emptive abort if MOVING to LIMBO (see above)
    if(bUsingLimbo && GetLocalInt(oCreature, "MOVING"))
    {
        SendMessageToPC(oCaster, NOTRAISE);
        return;
    }

    // -------------------------------------------------------------------------
    // Part 2: Revive the creature.
    // -------------------------------------------------------------------------

    int bIsPC = GetIsPC(oCreature);

    // raise/lower NOTFUGUE flag according to location (see above)
    if(bUsingLimbo && GetTag(GetArea(oCreature)) == "FuguePlane")
        DeleteLocalInt(oCreature, "NOTFUGUE");
    else
        SetLocalInt(oCreature, "NOTFUGUE", TRUE);

    // visual revival
    effect eVFX = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, GetLocation(oTarget));

    // actual revival
    if(bCastAtDC && GetIsObjectValid(oCreature) == FALSE)
    {
        // ---------------------------------------------------------------------
        // off-line revival can only occur when casting at a DeathCorpse
        // ---------------------------------------------------------------------
        string sID = GetLocalString(oTarget, "Pkey");

        // inform caster, store revival location
        SendMessageToPC(oCaster, NOTONLINE);
        SetPersistentLocation(oMod, "RESLOC" + sID, GetLocation(oCaster));

        // revive the off-line PC
        if(GetIsDM(oCaster))
        {
            // DM provides a Raise Dead
            // NOTE: this is left seperate to allow different state to be used
            SPS(oCreature, PWS_PLAYER_STATE_RAISEDEAD);
        }
        else
        {
            // PC/NPC provides a Raise Dead
            SPS(oCreature, PWS_PLAYER_STATE_RAISEDEAD);
        }

        return;
    }
    else
    {
        // ---------------------------------------------------------------------
        // on-line revival can occur when casting at a DeathCorpse or at a dead
        // PC or NPC with various combinations of systems and targets
        // ---------------------------------------------------------------------
        // 1: PC, bUsingDeath, bUsingLimbo, bCastAtDC
        //      - PC in fugue (MOVING)
        //      - manually jump to DC
        //      - existing Heal, RemEff & Ress (hc_on_play_death)
        //      - existing kill body, DC & PCT (hc_fugue_exit)
        //      - existing player state change (hc_fugue_exit)
        // 2: PC, bUsingDeath, bCastAtDC
        //      - PC is anywhere, DC is target
        //      - manually jump to DC
        //      - manually kill body, DC & PCT
        //      - manually player state change
        //      - manually Heal, RemEff & Ress
        // 3: PC, bUsingDeath
        //      - PC (wait for help) is target
        //      - manually kill body, DC & PCT
        //      - manually player state change
        //      - manually Heal, RemEff & Ress
        // 4: PC
        //      - PC (wait for help) is target
        //      - manually Heal, RemEff & Ress
        // 5: NPC
        //      - NPC is target
        //      - manually Heal, RemEff & Ress
        // ---------------------------------------------------------------------
        string sID = GetPlayerID(oCreature);

        // fire cast spell at event for the specified creature
        SignalEvent(oCreature, EventSpellCastAt(oCaster, SPELL_RESURRECTION, FALSE));

        // start reviving
        if(bIsPC && bUsingDeath && bUsingLimbo && bCastAtDC)
        {
            // 1: requires a jump to the DeathCorpse, everything else is done
            AssignCommand(oCreature, JumpToObject(oTarget));
        }
        else
        {
            // 2-3: require the body, DeathCorpse and PCT to be destoyed and for
            //      the PC's player state to be updated
            if(bIsPC && bUsingDeath)
            {
                // 2: requires a jump to the DeathCorpse
                if(bCastAtDC)
                {
                    AssignCommand(oCreature, JumpToObject(oTarget));
                }

                // destroy the cloned NPC corpse
                DelayCommand(0.5, DestroyCorpse(oCreature));

                // destroy DeathCorpse
                DelayCommand(0.6, DestroyObject(oTarget));

                // destoy the PlayerCorpseToken
                object oPCT = GetLocalObject(oMod, "PlayerCorpse" + sID);
                DestroyObject(oPCT);

                // set PC's player state as alive
                SPS(oCreature, PWS_PLAYER_STATE_ALIVE);
            }

            // 2-5: require revival, healing and removal of effects
            effect eRess = EffectResurrection();
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eRess, oCreature);

            HC_SetCurrentHitPoints(oCreature, 1);

            RemoveEffects(oCreature);
        }
    }

    // -------------------------------------------------------------------------
    // Part 3: post-revival common stuff and clean up
    // -------------------------------------------------------------------------

    if(bIsPC)
    {
        if(bUsingRezPenalty && GetIsDM(oCaster) == FALSE)
        {
            // apply RezPenalty if appropriate
            DelayCommand(3.0, hcRezPenalty(oCreature));
        }

        // force any nearby hostiles to attack
        DelayCommand(5.0, ExecuteScript("hc_attackpc" , oCreature));

        // lower NOTFUGUE flag
        DeleteLocalInt(oCreature, "NOTFUGUE");
    }
    else
    {
        // NPC Corpse clean up
        HC_NPCCorpse_CleanUp(oTarget);
    }
}
