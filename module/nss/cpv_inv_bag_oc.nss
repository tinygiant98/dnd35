/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_inv_bag_oc
//
//  Desc:  This is the OnClosed event handler for
//         the CPV vendor's inventory bag.
//
//  Author: David Bobeck 20Jan04
//
/////////////////////////////////////////////////////////
#include "cpv_vendor_utils"

void LoopWhileClosingInventoryBag(object oInventoryBag, object oUser, int bResumeConvo)
{
  int nStackCount = CmdGetStackCount(oUser, "CpvCloseInventoryBagCount");
  if (nStackCount != 0)
  {
    AssignCommand(OBJECT_SELF, LoopWhileClosingInventoryBag(oInventoryBag, oUser, bResumeConvo));
  }
  else
  {
    // Destroy the container too
    DestroyObject(oInventoryBag);

    if (bResumeConvo)
    {
      if (GetIsObjectValid(oUser) && GetIsPC(oUser))
      {
        ActionStartConversation(oUser, "cnr_c_merchant2", TRUE);
      }
    }
  }
}

void CheckIfInventoryBagCloseDuetoMove(object oUser, object oVendor, object oInventoryBag)
{
  location lastLoc = GetLocalLocation(oUser, "LastLocation");
  if (GetDistanceBetweenLocations(GetLocation(oUser), lastLoc) > 0.5)
  {
    // close but don't start convo
    AssignCommand(oVendor, LoopWhileClosingInventoryBag(oInventoryBag, oUser, FALSE));
  }
  else
  {
    // close and start convo
    AssignCommand(oVendor, LoopWhileClosingInventoryBag(oInventoryBag, oUser, TRUE));
  }
}

void main()
{
  object oUser = GetLastClosedBy();
  object oInventoryBag = OBJECT_SELF;
  object oVendor = GetLocalObject(OBJECT_SELF, "CpvVendor");

  if (GetIsObjectValid(oUser) && GetIsPC(oUser))
  {
    CmdSetStackCount(oUser, 1, "CpvCloseInventoryBagCount");
    CpvCloseInventoryBag(oInventoryBag, oUser);
    if (GetIsObjectValid(oVendor))
    {
      // give the PC a chance to move before testing their location
      AssignCommand(oVendor, DelayCommand(0.5, CheckIfInventoryBagCloseDuetoMove(oUser, oVendor, oInventoryBag)));
    }
  }
}
