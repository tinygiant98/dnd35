// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S0_SummShad02
//::////////////////////////////////////////////////////////////////////////////
/*
   Spell calls a powerful ally from the shadow plane to battle for the wizard.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//::////////////////////////////////////////////////////////////////////////////
#include "x2_inc_spellhook"
//::////////////////////////////////////////////////////////////////////////////
void HCR_RemoveSummonMonster(object oAC)
{
  DestroyObject(oAC);
  string sMsg = "The shadow returns to its home plane, it's ";
  sMsg += "far too powerful for you to retain control.";
  SendMessageToPC(OBJECT_SELF, sMsg);
}
//::////////////////////////////////////////////////////////////////////////////
void HCR_CheckSummonStrength()
{
  object oAC = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
  if (GetIsObjectValid(oAC))
    {
     int nAHD = GetHitDice(oAC);
     int nMCL = GetCasterLevel(OBJECT_SELF);
     if ((nAHD > (nMCL+4)))
       { HCR_RemoveSummonMonster(oAC); }
     else if (nAHD > nMCL)
       {
        float fDelay = IntToFloat(240-((nAHD-nMCL)*60));
        DelayCommand(fDelay, HCR_RemoveSummonMonster(oAC));
       }
    }
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  // If code within the PreSpellCastHook reports FALSE, do not run this spell.
  if (!X2PreSpellCastCode()) { return; }

  // Set the summoned undead to the appropriate template based on the caster level.
  effect eSum;
  int nLvl = GetLevelByClass(CLASS_TYPE_CLERIC);
  if (nLvl <= 7)
    { eSum = EffectSummonCreature("NW_S_SHADOW", VFX_FNF_SUMMON_UNDEAD); }
  else if ((nLvl >= 8) && (nLvl <= 10))
    { eSum = EffectSummonCreature("NW_S_SHADMASTIF", VFX_FNF_SUMMON_UNDEAD); }
  else if ((nLvl >= 11) && (nLvl <= 14))
    { eSum = EffectSummonCreature("NW_S_SHFIEND", VFX_FNF_SUMMON_UNDEAD); }
  else if ((nLvl >= 15))
    { eSum = EffectSummonCreature("NW_S_SHADLORD", VFX_FNF_SUMMON_UNDEAD); }

  // Apply VFX impact and summon effect.
  location lLoc = GetSpellTargetLocation();
  float fDur = HoursToSeconds(24);
  ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSum, lLoc, fDur);

  // If real familiars are used, compare the hitdice of the summoned creature to
  // the caster of this spell. If the hitdie is too high, remove the summoned
  // creature from service. Note: This only effects PC's, not NPC's or DM's.
  if (GetLocalInt(GetModule(), "REALFAM") == TRUE)
    {
     if (GetIsPC(OBJECT_SELF) &&
        !GetIsDM(OBJECT_SELF) &&
        !GetIsDMPossessed(OBJECT_SELF))
       { HCR_CheckSummonStrength(); }
    }
}
//::////////////////////////////////////////////////////////////////////////////
