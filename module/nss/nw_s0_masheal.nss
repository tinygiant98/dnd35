// HCR v3.2.0 - Removed Wild Magic include and function. Added spell hook code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S0_MasHeal
//::////////////////////////////////////////////////////////////////////////////
/*
   Heals all friendly targets within 10ft to full unless they are undead. If
  undead they are reduced to 1d4 HP.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//::////////////////////////////////////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  // If code within the PreSpellCastHook reports FALSE, do not run this spell.
  if (!X2PreSpellCastCode()) { return; }

  // Declare major variables.
  float fDelay;
  effect eKill;
  effect eHeal;
  effect eVis1 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
  int nMHP, nCHP, nHeal, nDam, nMod;
  int nMetaMagic = GetMetaMagicFeat();

  // Apply VFX area impact.
  effect eStrike = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
  location lLoc  = GetSpellTargetLocation();
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);

  // Get first target in spell area.
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
  while (GetIsObjectValid(oTarget))
    {
     fDelay = GetRandomDelay();
     nCHP = GetCurrentHitPoints(oTarget);

     // Check to see if the target is an undead.
     if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD && !GetIsReactionTypeFriendly(oTarget))
       {
        // Fire cast spell at event for the specified target.
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL));

        // Make a touch attack.
        if (TouchAttackRanged(oTarget) > 0)
          {
           if (!GetIsReactionTypeFriendly(oTarget))
             {
              // Make an SR check.
              if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                 // Detemine the damage to inflict to the undead.
                 if (nMetaMagic == METAMAGIC_MAXIMIZE)
                   { nMod = 1; }
                 else
                   { nMod = d4(); }
                 nDam = (nCHP - nMod);

                 // Set the damage effect.
                 eKill = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE);

                 // Apply the damage visual and effect.
                 DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oTarget));
                 DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                }
             }
          }
       }
     else
       {
        // Make a faction check
        if (GetIsFriend(oTarget) && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
          {
           // Fire cast spell at event for the specified target.
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL, FALSE));

           // Figure out how much to heal.
           nMHP = GetMaxHitPoints(oTarget);
           if (nCHP < 0)
             { nHeal = (abs(nCHP) + nMHP); }
           else
             { nHeal = (nMHP - nCHP); }

           // Set the heal effect.
           eHeal = EffectHeal(nHeal);

           // Apply the heal visual and effect.
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
           DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
          }
       }

     // Get next target in the spell area.
     oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
    }
}
//::////////////////////////////////////////////////////////////////////////////
