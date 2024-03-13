// HCR v3.0.3 - 18th May, 2005 - SE
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_CH_AC1
//::////////////////////////////////////////////////////////////////////////////
/*
   Added toggle for 1/2 hp's - 9th January, Sir Elric
   Move towards master or wait for him.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:: Updated On: Jul 25, 2003 - Georg Zoeller
//::////////////////////////////////////////////////////////////////////////////
#include "X0_INC_HENAI"
#include "X2_INC_SUMMSCALE"
#include "X2_INC_SPELLHOOK"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    //SpawnScriptDebugger();

    // GZ: Fallback for timing issue sometimes preventing epic summoned
    // creatures from leveling up to their master's level. There is a timing
    // issue with the GetMaster() function not returning the master of a
    // creature immediately after spawn. Some code which might appear to make no
    // sense has been added to the nw_ch_ac1 and x2_inc_summon files to work
    // around this. This code is only run on the first hearbeat.
    int nLevel = SSMGetSummonFailedLevelUp(OBJECT_SELF);
    if (nLevel != 0)
    {
        int nRet;
        if (nLevel == -1)// Special Shadow Lord treatment.
        {
            SSMScaleEpicShadowLord(OBJECT_SELF);
        }
        else if  (nLevel == -2)
        {
            SSMScaleEpicFiendishServant(OBJECT_SELF);
        }
        else
        {
            nRet = SSMLevelUpCreature(OBJECT_SELF, nLevel, CLASS_TYPE_INVALID);
            if (nRet == FALSE)
                WriteTimestampedLogEntry("WARNING - nw_ch_ac1:: could not level up " + GetTag(OBJECT_SELF) + "!");
        }

        // Regardless if the actual levelup worked, we give up here, because we do
        // not want to run through this script more than once.
        SSMSetSummonLevelUpOK(OBJECT_SELF);
    }

    // Check if concentration is required to maintain this creature.
    X2DoBreakConcentrationCheck();

    object oMod = GetModule();
    object oMaster = GetMaster();

    // HCR - Remark out the following "if" block of code if you want to use the
    // alternative method below.

    // *** Start original Real Familiar code. ***
    if (GetLocalInt(oMod, "REALFAM") && GetLocalInt(oMod, "REALFAMHP"))
    {
        if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == OBJECT_SELF)
        {
            // Check to see if critter is a familiar.
            // If so, limit it to 1/2 hp of master per PHB.
            if (GetIsObjectValid(oMaster))
            {
                int nMHP = GetMaxHitPoints();
                int nCHP = GetCurrentHitPoints();
                int nMax = (GetMaxHitPoints(oMaster)/2);
                if ((nMHP - nCHP) >= nMax)
                {
                    effect eDeath = EffectDeath(FALSE, FALSE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
                }
            }
        }
    }
    // *** End original Real Familiar code. ***

    // HCR - Unremark this "if" block of code and remark out the above code for
    // alternative Familiar hit points.
/*
    // *** Start alternate Real Familiar code. ***
    if (GetLocalInt(oMod, "REALFAM"))
    {
        if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == OBJECT_SELF)
        {
            // Check to see if critter is a familiar.
            // If so, limit it to 1/2 hp of master per PHB.
            if (GetIsObjectValid(oMaster))
            {
                if (!GetIsResting(oMaster))
                {
                    int nMHP = GetMaxHitPoints();
                    int nCHP = GetCurrentHitPoints();
                    int nMax = (GetMaxHitPoints(oMaster)/2);
                    if (nCHP > nMax)
                    {
                        int nDam = (nCHP - nMax);
                        effect eDam = EffectDamage(nDam);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);

                        if (!GetLocalInt(OBJECT_SELF, "FAMMSG"))
                        {
                            SendMessageToPC(oMaster, "Familiar's Hit Points adjusted to 1/2 of master's in accordance with 3rd edition rules.");
                            SetLocalInt(OBJECT_SELF, "FAMMSG", TRUE);
                        }
                    }
                }
            }
        }
    }
    // *** End alternate Real Familiar code. ***
*/

    if (!GetAssociateState(NW_ASC_IS_BUSY))
    {
        // Seek out and disable undisabled traps.
        object oTrap = GetNearestTrapToObject();
        if (bkAttemptToDisarmTrap(oTrap) == TRUE)
            return;// Succesful trap found and disarmed.

        if (GetIsObjectValid(oMaster) &&
            GetCurrentAction() != ACTION_FOLLOW &&
            GetCurrentAction() != ACTION_DISABLETRAP &&
            GetCurrentAction() != ACTION_OPENLOCK &&
            GetCurrentAction() != ACTION_REST &&
            GetCurrentAction() != ACTION_ATTACKOBJECT)
        {
            if (!GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
            {
                if (GetIsObjectValid(oMaster) == TRUE)
                {
                    if (GetDistanceToObject(oMaster) > 6.0)
                    {
                        if (GetAssociateState(NW_ASC_HAVE_MASTER))
                        {
                            if (!GetIsFighting(OBJECT_SELF))
                            {
                                if (!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                                {
                                    if (GetDistanceToObject(oMaster) > GetFollowDistance())
                                    {
                                        ClearActions(CLEAR_NW_CH_AC1_49);

                                        if (GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) ||
                                            GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                        {
                                            if (GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                            {
                                                //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                                //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                            }

                                            if (GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                                ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);

                                            MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                            ActionForceFollowObject(oMaster, GetFollowDistance());
                                        }
                                        else
                                        {
                                            MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                            ActionForceFollowObject(oMaster, GetFollowDistance());
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else if (!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if (GetIsObjectValid(oMaster))
                    {
                        if (GetCurrentAction(oMaster) != ACTION_REST)
                        {
                            ClearActions(CLEAR_NW_CH_AC1_81);

                            if (GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) ||
                                GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                            {
                                if (GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                {
                                    //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                    //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                }

                                if (GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);

                                MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                            else
                            {
                                MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                        }
                    }
                }
            }
            else if (!GetIsObjectValid(GetAttackTarget()) &&
                     !GetIsObjectValid(GetAttemptedSpellTarget()) &&
                     !GetIsObjectValid(GetAttemptedAttackTarget()) &&
                     !GetAssociateState(NW_ASC_MODE_STAND_GROUND))
            {
                //DetermineCombatRound();
            }
        }

        // * If I am dominated, ask for some help.
        if (GetHasEffect(EFFECT_TYPE_DOMINATED, OBJECT_SELF) == TRUE &&
            GetIsEncounterCreature(OBJECT_SELF) == FALSE)
            SendForHelp();

        if (GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
            SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }
}
//::////////////////////////////////////////////////////////////////////////////
