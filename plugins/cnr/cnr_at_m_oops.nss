/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_at_m_oops
//
//  Desc:  The player has selected a red item on the
//         merchant's menu.
//
//  Author: David Bobeck 17Dec02
//
/////////////////////////////////////////////////////////
#include "cmd_language_inc"

void main()
{
  object oPC = GetPCSpeaker();
  string sMenuType = GetLocalString(oPC, "sCnrMenuType");
  if (sMenuType == "BUY")
  {
    SetLocalString(oPC, "sCnrTokenText27000", CMD_TEXT_YOU_DONT_HAVE_THAT_ITEM + "\n");
  }
  else // "SELL"
  {
    SetLocalString(oPC, "sCnrTokenText27000", CMD_TEXT_SORRY_I_AM_OUT_OF_THAT_ITEM + "\n");
  }
}
