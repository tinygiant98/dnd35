/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_m_top
//
//  Desc:  Init's the merchant's top menu page
//
//  Author: David Bobeck 23Dec02
//
/////////////////////////////////////////////////////////
#include "cpv_vendor_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  SetLocalString(oPC, "sCnrMenuType", "TOP");
  CnrMerchantShowMenu(GetTag(OBJECT_SELF), 0);
  string sTokenText = GetLocalString(oPC, "sCnrTokenText27010");
  SetCustomToken(27010, sTokenText);
  DeleteLocalString(oPC, "sCnrTokenText27010");

  // If not in CPV mode, then always show this convo option
  return TRUE;
}
