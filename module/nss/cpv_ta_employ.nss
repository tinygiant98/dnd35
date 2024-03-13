/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_employ
//
//  Desc:  Condition check
//
//  Author: David Bobeck 10Aug03
//
/////////////////////////////////////////////////////////
#include "cpv_persist_inc"

int StartingConditional()
{
  int bPlayerVendor = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvEnabled");
  if (bPlayerVendor == TRUE)
  {
    string sEmployer = CpvGetPersistentString(GetModule(), GetTag(OBJECT_SELF) + "_CpvEmployer");
    if (sEmployer == "") return TRUE;
  }

  // If not in CPV mode, then always hide this convo option
  return FALSE;
}
