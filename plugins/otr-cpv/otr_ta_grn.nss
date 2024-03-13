/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_grn
//
//  Desc:  Checks if the route on the menu should
//         be displayed as green. (if the PC has all
//         the appropriate items)
//
//  Author: David Bobeck 12Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nOffset = GetLocalInt(oPC, "nOtrGrnOffset");
  SetLocalInt(oPC, "nOtrGrnOffset", nOffset+1);
  int bShowIt = OtrShowRouteAsGreen(nOffset);
  if (bShowIt == TRUE)
  {
    string sTokenText = GetLocalString(oPC, "sOtrTokenText" + IntToString(22000+nOffset));
    SetCustomToken(22000+nOffset, sTokenText);
    DeleteLocalString(oPC, "sOtrTokenText" + IntToString(22000+nOffset));
  }
  return bShowIt;
}
