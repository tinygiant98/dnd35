/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_route_init
//
//  Desc:  Route initialization. This script is
//         executed from "otr_module_oml".
//
//  Author: David Bobeck 12Sep03, Ondaderthad Dec03
//          Morgan Quickthrust Mar04
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"

/////////////////////////////////////////////////////////
void main()
{
  PrintString("otr_route_init");

  // The newline char for use in convo dialogs since
  // carriage returns produce ugly boxes.
  SetCustomToken(500, "\n");

  // Module builders: You should add your trade routes
  // to the file "user_route_init" so that future versions
  // of OTR don't over-write your work.
  ExecuteScript("user_route_init", OBJECT_SELF);

  ////////////////////////////////////////////////////
  // The following is for example only              //
  ////////////////////////////////////////////////////

  //string sKeyToRoute;

// Potion 1 - Area001 to the Area002
//  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 7);                                    // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 120, 250);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "NW_IT_MPOTION001", "NW_IT_MPOTION001", 1, "merchant_tag");  // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");                                          // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant
// Apples to CMD - Area001 to the Area002
//  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 150);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 350, 100);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrAppleFruit", "cnrapplefruit", 8, "cmd_benz_food");       // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_UseDestMerch");                                         // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant
// Apples to CPV - Area001 to the Area002
//  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 150);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 350, 100);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrAppleFruit", "cnrapplefruit", 8, "Donan");               // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_UseDestMerch");                                         // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant
// Copper Ingots 1 - Area001 to the Area002
//  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 310);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 500, 100);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrIngotCopp", "cnringotcopp", 12, "merchant_tag");         // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");                                          // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant
// Hickory Branch 1  - Area001 to the Area002
//  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 300);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 668, 120);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrBranchHic", "cnrbranchhic", 10, "merchant_tag");         // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");                                          // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant
// Cotton 1 - Area001 to the Area002
//  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 650);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 955, 120);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrCotton", "cnrcotton", 25, "merchant_tag");               // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");                                          // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant

// Sugar 1 - Area002 to the Area001
//  sKeyToRoute = OtrCreateRoute("Area002", "Area001", 600);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 912, 100);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrSugar", "cnrsugar", 30, "merchant_tag");                 // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");                                          // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant
// Eggs 1 - Area002 to the Area001
//  sKeyToRoute = OtrCreateRoute("Area002", "Area001", 150);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 400, 100);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrChickenEgg", "cnrchickenegg", 12, "merchant_tag");       // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");                                          // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant
// Corn Meal 1 - Area002 to the Area001
//  sKeyToRoute = OtrCreateRoute("Area002", "Area001", 180);                                  // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 353, 100);                                                 // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrCornMeal", "cnrcornmeal", 6, "merchant_tag");            // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");                                          // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant

// Tools Pack
//  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 150);                                 // start, dest, cost
//  OtrSetRoutePayoff(sKeyToRoute, 2147, 120);                                               // gold, xp
//  OtrAddRouteItem(sKeyToRoute, "cnrWoodCutterAxe", "cnrwoodcutteraxe", 1, "merchant_tag"); // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrSmithsHammer", "cnrsmithshammer", 1, "merchant_tag");   // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrSkinningKnife", "cnrskinningknife", 1, "merchant_tag"); // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrShovel", "cnrshovel", 1, "merchant_tag");               // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrSewingKit", "cnrsewingkit", 1, "merchant_tag");         // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrTinkersTools", "cnrtinkerstools", 1, "merchant_tag");   // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrGemTools", "cnrgemtools", 1, "merchant_tag");           // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrCarpsTools", "cnrcarpstools", 1, "merchant_tag");       // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "cnrGemChisel", "cnrgemchisel", 1, "merchant_tag");         // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "bedroll", "bedroll", 1, "merchant_tag");                   // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrAddRouteItem(sKeyToRoute, "WaterCanteen", "watercanteen", 1, "merchant_tag");         // item tag, item resref, qty, Destination CMD or CPV Merchant Tag
//  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");
}
