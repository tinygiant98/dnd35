// HCR v3.4.0 - 21st July, 2008
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_CH_AC7
//::////////////////////////////////////////////////////////////////////////////
/*
   Fireball explosion does 50 damage to all within 20ft

*/
//::////////////////////////////////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 9th, 2008
//:: Added Support for Dying While Mounted

#include "HC_Inc"
#include "HC_Inc_RemEff"
#include "NW_I0_Generic"
#include "x3_inc_horse"

//::////////////////////////////////////////////////////////////////////////////
// -----------------------------------------------------------------------------
// Georg, 2003-10-08
// Rewrote that jump part to get rid of the DelayCommand Code that was prone to
// timing problems. If want to see a really back hack, this function is just that.
// -----------------------------------------------------------------------------
void WrapJump(string sTarget)
{
    if (GetIsDead(OBJECT_SELF))
    {
        // * Resurrect and heal again, just in case.
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectResurrection(), OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHeal(GetMaxHitPoints(OBJECT_SELF)), OBJECT_SELF);

        // * Recursively call self until we are alive again.
        DelayCommand(1.0f, WrapJump(sTarget));
        return;
    }

    // * Since the henchmen are teleporting very fast now, we leave a bloodstain on the ground.
    object oBlood = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", GetLocation(OBJECT_SELF));

    // * Remove blood after a while.
    DestroyObject(oBlood, 30.0f);

    // * Ensure the action queue is open to modification again.
    SetCommandable(TRUE,OBJECT_SELF);

    // * Jump to Target.
    JumpToObject(GetObjectByTag(sTarget), FALSE);

    // * Unset busy state.
    ActionDoCommand(SetAssociateState(NW_ASC_IS_BUSY, FALSE));

    // * Make self vulnerable.
    SetPlotFlag(OBJECT_SELF, FALSE);

    // * Set destroyable flag to leave corpse.
    DelayCommand(6.0f, SetIsDestroyable(TRUE, TRUE, TRUE));
}
//::////////////////////////////////////////////////////////////////////////////
// -----------------------------------------------------------------------------
// Georg, 2003-10-08
// Changed to run the bad recursive function above.
// -----------------------------------------------------------------------------
void BringBack()
{
    object oSelf = OBJECT_SELF;
    SetLocalObject(oSelf, "NW_L_FORMERMASTER", GetMaster());
    HCR_RemoveEffects(oSelf);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectResurrection(), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHeal(GetMaxHitPoints(OBJECT_SELF)), OBJECT_SELF);
    object oWay = GetObjectByTag("NW_DEATH_TEMPLE");
    if (GetIsObjectValid(oWay) == TRUE)
    {
        // * If in Source stone area, respawn at opening to area.
        if (GetTag(GetArea(oSelf)) == "M4Q1D2")
            DelayCommand(1.0, WrapJump("M4QD07_ENTER"));
        else
            DelayCommand(1.0, WrapJump(GetTag(oWay)));
    }
    else
    {
        WriteTimestampedLogEntry("UT: No place to go");
    }
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    SetLocalString(OBJECT_SELF,"sX3_DEATH_SCRIPT","nw_ch_ac7");
    if (HorseHandleDeath()) return;
    DeleteLocalString(OBJECT_SELF,"sX3_DEATH_SCRIPT");

    // * This is used by the advanced henchmen.
    // * Let Brent know if it interferes with animal companions, et cetera.
    object oMaster = GetMaster();
    if (GetIsObjectValid(oMaster) == TRUE)
    {
        object oMe = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oMaster);
        if (oMe == OBJECT_SELF ||
            GetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED") == TRUE)
        {
            // -----------------------------------------------------------------
            // Georg, 2003-10-08
            // Rewrote code from here.
            // -----------------------------------------------------------------
            SetPlotFlag(oMe, TRUE);
            SetAssociateState(NW_ASC_IS_BUSY, TRUE);
            AddJournalQuestEntry("Henchman", 99, oMaster, FALSE, FALSE, FALSE);
            SetIsDestroyable(FALSE, TRUE, TRUE);
            SetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED", TRUE);
            BringBack();
            // -----------------------------------------------------------------
            // End of rewrite
            // -----------------------------------------------------------------
        }
        // * I am a familiar, give 1d6 damage to my master.
        else if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == OBJECT_SELF)
        {
            // Check to see if critter is a familiar. If so, impose an xp penalty.
            if (GetLocalInt(oMod, "REALFAM"))
            {
                // Clean up int.
                DeleteLocalInt(OBJECT_SELF, "FAMMSG");

                if (GetIsPC(oMaster) &&
                   !GetIsDM(oMaster) &&
                   !GetIsDMPossessed(oMaster))
                {
                    // Set the death local.
                    string sID = GetPlayerID(oMaster);
                    SetLocalInt(oMod, "FAMDIED" + sID, 1);

                    // Give the PC some feedback regarding the Familiar's death.
                    SendMessageToPC(oMaster, "Your Familiar has been killed!");

                    // Determine amount of XP penalty set in hc_defaults - 9th Jan, Sir Elric
                    int nXPPen = (GetLocalInt(oMod, "REALFAM") * GetHitDice(oMaster));

                    // Halve the penalty on a successful fortitude save.
                    if (FortitudeSave(oMaster, 15) > 0)
                        nXPPen /= 2;

                    // Set and apply the XP penalty.
                    SetLocalInt(oMaster, "TAKEXP", nXPPen);
                    ExecuteScript("hc_takexp", oMaster);
                }
            }
            else
            {
                // Give the PC some feedback regarding the Familiar's death.
                FloatingTextStrRefOnCreature(63489, oMaster, FALSE);

                // Familiar death can never kill the PC, only wound them.
                int nDam = d6();
                int nCHP = GetCurrentHitPoints(oMaster);
                if (nDam >= nCHP)
                    nDam = (nCHP - 1);

                // Set and apply the hitpoint damage.
                effect eDam = EffectDamage(nDam);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oMaster);
            }
        }
    }
}
//::////////////////////////////////////////////////////////////////////////////
