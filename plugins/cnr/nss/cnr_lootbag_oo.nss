/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_lootbag_oo
//
//  Desc:  This is the OnOpen event handler for
//         the CMD merchant's loot bag.
//
//  Author: David Bobeck (aka Festyx) 25Jan04
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void main()
{
  object oUser = GetLastOpenedBy();

  // get the PC's location so that we can skip the convo if they walk away
  SetLocalLocation(oUser, "LastLocation", GetLocation(oUser));

  // if the lootbag is opened by another player, close it immediately
  if (oUser != GetLocalObject(OBJECT_SELF, "CmdCustomer"))
  {
    CmdDestroyLootBag(OBJECT_SELF, TRUE);
    return;
  }
}
