// HCR v3.2.0 - Removed Wild Magic include and function. Added spell hook code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S0_GrRestore
//::////////////////////////////////////////////////////////////////////////////
/*
   Removes all negative effects of a temporary nature and all permanent effects
  of a supernatural nature from the character. Does not remove the effects
  relating to Mind-Affecting spells or movement alteration. Heals target for
  5d8 + 1 point per caster level.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan.  7, 2002
//::////////////////////////////////////////////////////////////////////////////
#include "x2_inc_spellhook"
//::////////////////////////////////////////////////////////////////////////////

// Returns TRUE if eEff was created by a supernatural force and can't be
// dispelled by spells.
int GetIsSupernaturalCurse(effect eEff);

//::////////////////////////////////////////////////////////////////////////////
void main()
{
/*
  Spellcast Hook Code. Added 2003-06-23 by GeorgZ. If you want to make changes
  to all spells, check x2_inc_spellhook.nss to find out more.
*/
  // If code within the PreSpellCastHook reports FALSE, do not run this spell.
  if (!X2PreSpellCastCode()) { return; }
  // End of Spell Cast Hook.

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
         nType == EFFECT_TYPE_CURSE ||
         nType == EFFECT_TYPE_DISEASE ||
         nType == EFFECT_TYPE_POISON ||
         nType == EFFECT_TYPE_PARALYZE ||
         nType == EFFECT_TYPE_CHARMED ||
         nType == EFFECT_TYPE_DOMINATED ||
         nType == EFFECT_TYPE_DAZED ||
         nType == EFFECT_TYPE_CONFUSED ||
         nType == EFFECT_TYPE_FRIGHTENED ||
         nType == EFFECT_TYPE_NEGATIVELEVEL ||
         nType == EFFECT_TYPE_PARALYZE ||
         nType == EFFECT_TYPE_SLOW ||
         nType == EFFECT_TYPE_STUNNED)
       {
        // Remove effect if it is negative.
        nSubType = GetEffectSubType(eBad);
        if (nSubType != SUBTYPE_EXTRAORDINARY &&
           !GetIsSupernaturalCurse(eBad))
          { RemoveEffect(oTarget, eBad); }
       }
     eBad = GetNextEffect(oTarget);
    }

  // Only heal if target is not undead.
  if (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
     int nHeal;
     int nMHP = GetMaxHitPoints(oTarget);
     int nCHP = GetCurrentHitPoints(oTarget);
     if (nCHP < 0)
       { nHeal = (abs(nCHP) + nMHP); }
     else
       { nHeal = (nMHP - nCHP); }

     effect eHeal = EffectHeal(nHeal);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }

  // Fire cast spell at event for the specified target.
  SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_RESTORATION, FALSE));

  // Apply the visual effect.
  effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
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
