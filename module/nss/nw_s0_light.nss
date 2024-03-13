// HCR v3.2.0 - Added Burn Torch time to computed duration.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S0_Light
//::////////////////////////////////////////////////////////////////////////////
/*
   Applies a light source to the target for 1 hour per level.

   XP2
    - If cast on an item, item will get temporary property "light" for the
     duration of the spell. Brightness on an item is lower than on the continual
     light version.

*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:: Updated On: 2003-06-05 - Added XP2 cast on item code - Georg Z.
//::////////////////////////////////////////////////////////////////////////////
#include "x2_inc_spellhook"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  // If code within the PreSpellCastHook reports FALSE, do not run this spell.
  if (!X2PreSpellCastCode()) { return; }

  // Declare major variables.
  object oTarget = GetSpellTargetObject();
  int nDuration = GetCasterLevel(OBJECT_SELF);
  int nMetaMagic = GetMetaMagicFeat();
  float fDuration;

  // Handle spell cast on item....
  if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM && ! CIGetIsCraftFeatBaseItem(oTarget))
    {
     // Do not allow casting on unequippable items.
     if (!IPGetIsItemEquipable(oTarget))
       {
        FloatingTextStrRefOnCreature(83326,OBJECT_SELF);
        return;
       }

     // Remove previous casting of light.
     itemproperty ip = ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL, IP_CONST_LIGHTCOLOR_WHITE);
     if (GetItemHasItemProperty(oTarget, ITEM_PROPERTY_LIGHT))
       { IPRemoveMatchingItemProperties(oTarget, ITEM_PROPERTY_LIGHT, DURATION_TYPE_TEMPORARY); }

     // Enter Metamagic conditions.
     if (nMetaMagic == METAMAGIC_EXTEND)
       { nDuration = (nDuration*2); }

     // Determine duration.
     float fBurn = IntToFloat(GetLocalInt(GetModule(), "BURNTORCH"));
     if (fBurn > 0.0)
       { fDuration = ((fBurn*HoursToSeconds(nDuration))/6.0); }
     else
       { fDuration = HoursToSeconds(nDuration); }

     // Apply the item property.
     AddItemProperty(DURATION_TYPE_TEMPORARY, ip, oTarget, fDuration);
    }
  else
    {
     effect eVis  = EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20);
     effect eDur  = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
     effect eLink = EffectLinkEffects(eVis, eDur);

     // Fire cast spell at event for the specified target.
     SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHT, FALSE));

     // Enter Metamagic conditions.
     if (nMetaMagic == METAMAGIC_EXTEND)
       { nDuration = (nDuration*2); }

     // Determine duration.
     float fBurn = IntToFloat(GetLocalInt(GetModule(), "BURNTORCH"));
     if (fBurn > 0.0)
       { fDuration = ((fBurn*HoursToSeconds(nDuration))/6.0); }
     else
       { fDuration = HoursToSeconds(nDuration); }

     // Apply the VFX impact and effects.
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    }
}
//::////////////////////////////////////////////////////////////////////////////
