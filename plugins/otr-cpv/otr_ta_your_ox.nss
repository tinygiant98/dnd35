/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_your_ox
//
//  Desc:  Should the "what command" greeting be shown.
//
//  Author: David Bobeck 16Sep03
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
      return FALSE;
    }

    string sKeyToRoute = OtrGetPersistentString(oModule, sOxId + "_KeyToRoute");
    string sDestAreaTag = GetLocalString(oModule, sKeyToRoute + "_DestArea");
    object oDestArea = GetObjectByTag(sDestAreaTag);
    string sName = "unknown area";
    if (oDestArea != OBJECT_INVALID)
    {
      sName = GetName(oDestArea);
    }
    SetCustomToken(27333, sName);
    return TRUE;
  }
  return FALSE;
}
