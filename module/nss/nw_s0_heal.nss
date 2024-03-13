// HCR v3.2.0 - Removed Wild Magic. Added spell hook and HOTU code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S0_Heal
//::////////////////////////////////////////////////////////////////////////////
/*
   Heals the target to full unless they are undead. If undead, they are reduced
  to 1d4 HP.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:: Updated On: Aug  1, 2001 - Preston W.
//::////////////////////////////////////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
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

  // Check to see if the target is an undead.
  object oTarget = GetSpellTargetObject();
  int nCHP = GetCurrentHitPoints(oTarget);
  if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
     if (!GetIsReactionTypeFriendly(oTarget))
       {
        // Fire cast spell at event for the specified target.
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));

        // Make a touch attack.
        if (TouchAttackMelee(oTarget) > 0)
          {
           // Make SR check.
           if (!MyResistSpell(OBJECT_SELF, oTarget))
             {
              // Determine the amount of damage to inflict.
              int nModify;
              int nMetaMagic = GetMetaMagicFeat();
              if (nMetaMagic == METAMAGIC_MAXIMIZE)
                { nModify = 1; }
              else
                { nModify = d4(); }
              int nDam = (nCHP - nModify);

              // Set the damage visual and effect.
              effect eVis1 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
              effect eKill = EffectDamage(nDam, DAMAGE_TYPE_POSITIVE);

              // Apply the damage visual and effect.
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oTarget);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
             }
          }
       }
    }
  else
    {
     // Fire cast spell at event for the specified target.
     SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));

     // Figure out how much to heal.
     int nHeal;
     int nMHP = GetMaxHitPoints(oTarget);
     if (nCHP < 0)
       { nHeal = (abs(nCHP) + nMHP); }
     else
       { nHeal = (nMHP - nCHP); }

     // Set the heal visual and effect.
     effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_X);
     effect eHeal = EffectHeal(nHeal);

     // Apply the heal visual and effect.
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}
//::////////////////////////////////////////////////////////////////////////////
