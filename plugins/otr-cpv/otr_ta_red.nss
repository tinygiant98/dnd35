/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_red
//
//  Desc:  Checks if the route on the menu should
//         be displayed as red. (if the PC does not
//         have the appropriate items)
//
//  Author: David Bobeck 12Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nOffset = GetLocalInt(oPC, "nOtrRedOffset");
  SetLocalInt(oPC, "nOtrRedOffset", nOffset+1);
  int bShowIt = OtrShowRouteAsRed(nOffset);
  if (bShowIt == TRUE)
  {
    string sTokenText = GetLocalString(oPC, "sOtrTokenText" + IntToString(22000+nOffset));
    SetCustomToken(22000+nOffset, sTokenText);
    DeleteLocalString(oPC, "sOtrTokenText" + IntToString(22000+nOffset));
  }
  return bShowIt;
}
