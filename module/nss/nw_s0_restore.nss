// HCR v3.2.0 - Removed Wild Magic include and function. Added spell hook code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S0_Restore
//::////////////////////////////////////////////////////////////////////////////
/*
   Removes all negative effects unless they come from Poison, Disease or Curses.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//::////////////////////////////////////////////////////////////////////////////
#include "x2_inc_spellhook"
//::////////////////////////////////////////////////////////////////////////////

// Returns TRUE if eEff was created by a supernatural force and can't be
// dispelled by spells.
int GetIsSupernaturalCurse(effect eEff);

//::////////////////////////////////////////////////////////////////////////////
void main()
{
  // If code within the PreSpellCastHook reports FALSE, do not run this spell.
  if (!X2PreSpellCastCode()) { return; }

  // Search for negative effects.
  int nType;
  int nSubType;
  object oTarget = GetSpellTargetObject();
  effect eBad = GetFirstEffect(oTarget);
  while (GetIsEffectValid(eBad))
    {
     nType = GetEffectType(eBad);
     if (nType == EFFECT_TYPE_ABILITY_DECREASE ||
         nType == EFFECT_TYPE_AC_DECREASE ||
         nType == EFFECT_TYPE_ATTACK_DECREASE ||
         nType == EFFECT_TYPE_DAMAGE_DECREASE ||
         nType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
         nType == EFFECT_TYPE_SAVING_THROW_DECREASE ||
         nType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
         nType == EFFECT_TYPE_SKILL_DECREASE ||
         nType == EFFECT_TYPE_BLINDNESS ||
         nType == EFFECT_TYPE_DEAF ||
         nType == EFFECT_TYPE_PARALYZE ||
         nType == EFFECT_TYPE_NEGATIVELEVEL)
       {
        // Remove effect if it is negative.
        nSubType = GetEffectSubType(eBad);
        if (nSubType != SUBTYPE_EXTRAORDINARY &&
           !GetIsSupernaturalCurse(eBad))
          { RemoveEffect(oTarget, eBad); }
       }
     eBad = GetNextEffect(oTarget);
    }

  // Fire cast spell at event for the specified target.
  SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));

  // Apply visual effect.
  effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}
//::////////////////////////////////////////////////////////////////////////////
int GetIsSupernaturalCurse(effect eEff)
{
  object oCreator = GetEffectCreator(eEff);
  if (GetTag(oCreator) == "q6e_ShaorisFellTemple")
    { return TRUE; }
  return FALSE;
}
//::////////////////////////////////////////////////////////////////////////////
