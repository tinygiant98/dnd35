/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_next
//
//  Desc:  Should the "Next" menu item be shown.
//
//  Author: David Bobeck 12Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oModule = GetModule();
  int nMenuPage = GetLocalInt(oPC, "nOtrMenuPage");

  // this menu must be showing routes
  object oArea = GetArea(oPC);
  int nRouteCount = GetLocalInt(oArea, "OtrAreaRouteCount");

  int bShowNext = TRUE;
  int nLast = (nMenuPage * OTR_SELECTIONS_PER_PAGE) + OTR_SELECTIONS_PER_PAGE;
  if (nLast >= nRouteCount)
  {
    bShowNext = FALSE;
  }
  return bShowNext;
}
