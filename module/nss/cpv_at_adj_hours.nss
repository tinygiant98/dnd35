/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_at_adj_hours
//
//  Desc:  Convo action taken when the player
//         selects "I want to alter your contract"
//
//  Author: David Bobeck 22Aug03
//
/////////////////////////////////////////////////////////
#include "cpv_persist_inc"

void main()
{
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvShopIsOpen", FALSE);
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvFollowing", FALSE);

  object oPC = GetPCSpeaker();
  SetLocalString(oPC, "CpvConfigType", "HOURS");

  int nDaysContracted = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvDaysContracted");
  SetLocalInt(OBJECT_SELF, "CpvDaysAdjusted", nDaysContracted);
}
