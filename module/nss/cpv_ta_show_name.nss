/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_show_name
//
//  Desc:  Condition check
//
//  Author: David Bobeck 14Nov03
//
/////////////////////////////////////////////////////////
#include "cpv_persist_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sEmployer = CpvGetPersistentString(GetModule(), GetTag(OBJECT_SELF) + "_CpvEmployer");
  string sPcKey = GetPCPublicCDKey(oPC);
  string sPcName = GetName(oPC);
  if ( (sEmployer == sPcKey + "_" + sPcName) || GetIsDM(oPC) )
  {
    int bShowName = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvShowName");
    if (!bShowName)
    {
      return TRUE;
    }
  }
  return FALSE;
}

