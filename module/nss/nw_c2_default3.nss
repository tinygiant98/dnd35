// HCR v3.2.0 - Added code so creatures would stop attacking dying PC's.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_C2_Default3
//::////////////////////////////////////////////////////////////////////////////
/*
   Calls the end of combat script every round
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//::////////////////////////////////////////////////////////////////////////////
#include "NW_I0_GENERIC"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    // Determine current target.
    object oTarget = GetAttackTarget();
    if (!GetIsObjectValid(oTarget))
    {
        oTarget = GetAttemptedAttackTarget();
        if (!GetIsObjectValid(oTarget))
            oTarget = GetAttemptedSpellTarget();
    }

    // If the current target is dead or dying then look for a new one.
    if (GetIsObjectValid(oTarget) && GetIsDead(oTarget))
    {
        ClearAllActions();
        DetermineCombatRound();
    }
    else if (GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if (!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        DetermineCombatRound();
    }

    if (GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
}
//::////////////////////////////////////////////////////////////////////////////
