// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S0_Summon
//::////////////////////////////////////////////////////////////////////////////
/*
   Carries out the summoning of the appropriate creature for the Summon Monster
  Series of spells 1 to 9.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//::////////////////////////////////////////////////////////////////////////////
#include "hc_inc_summon"
#include "x2_inc_spellhook"
//::////////////////////////////////////////////////////////////////////////////

//
effect GetSummonEffect(int nSpellID);

//::////////////////////////////////////////////////////////////////////////////
void main()
{
  // If code within the PreSpellCastHook reports FALSE, do not run this spell.
  if (!X2PreSpellCastCode()) { return; }

  // Determine base duration.
  object oMod  = GetModule();
  int nLevel   = GetCasterLevel(OBJECT_SELF);
  int nSummon  = GetLocalInt(oMod, "SUMMONTIME");
  int nDuration;
  if (nSummon > 0)
    { nDuration = ((nLevel * nSummon) + 2); }
  else
    { nDuration = 24; }

  // Check for Meta-Magic extend.
  int nMetaMagic = GetMetaMagicFeat();
  if (nMetaMagic == METAMAGIC_EXTEND)
    { nDuration = (nDuration*2); }

  // Apply the VFX impact and summon effect.
  int nSpellID   = GetSpellId();
  effect eSummon = GetSummonEffect(nSpellID);
  location lLoc  = GetSpellTargetLocation();
  float fDuration;
  if (nSummon > 0)
    { fDuration = RoundsToSeconds(nDuration); }
  else
    { fDuration = HoursToSeconds(nDuration); }

  ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lLoc, fDuration);
}
//::////////////////////////////////////////////////////////////////////////////
effect GetSummonEffect(int nSpellID)
{
  int nFNF_Effect;
  int nRoll = d3();
  string sSummon;
  if (GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER))// WITH THE ANIMAL DOMAIN.
    {
     if (nSpellID == SPELL_SUMMON_CREATURE_I)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
        sSummon = pick_creature(2);
        if (sSummon == "")
          { sSummon = "NW_S_BOARDIRE"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_II)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
        sSummon = pick_creature(3);
        if (sSummon == "")
          { sSummon = "NW_S_WOLFDIRE"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_III)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
        sSummon = pick_creature(4);
        if (sSummon == "")
          { sSummon = "NW_S_SPIDDIRE"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_IV)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
        sSummon = pick_creature(5);
        if (sSummon == "")
          { sSummon = "NW_S_beardire"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_V)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
        sSummon = pick_creature(6);
        if (sSummon == "")
          { sSummon = "NW_S_diretiger"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_VI)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        sSummon = pick_creature(7);
        if (sSummon == "")
          {
           switch (nRoll)
             {
              case 1: sSummon = "NW_S_AIRHUGE";   break;
              case 2: sSummon = "NW_S_WATERHUGE"; break;
              case 3: sSummon = "NW_S_FIREHUGE";  break;
             }
          }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_VII)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        sSummon = pick_creature(8);
        if (sSummon == "")
          {
           switch (nRoll)
             {
              case 1: sSummon = "NW_S_AIRGREAT";   break;
              case 2: sSummon = "NW_S_WATERGREAT"; break;
              case 3: sSummon = "NW_S_FIREGREAT";  break;
             }
          }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_VIII)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        sSummon = pick_creature(9);
        if (sSummon == "")
          {
           switch (nRoll)
             {
              case 1: sSummon = "NW_S_AIRELDER";   break;
              case 2: sSummon = "NW_S_WATERELDER"; break;
              case 3: sSummon = "NW_S_FIREELDER";  break;
             }
          }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_IX)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        sSummon = pick_creature(9);
        if (sSummon == "")
          {
           switch (nRoll)
             {
              case 1: sSummon = "NW_S_AIRELDER";   break;
              case 2: sSummon = "NW_S_WATERELDER"; break;
              case 3: sSummon = "NW_S_FIREELDER";  break;
             }
          }
       }
    }
  else// WITOUT THE ANIMAL DOMAIN.
    {
     if (nSpellID == SPELL_SUMMON_CREATURE_I)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
        sSummon = pick_creature(1);
        if (sSummon == "")
          { sSummon = "NW_S_badgerdire"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_II)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
        sSummon = pick_creature(2);
        if (sSummon == "")
          { sSummon = "NW_S_BOARDIRE"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_III)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
        sSummon = pick_creature(3);
        if (sSummon == "")
          { sSummon = "NW_S_WOLFDIRE"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_IV)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
        sSummon = pick_creature(4);
        if (sSummon == "")
          { sSummon = "NW_S_SPIDDIRE"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_V)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
        sSummon = pick_creature(5);
        if (sSummon == "")
          { sSummon = "NW_S_beardire"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_VI)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
        sSummon = pick_creature(6);
        if (sSummon == "")
          { sSummon = "NW_S_diretiger"; }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_VII)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        sSummon = pick_creature(7);
        if (sSummon == "")
          {
           switch (nRoll)
             {
              case 1: sSummon = "NW_S_AIRHUGE";   break;
              case 2: sSummon = "NW_S_WATERHUGE"; break;
              case 3: sSummon = "NW_S_FIREHUGE";  break;
             }
          }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_VIII)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        sSummon = pick_creature(8);
        if (sSummon == "")
          {
           switch (nRoll)
             {
              case 1: sSummon = "NW_S_AIRGREAT";   break;
              case 2: sSummon = "NW_S_WATERGREAT"; break;
              case 3: sSummon = "NW_S_FIREGREAT";  break;
             }
          }
       }
     else if (nSpellID == SPELL_SUMMON_CREATURE_IX)
       {
        nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
        sSummon = pick_creature(9);
        if (sSummon == "")
          {
           switch (nRoll)
             {
              case 1: sSummon = "NW_S_AIRELDER";   break;
              case 2: sSummon = "NW_S_WATERELDER"; break;
              case 3: sSummon = "NW_S_FIREELDER";  break;
             }
          }
       }
    }

  //effect eVis = EffectVisualEffect(nFNF_Effect);
  //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
  effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
  return eSummonedMonster;
}
//::////////////////////////////////////////////////////////////////////////////
