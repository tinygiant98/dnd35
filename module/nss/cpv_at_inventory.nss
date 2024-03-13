/////////////////////////////////////////////////////////
//
//  Craftable Player Vendors (CPV) by Festyx
//
//  Name:  cpv_at_inventory
//
//  Desc:  Adjust the vendor's inventory.
//
//  Author: David Bobeck 28Jul03
//
/////////////////////////////////////////////////////////
#include "cpv_vendor_utils"

/////////////////////////////////////////////////////////
void TestIfVendorSubMenusAreInitialized(object oMerchant, object oPC)
{
  int nStackCount = CmdGetStackCount(oMerchant, "CpvInitializeVendorSubMenus");
  if (nStackCount > 0)
  {
    DelayCommand(0.2f, TestIfVendorSubMenusAreInitialized(oMerchant, oPC));
  }
  else
  {
    CmdInitializeDeferredMerchantData(oMerchant);
    AssignCommand(oMerchant, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
  }
}

void main()
{
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvShopIsOpen", FALSE);
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvFollowing", FALSE);

  object oPC = GetPCSpeaker();
  SetLocalString(oPC, "sCnrMenuType", "CPV");
  SetLocalString(oPC, "sCnrCurrentMenu", "CPV"+GetTag(OBJECT_SELF));
  SetLocalInt(oPC, "nCnrMenuPage", 0);

  // CpvInitializeVendor is asynchronous - it uses AssignCommand to avoid TMI
  CmdSetStackCount(OBJECT_SELF, 1, "CpvInitializeVendorSubMenus");
  CpvInitializeVendorSubMenus(GetTag(OBJECT_SELF), OBJECT_SELF);

  // wait until initialization is done before continuing
  TestIfVendorSubMenusAreInitialized(OBJECT_SELF, oPC);
}
