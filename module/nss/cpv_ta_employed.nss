/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_employed
//
//  Desc:  Condition check
//
//  Author: David Bobeck 10Aug03
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
    return TRUE;
  }
  return FALSE;
}
