/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_hungry
//
//  Desc:  Should the "this ox is hungry" greeting be shown.
//
//  Author: David Bobeck 24Sep03
//
/////////////////////////////////////////////////////////
#include "otr_persist_inc"

int StartingConditional()
{
  object oModule = GetModule();
  object oPC = GetPCSpeaker();
  if (!GetIsPC(oPC)) return FALSE;

  string sPcKey = GetPCPublicCDKey(oPC);
  string sPcName = GetName(oPC);
  string sKey = sPcKey + "_" + sPcName;

  string sOxId = GetLocalString(OBJECT_SELF, "OtrOxId");
  string sOwnerKey = OtrGetPersistentString(oModule, sOxId + "_OwnerKey");
  if (sOwnerKey == sKey)
  {
    int nHunger = OtrGetPersistentInt(oModule, sOxId + "_Hunger");
    if (nHunger == 0)
    {
      return TRUE;
    }
  }
  return FALSE;
}
