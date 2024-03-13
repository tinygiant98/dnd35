// HCR v3.2.0 - Re-Added Woodland Stride check w/HOTU code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S1_BltWeb
//::////////////////////////////////////////////////////////////////////////////
/*
   Glues a single target to the ground with sticky strands of webbing.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan. 28, 2002
//:: Updated On: July 15, 2003 - Removed saving throw - Georg Zoeller.
//::////////////////////////////////////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_switches"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  // Fire cast spell at event for the specified target.
  object oTarget = GetSpellTargetObject();
  SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BOLT_WEB));

  // Make a saving throw check.
  if (TouchAttackRanged(oTarget))
    {
     if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE)
       {
        if (!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget))
          {
           // Apply the VFX impact and effects.
           effect eVis   = EffectVisualEffect(VFX_DUR_WEB);
           effect eStick = EffectEntangle();
           effect eLink  = EffectLinkEffects(eVis, eStick);
           int nHDice = GetHitDice(OBJECT_SELF);
           int nCount = ((nHDice + 1) / 2);
           float fDur = RoundsToSeconds(nCount);
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDur);
          }
       }
    }
}
//::////////////////////////////////////////////////////////////////////////////
