/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  readme_merchants
//
//  Desc:  Merchant initialization instructions.
//
//  Author: David Bobeck 25Apr03
//
/////////////////////////////////////////////////////////
//
// HOW DOES IT WORK?
//
// When a PC attempts to talk with a NPC which has been configured
// to use CMD, instead of the graphical merchant inventory screen,
// the PC will see a dialog which offers the options to buy or sell
// items.
//
// If the PC chooses to buy items, the NPC will display, in list format,
// all items they are configured to sell. Items that are in the NPC's
// inventory will display in green text. Items that are missing from
// inventory (ie: sold out) will display in red. All items in the list
// will show their prices.
//
// If the PC chooses to sell items, the NPC will display, in list format,
// all items they are configured to buy. Items that are in the PC's
// inventory will display in green text. Items that are missing from
// inventory (ie: the PC doesn't have the item) will display in red.
// All items in the list will show their prices.
//
// When the player selects a green item from the list, the transaction
// will be executed (assuming enough money is available).
//
// HOW DOES A BUILDER CONFIGURE AN NPC TO USE CMD?
//
// 1) Create an NPC.
// 2) Add items to the NPC's inventory. (This is only req'd for items
//    that are not configured as 'infinite' - explained below)
// 3) Set the NPC's conversation file to "cnr_c_merchant".
// 4) Create one script file named "user_merch_init" to identify the
//    NPC's that are to be merchants.
// 5) Create a unique script file for each merchant identified in Step #4.
//    The script must be named to match the NPC's tag. These scripts will
//    identify the items each NPC will buy/sell (details below).
// 6) Set your module's OnModuleLoad handler to "cnr_merch_init", or
//    if you already have a custom script there, then add the following
//    code to your handler...  ExecuteScript("cnr_merch_init", OBJECT_SELF);
//    Note: If you are using CNR, then you can skip this step because
//    "cnr_merch_init" is being executed from "cnr_module_oml", which comes
//    with that system.
// 7) That's it.
//
// HOW DO I CONFIGURE THE NPC'S BUY/SELL LIST?
//
// An NPC's buy/sell list is constructed using one function call (repeatedly).
// This is the prototype...
//
// void CnrMerchantAddItem(string sMerchantTag,
//                         string sItemDesc,
//                         string sItemTag,
//                         int nBuyPrice,
//                         int nSellPrice,
//                         int bInfiniteSupply,
//                         int nMaxOnHandQty,
//                         int nSetSize);
//
//  sMerchantTag = the tag of the NPC
//  sItemDesc = the text identifying an item you wish to display in the dialog.
//  sItemTag = the tag of the item the NPC will be buying or selling.
//  nBuyPrice = if > 0, the NPC will buy this item for this many gold pieces.
//  nSellPrice = if > 0, the NPC will sell this item for this many gold pieces.
//  bInfiniteSupply = If TRUE and nBuyPrice > 0, the NPC will buy an unlimited
//                    number of this item.
//                    If TRUE and nSellPrice > 0, the NPC will sell an unlimited
//                    number of this item.
//                    If FALSE, the NPC will 1) put purchased items in his/her
//                    inventory, and 2) only sell items if they exist in his/her
//                    inventory. (Items sold are removed from inventory).
//  nMaxOnHandQty = the maximum count of an item the NPC will buy/carry.
//  nSetSize = the qty of an item the NPC will buy & sell at a time. For example,
//             use a value of 20 to sell 20 arrows at a time.
//
// Examples...
// So, if you want a NPC with a tag of "Bilbo" to buy fish for 25gp each, then use...
// CnrMerchantAddItem("Bilbo", "Fish", "NW_IT_ITEM012", 25, 0, FALSE, 100, 1);
//   Note: the fish will go into Bilbo's inventory. If his inventory becomes full,
//   Bilbo will drop the excess fish to the ground! In this example, Bilbo will only
//   hold 100 fish.
//
// If you want a NPC with a tag of "Bilbo" to buy no more than 6 fish for 25gp each, then use...
// CnrMerchantAddItem("Bilbo", "Fish", "NW_IT_ITEM012", 25, 0, FALSE, 6, 1);
//   Note: the fish will go into Bilbo's inventory. If his inventory becomes full,
//   Bilbo will drop the excess fish to the ground!
//
// If you want Bilbo to buy fish at 25gp, and sell fish for 30gp, use...
// CnrMerchantAddItem("Bilbo", "Fish", "NW_IT_ITEM012", 25, 30, FALSE, 100, 1);
//
// If you want Bilbo to only sell fish for 30gp, use...
// CnrMerchantAddItem("Bilbo", "Fish", "NW_IT_ITEM012", 0, 30, FALSE, 100, 1);
//
// If you want Bilbo to have an endless supply of fish to sell, (which does not
// deplete Bilbo's inventory), use...
// CnrMerchantAddItem("Bilbo", "Fish", "NW_IT_ITEM012", 0, 30, TRUE, 0, 1);
//
// If you want Bilbo to buy an endless amount of fish (which will not
// accumulate in Bilbo's inventory), use...
// CnrMerchantAddItem("Bilbo", "Fish", "NW_IT_ITEM012", 25, 0, TRUE, 0, 1);
//
// If you want Bilbo to buy and sell an endless amount of fish but 4 fish at a
// time, use...
// CnrMerchantAddItem("Bilbo", "Fish", "NW_IT_ITEM012", 25, 0, TRUE, 0, 4);
//
// Comments...
// 1) You do not need a "merchant" associated with this NPC.
// 2) The NPC does not need to have an item in inventory if the bInfiniteSupply
//    flag is set to TRUE.
//
// V2.4 added the following function...
//
// void CnrMerchantAddItem2(string sMerchantTag,
//                          string sItemDesc,
//                          string sItemTag,
//                          string sItemResRef,
//                          int nBuyPrice,
//                          int nSellPrice,
//                          int bInfiniteSupply,
//                          int nMaxOnHandQty);
//
// This function allows the builder to specify the resref of the item. This is
// required only when the tag and resref do not have the same spelling.
//
// V2.5 added the following 3 functions for PERSISTENT INVENTORY management.
//
// Note: If you do not intend to use a persistent database, then you should not
//       use these three functions!
//
// void CnrMerchantEnablePersistentInventory(string sMerchantTag);
//
// This function allows the builder to use a persistent database to track the
// merchant's inventory quantities. See "readme_merch_get" and "readme_merch_set"
// for informmation on how to hook up the database.
//
// void CnrMerchantAddPersistentItem(string sMerchantTag,
//                                   string sItemDesc,
//                                   string sItemTag,
//                                   int nBuyPrice,
//                                   int nSellPrice,
//                                   int nInitialOnHandQty,
//                                   int nMaxOnHandQty);
//
// This function allows the builder to specify an initial qty in the persistent
// database and, the nMaxOnHandQty will limit the merchant from buying too much.
//
// void CnrMerchantAddPersistentItem2(string sMerchantTag,
//                                    string sItemDesc,
//                                    string sItemTag,
//                                    string sItemResRef,
//                                    int nBuyPrice,
//                                    int nSellPrice,
//                                    int nInitialOnHandQty,
//                                    int nMaxOnHandQty);
//
// This function allows the builder to specify the resref of the item. This is
// required only when the tag and resref do not have the same spelling.
//
// You MUST use one of the two above functions if you enable the merchant's
// persistent inventory AND the item is for sale AND it's not designated as
// having an infinite supply.
//
// V3.1 added nSetSize to the following functions...
//    CnrMerchantAddItem, CnrMerchantAddItem2, 
//    CnrMerchantAddPersistentItem, CnrMerchantAddPersistentItem2
//    
//*************************************************************************
// It is strongly recommended that you use MerchantMaker to generate the
// code for you. No hand coding is required and no errors will exist in 
// your merchant definitions. It's fast and easy. Your call though.
//*************************************************************************
//
// Known limitations as of V3.1 ...
// 1) The NPC has an infinite amount of gold to purchase items.
// 2) The NPC will drop bought items if his/her inventory gets full.
///////////////////////////////////////////////////////////
