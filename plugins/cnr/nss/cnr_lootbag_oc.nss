/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_lootbag_oc
//
//  Desc:  This is the OnClose event handler for
//         the CMD merchant's loot bag.
//
//  Author: David Bobeck (aka Festyx) 25Jan04
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void CheckIfLootbagCloseDuetoMove(object oUser, object oMerchant)
{
  location lastLoc = GetLocalLocation(oUser, "LastLocation");
  if (GetDistanceBetweenLocations(GetLocation(oUser), lastLoc) < 0.5)
  {
    AssignCommand(oMerchant, ActionStartConversation(oUser, "cnr_c_merchant2", TRUE));
  }
}

void main()
{
  object oUser = GetLastClosedBy();
  object oMerchant = GetLocalObject(OBJECT_SELF, "CmdMerchant");

  if (GetIsObjectValid(oMerchant))
  {
    if (GetIsObjectValid(oUser) && GetIsPC(oUser))
    {
      // give the PC a chance to move before testing their location
      AssignCommand(oMerchant, DelayCommand(0.5, CheckIfLootbagCloseDuetoMove(oUser, oMerchant)));
    }
  }

  CmdDestroyLootBag(OBJECT_SELF, TRUE);
}
