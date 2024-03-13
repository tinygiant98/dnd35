/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_m_red
//
//  Desc:  Checks if the item on the menu should
//         be displayed as red. (if it's not on the PC)
//
//  Author: David Bobeck 12Dec02
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nOffset = GetLocalInt(oPC, "nCnrRedOffset");
  SetLocalInt(oPC, "nCnrRedOffset", nOffset+1);
  int bShowIt = CnrMerchantShowAsRed(OBJECT_SELF, nOffset);
  if (bShowIt == TRUE)
  {
    string sTokenText = GetLocalString(oPC, "sCnrTokenText" + IntToString(27000+nOffset));
    SetCustomToken(27000+nOffset, sTokenText);
    DeleteLocalString(oPC, "sCnrTokenText" + IntToString(27000+nOffset));
  }
  return bShowIt;
}
