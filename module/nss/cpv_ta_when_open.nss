/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_when_open
//
//  Desc:  Checks if the vendor CMD options should
//         be displayed or not.
//
//  Author: David Bobeck 12Aug03
//
/////////////////////////////////////////////////////////
#include "cpv_persist_inc"

int StartingConditional()
{
  int bPlayerVendor = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvEnabled");
  if (bPlayerVendor == TRUE)
  {
    return CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvShopIsOpen");
  }
  
  // If not in CPV mode, then always show this convo option
  return TRUE;
}

