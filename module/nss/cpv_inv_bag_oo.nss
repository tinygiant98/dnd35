/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_inv_bag_oo
//
//  Desc:  This is the OnOpen event handler for
//         the CPV vendor's inventory bag.
//
//  Author: David Bobeck 20Jan04
//
/////////////////////////////////////////////////////////
#include "cpv_vendor_utils"


void main()
{
  object oUser = GetLastOpenedBy();
  object oInventoryBag = OBJECT_SELF;
  object oVendor = GetLocalObject(OBJECT_SELF, "CpvVendor");

  // get the PC's location so that we can skip the convo if they walk away
  SetLocalLocation(oUser, "LastLocation", GetLocation(oUser));
}
