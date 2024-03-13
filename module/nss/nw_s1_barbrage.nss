// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S1_BarbRage
//::////////////////////////////////////////////////////////////////////////////
/*
   The Str and Con of the Barbarian increases, Will Save are +2, AC -2. Greater
  Rage starts at level 15.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//::////////////////////////////////////////////////////////////////////////////
#include "x2_i0_spells"
#include "hc_inc"
//::////////////////////////////////////////////////////////////////////////////


// % movement rate decrease.
const int MOVE_PENALTY = 20;


//::////////////////////////////////////////////////////////////////////////////
void RageWearsOff(object oPC, effect eEffect)
{
  int nCHP = GetCurrentHitPoints(oPC);
  int nState = GPS(oPC);
  if ((nState == PWS_PLAYER_STATE_DYING ||
       nState == PWS_PLAYER_STATE_STABLE) && nCHP > -1)
    {
     effect eDam = EffectDamage(nCHP + 1);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC);
     SPS(oPC, PWS_PLAYER_STATE_DYING);
     ExecuteScript("hc_bleeding", oPC);
     return;
    }

  if (GetIsInCombat(oPC))
    {
     if (!GetLocalInt(oPC, "RAGED"))
       {
        SendMessageToPC(oPC, "You are now fatigued because of raging.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, SupernaturalEffect(eEffect), oPC);
        SetLocalInt(oPC, "RAGED", TRUE);
       }
    }
  else
    {
     RemoveEffect(oPC, eEffect);
     DeleteLocalInt(oPC, "RAGED");
     return;
    }

  DelayCommand(6.0, RageWearsOff(oPC, eEffect));
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  if (!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
    {
     //Declare major variables
     int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
     int nIncrease;
     int nSave;
     if (nLevel < 15)
       {
        nIncrease = 4;
        nSave = 2;
       }
     else
       {
        nIncrease = 6;
        nSave = 3;
       }

     PlayVoiceChat(VOICE_CHAT_BATTLECRY1);

     // Determine the duration by getting the con modifier after being modified.
     int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION) + nIncrease;
     effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nIncrease);
     effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);
     effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
     effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);
     effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
     effect eLink = EffectLinkEffects(eCon, eStr);
     eLink = EffectLinkEffects(eLink, eSave);
     eLink = EffectLinkEffects(eLink, eAC);
     eLink = EffectLinkEffects(eLink, eDur);

     SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));

     //Make effect extraordinary
     eLink = ExtraordinaryEffect(eLink);

     if (nCon > 0)
       {
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);// Change to the Rage VFX.
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

        // 2003-07-08, Georg: Rage Epic Feat Handling
        CheckAndApplyEpicRageFeats(nCon);

        // Add call for fatigue effects for when rage wears off.
        effect eStrDec = EffectAbilityDecrease(ABILITY_STRENGTH, 2);
        effect eDexDec = EffectAbilityDecrease(ABILITY_DEXTERITY, 2);
        //effect eSlow   = EffectSlow();
        effect eSlow   = EffectMovementSpeedDecrease(MOVE_PENALTY);
        effect eEffect = EffectLinkEffects(eDexDec, eStrDec);
        eEffect = EffectLinkEffects(eEffect, eSlow);
        DelayCommand(RoundsToSeconds(nCon) + 1.0, RageWearsOff(OBJECT_SELF, eEffect));
       }
    }
}
//::////////////////////////////////////////////////////////////////////////////
