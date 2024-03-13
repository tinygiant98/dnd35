/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_top
//
//  Desc:  Init's the trader's top menu page
//
//  Author: David Bobeck 12Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nMenuPage = GetLocalInt(oPC, "nOtrMenuPage");
  OtrShowRouteMenu(nMenuPage);
  string sTokenText = GetLocalString(oPC, "sOtrTokenText22000");
  SetCustomToken(22000, sTokenText);
  DeleteLocalString(oPC, "sOtrTokenText22000");
  return TRUE;
}
