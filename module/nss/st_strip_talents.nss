// HCR v3.2.0 - Re-Added spell track code to base.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  st_strip_talents
//::////////////////////////////////////////////////////////////////////////////
/*
   Spell Tracking System by Archaegeo - December 2002 - Purpose: Strips an
  entering player of all spells that they have previously cast since resting.
*/
//::////////////////////////////////////////////////////////////////////////////
void DecrementTalentIndex(int iIndex, object oPC)
{
  int nSpellToFeat = 0;
  talent tSpell = TalentSpell(iIndex);
  if (GetIsTalentValid(tSpell))
    {
     int nSpl   = GetIdFromTalent(tSpell);
     string sID = GetName(oPC) + GetPCPlayerName(oPC);
     int nCast  = GetLocalInt(GetModule(), "SPTRK" + sID + IntToString(nSpl));
     if (nCast && GetHasSpell(GetIdFromTalent(tSpell), oPC))
       {
        while (nCast)
          {
           DecrementRemainingSpellUses(oPC, nSpl);
           nCast--;
          }
       }
     else if (nCast)
       {
        switch(nSpl)
          {
           case 313: nSpellToFeat = FEAT_LAY_ON_HANDS;    break;
           case 317: nSpellToFeat = FEAT_ANIMAL_COMPANION;   break;
           case 383: nSpellToFeat = FEAT_DEATH_DOMAIN_POWER; break;
           case 307: nSpellToFeat = FEAT_BARBARIAN_RAGE;  break;
           case 308: nSpellToFeat = FEAT_TURN_UNDEAD;     break;
           case 318: nSpellToFeat = FEAT_SUMMON_FAMILIAR; break;
           case 397: nSpellToFeat = FEAT_ELEMENTAL_SHAPE; break;
           case 398: nSpellToFeat = FEAT_ELEMENTAL_SHAPE; break;
           case 399: nSpellToFeat = FEAT_ELEMENTAL_SHAPE; break;
           case 400: nSpellToFeat = FEAT_ELEMENTAL_SHAPE; break;
           case 401: nSpellToFeat = FEAT_WILD_SHAPE; break;
           case 402: nSpellToFeat = FEAT_WILD_SHAPE; break;
           case 403: nSpellToFeat = FEAT_WILD_SHAPE; break;
           case 404: nSpellToFeat = FEAT_WILD_SHAPE; break;
           case 405: nSpellToFeat = FEAT_WILD_SHAPE; break;
           case 418: nSpellToFeat = FEAT_BARD_SONGS; break;
           default:  nSpellToFeat = 0;
          }

        while (nCast)
          {
           DecrementRemainingFeatUses(oPC, nSpellToFeat);
           nCast--;
          }
       }
    }
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  int iIndex;
  object oPC = OBJECT_SELF;
  for (iIndex = 1; iIndex < 1000; iIndex++)
    { DecrementTalentIndex(iIndex, oPC); }
}
//::////////////////////////////////////////////////////////////////////////////
