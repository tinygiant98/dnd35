#include "otr_route_utils"

/* Define Custom Oxen Trade Routes
 * TODO
 * - Add correct parameters to OtrSetRouteItem
 On the bright side, the changes are not difficult. But it will be tedious and take sometime if you have a lot of existing OTR Routes setup your module. Here are the changes to your user_route_init file that you will need to make in order to integrate your existing OTR installation with your CMD/CPV merchants...


NEW SETUP

// Potion (No Destination Merchant) - Area001 to Area002
  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 10); // start area, dest area, Route Cost
  OtrSetRoutePayoff(sKeyToRoute, 50, 50);                            // Payoff Gold, Payoff XP
                                    // item tag, item resref, item qty, Destination CMD or CPV Merchant Tag
  OtrAddRouteItem(sKeyToRoute, "NW_IT_MPOTION001", "NW_IT_MPOTION001", 1, "merchant_tag");
  OtrUseDestMerch(sKeyToRoute, "OTR_NoDestMerch");     // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant

// Apples to CMD Merchant - Area001 to Area002
  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 25); // start area, dest area, Route Cost
  OtrSetRoutePayoff(sKeyToRoute, 50, 25);                            // Payoff Gold, Payoff XP
                                   // item tag, item resref, item qty, Destination CMD or CPV Merchant Tag
  OtrAddRouteItem(sKeyToRoute, "cnrAppleFruit", "cnrapplefruit", 8, "cmd_benz_food");
  OtrUseDestMerch(sKeyToRoute, "OTR_UseDestMerch");   // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant

// Apples to CPV Merchant - Area001 to Area002
  sKeyToRoute = OtrCreateRoute("Area001", "Area002", 15); // start area, dest area, Route Cost
  OtrSetRoutePayoff(sKeyToRoute, 55, 35);                            // Payoff Gold, Payoff XP
                                   // item tag, item resref, item qty, Destination CMD or CPV Merchant Tag
  OtrAddRouteItem(sKeyToRoute, "cnrAppleFruit", "cnrapplefruit", 8, "Donan");
  OtrUseDestMerch(sKeyToRoute, "OTR_UseDestMerch");   // "OTR_UseDestMerch" if using a CMD or CPV Destination Merchant

 */
void main()
{

   string sKeyToRoute;
   int nCostOfOx= 50;
   int nAmountOfGoldAwarded = 100;
   int nAmountOfXpAwarded = 50;
   int nItemQty_1 = 5;
   int nItemQty_2 = 5;
   int nItemQty_n = 5;
   string sDestMerchantTag = "OxMerchant";

   sKeyToRoute = OtrCreateRoute("TRDS1", "TRDE1", nCostOfOx);
   OtrSetRoutePayoff(sKeyToRoute, nAmountOfGoldAwarded, nAmountOfXpAwarded);
   OtrAddRouteItem(sKeyToRoute, "TagOfItem_1","resref", nItemQty_1, sDestMerchantTag);
   OtrAddRouteItem(sKeyToRoute, "TagOfItem_2", "resref", nItemQty_2, sDestMerchantTag);
   OtrAddRouteItem(sKeyToRoute, "TagOfItem_n", "resref",nItemQty_n, sDestMerchantTag);

}
