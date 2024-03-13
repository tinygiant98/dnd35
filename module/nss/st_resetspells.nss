// HCR v3.2.0 - Re-Added spell track code to base.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  st_resetspells
//::////////////////////////////////////////////////////////////////////////////
/*
   Spell Tracking System by Archaegeo - December 2002 - Purpose: Restores a PC's
  spell tracking to none cast, called on a successful rest.
*/
//::////////////////////////////////////////////////////////////////////////////
void DecrementTalentIndex(int iIndex, object oPC)
{
  string sID = GetName(oPC) + GetPCPlayerName(oPC);

  // Check for all spells.
  talent tSpell = TalentSpell(iIndex);
  if (GetIsTalentValid(tSpell))
    {
     if (GetHasSpell(GetIdFromTalent(tSpell), oPC))
       {
        int nSpl = GetIdFromTalent(tSpell);
        DeleteLocalInt(GetModule(), "SPTRK" + sID + IntToString(nSpl));
       }
    }

  // Check for all feats.
  talent tFeat = TalentFeat(iIndex);
  if (GetIsTalentValid(tFeat))
    {
     if (GetHasFeat(GetIdFromTalent(tFeat), oPC))
       {
        int nFt = GetIdFromTalent(tFeat);
        DeleteLocalInt(GetModule(), "SPTRK" + sID + IntToString(nFt));
       }
    }
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  object oPC = OBJECT_SELF;
  int iIndex;
  for (iIndex = 1; iIndex < 1000; iIndex++)
    { DecrementTalentIndex(iIndex, oPC); }
}
//::////////////////////////////////////////////////////////////////////////////
