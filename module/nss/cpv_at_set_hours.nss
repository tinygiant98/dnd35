/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_at_set_hours
//
//  Desc:  Convo action taken when the player
//         selects "Continue".
//
//  Author: David Bobeck 22Aug03
//
/////////////////////////////////////////////////////////
#include "cpv_vendor_utils"

void main()
{
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvFollowing", FALSE);

  object oPC = GetPCSpeaker();

  int nDaysContracted = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvDaysContracted");
  int nDaysAdjusted = GetLocalInt(OBJECT_SELF, "CpvDaysAdjusted");
  
  int nDelta = nDaysAdjusted - nDaysContracted;
  int nWagePerDay = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvWage");
  int nFunds = nDelta * nWagePerDay;

  if (nFunds < 0)
  {
    // return gold to the PC
    nFunds = 0 - nFunds; 
    GiveGoldToCreature(oPC, nFunds);
    CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvDaysContracted", nDaysAdjusted);
  }
  else if (nFunds > 0)
  {
    int nGoldAvail = GetGold(oPC);
    if (nGoldAvail >= nFunds)
    {
      TakeGoldFromCreature(nFunds, oPC, TRUE);
      CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvDaysContracted", nDaysAdjusted);
    }
    else
    {
      AssignCommand(OBJECT_SELF, ActionSpeakString(CPV_TEXT_YOU_CANNOT_AFFORD_ME));
    }
  }

  string sEmployer = CpvGetPersistentString(GetModule(), GetTag(OBJECT_SELF) + "_CpvEmployer");
  if (!GetIsDM(oPC) || (GetIsDM(oPC) && (sEmployer == "")))
  {
    string sPcKey = GetPCPublicCDKey(oPC);
    string sPcName = GetName(oPC);
    CpvSetPersistentString(GetModule(), GetTag(OBJECT_SELF) + "_CpvEmployer", sPcKey + "_" + sPcName);
    CpvSetPersistentString(GetModule(), GetTag(OBJECT_SELF) + "_CpvEmployerName", sPcName);
  }

  if (nDaysAdjusted == 0)
  {
    CpvDropAllInventory(OBJECT_SELF);
  }
}
