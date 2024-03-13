
#include "cpv_vendor_utils"

void TestIfShopIsOpen(object oMerchant)
{
  if (CpvGetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvShopIsOpen") != TRUE)
  {
    DelayCommand(0.2f, TestIfShopIsOpen(oMerchant));
  }
  else
  {
    ActionSpeakString(CPV_TEXT_MY_SHOP_IS_OPEN);
    CpvSetPersistentLocation(GetModule(), GetTag(oMerchant) + "_CpvShopLoc", GetLocation(oMerchant));
  }
}

void main()
{
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvFollowing", FALSE);

  // Test if shops are permitted in this area
  int bVendorPermitted = FALSE;
  if (CPV_BOOL_VENDORS_MUST_BE_PERMITTED)
  {
    int bAreaPermitsPlayerVendors = GetLocalInt(GetArea(OBJECT_SELF), "AreaPermitsPlayerVendors");
    bAreaPermitsPlayerVendors |= GetLocalInt(OBJECT_SELF, "AreaPermitsPlayerVendors");
    if (bAreaPermitsPlayerVendors)
    {
      bVendorPermitted = TRUE;
    }
  }
  else
  {
    bVendorPermitted = TRUE;
  }

  if (bVendorPermitted)
  {
    CpvOpenShop(OBJECT_SELF);
    TestIfShopIsOpen(OBJECT_SELF);
  }
  else
  {
    ActionSpeakString(CPV_TEXT_I_WONT_WORK_HERE);
  }
}
