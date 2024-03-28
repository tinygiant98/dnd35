/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_merch_utils
//
//  Desc:  This collection of functions manages the
//         custom merchant menus for CNR.
//
//  Author: David Bobeck 12Dec02
//
/////////////////////////////////////////////////////////
#include "cmd_persist_inc"
#include "cmd_language_inc"
#include "cmd_language_v47"
#include "cmd_config_inc"
#include "cmd_config_v47"
#include "cpv_persist_inc"

int CMD_SELECTIONS_PER_PAGE = 6;

// prototype
void CmdDestroyLootBag(object oLootBag, int bChargeForMissingItem);


/////////////////////////////////////////////////////////
int CmdGetMerchantGold(object oMerchant)
{
  return GetGold(oMerchant);
}

/////////////////////////////////////////////////////////
void CmdGiveGoldToMerchant(object oMerchant, int nGold)
{
  GiveGoldToCreature(oMerchant, nGold);

  int nNewGold = CmdGetPersistentInt(GetModule(), GetTag(oMerchant) + "_CmdGold") + nGold;
  CmdSetPersistentInt(GetModule(), GetTag(oMerchant) + "_CmdGold", nNewGold);
}

/////////////////////////////////////////////////////////
void CmdTakeGoldFromMerchant(object oMerchant, int nGold)
{
  TakeGoldFromCreature(nGold, oMerchant, TRUE);

  int nNewGold = CmdGetPersistentInt(GetModule(), GetTag(oMerchant) + "_CmdGold") - nGold;
  if (nNewGold < 0) nNewGold = 0;
  CmdSetPersistentInt(GetModule(), GetTag(oMerchant) + "_CmdGold", nNewGold);
}

/////////////////////////////////////////////////////////
string CnrMerchantAddSubMenu(string sKeyToParent, string sTitle)
{
  int nSubMenuCount = GetLocalInt(GetModule(), sKeyToParent + "_SubMenuCount");

  // check if this title is already mapped
  int m;
  string sKey;

  for (m=1; m<=nSubMenuCount; m++)
  {
    sKey = sKeyToParent + "_" + IntToString(m);
    string sExistingTitle = GetLocalString(GetModule(), sKey);
    if (sExistingTitle == sTitle)
    {
      return sKey;
    }
  }

  nSubMenuCount++;
  SetLocalInt(GetModule(), sKeyToParent + "_SubMenuCount", nSubMenuCount);

  sKey = sKeyToParent + "_" + IntToString(nSubMenuCount);
  SetLocalString(GetModule(), sKey, sTitle);

  string sKeyToKeyToParent = sKey + "_KeyToParent";
  SetLocalString(GetModule(), sKeyToKeyToParent, sKeyToParent);

  return sKey;
}

/////////////////////////////////////////////////////////
//  sMerchantTag = the tag of the NPC
//  sText = the text spoken by the NPC (and which appears) as a 'greeting'
/////////////////////////////////////////////////////////
void CnrMerchantSetMerchantGreetingText(string sMerchantTag, string sText);
/////////////////////////////////////////////////////////
void CnrMerchantSetMerchantGreetingText(string sMerchantTag, string sText)
{
  string sKeyToText = sMerchantTag + "_GreetingText";
  SetLocalString(GetModule(), sKeyToText, sText);
}

/////////////////////////////////////////////////////////
//  sMerchantTag = the tag of the NPC
//  sText = the text spoken by the NPC (and which appears) on the 'buy' menu
/////////////////////////////////////////////////////////
void CnrMerchantSetMerchantBuyText(string sMerchantTag, string sText);
/////////////////////////////////////////////////////////
void CnrMerchantSetMerchantBuyText(string sMerchantTag, string sText)
{
  string sKeyToText = sMerchantTag + "_BuyText";
  SetLocalString(GetModule(), sKeyToText, sText);
}

/////////////////////////////////////////////////////////
//  sMerchantTag = the tag of the NPC
//  sText = the text spoken by the NPC (and which appears) on the 'sell' menu
/////////////////////////////////////////////////////////
void CnrMerchantSetMerchantSellText(string sMerchantTag, string sText);
/////////////////////////////////////////////////////////
void CnrMerchantSetMerchantSellText(string sMerchantTag, string sText)
{
  string sKeyToText = sMerchantTag + "_SellText";
  SetLocalString(GetModule(), sKeyToText, sText);
}

/////////////////////////////////////////////////////////
//  sMerchantTag = the tag of the NPC
/////////////////////////////////////////////////////////
void CnrMerchantEnablePersistentInventory(string sMerchantTag);
/////////////////////////////////////////////////////////
void CnrMerchantEnablePersistentInventory(string sMerchantTag)
{
  int bAlreadyPersistent = CmdGetPersistentInt(GetModule(), sMerchantTag + "_IsPersistent");
  if (bAlreadyPersistent != TRUE)
  {
    // Set this so we can determine if we should re-init the on-hand item counts
    SetLocalInt(GetModule(), sMerchantTag + "_MakePersistent", TRUE);
  }
  CmdSetPersistentInt(GetModule(), sMerchantTag + "_IsPersistent", TRUE);

  SetLocalInt(GetModule(), sMerchantTag + "_GoldInitReqd", TRUE);
}

/////////////////////////////////////////////////////////
//  sMerchantTag = the tag of the NPC
//
/////////////////////////////////////////////////////////
void CnrMerchantEnablePlayerVendor(string sMerchantTag, int nWagePerDay);
/////////////////////////////////////////////////////////
void CnrMerchantEnablePlayerVendor(string sMerchantTag, int nWagePerDay)
{
  CpvSetPersistentInt(GetModule(), sMerchantTag + "_CpvEnabled", TRUE);
  CpvSetPersistentInt(GetModule(), sMerchantTag + "_CpvWage", nWagePerDay);
  CnrMerchantEnablePersistentInventory(sMerchantTag);
}

/////////////////////////////////////////////////////////
string CnrMerchantBuildAncestorMenus(string sMenuType, string sKeyToMenu)
{
  // this crap finds all ancestors of sMercantTag and creates new menus
  // for all of them but with sMenuType prepended to the base menu key.
  string sKeyToParent = GetLocalString(GetModule(), sKeyToMenu + "_KeyToParent");

  string sKeyToStartingParent = sKeyToParent;
  string sKeyToChild = sKeyToMenu;
  string sStartingMenuTitle = GetLocalString(GetModule(), sKeyToMenu);
  string sKeyToTargetParent = "";
  string sMenuTitle;

  sKeyToMenu = sMenuType + sKeyToMenu;

  while (sKeyToTargetParent != sKeyToStartingParent)
  {
    // walk up
    while (sKeyToParent != sKeyToTargetParent)
    {
      sKeyToChild = sKeyToParent;
      sMenuTitle = GetLocalString(GetModule(), sKeyToChild);
      sKeyToParent = GetLocalString(GetModule(), sKeyToParent + "_KeyToParent");
    }

    if (sKeyToTargetParent == "")
    {
      // first time thru loop, prepend "BUY", "SELL" or "CPV"
      sKeyToMenu = sMenuType + sKeyToChild;
    }
    else
    {
      sKeyToMenu = CnrMerchantAddSubMenu(sKeyToMenu, sMenuTitle);
    }

    // step down
    sKeyToTargetParent = sKeyToChild;

    // start walking up from bottom again
    sKeyToParent = sKeyToStartingParent;
  }

  if ((sKeyToTargetParent == "") && (sKeyToStartingParent == ""))
  {
    return sKeyToMenu;
  }

  sKeyToMenu = CnrMerchantAddSubMenu(sKeyToMenu, sStartingMenuTitle);
  return sKeyToMenu;
}

/////////////////////////////////////////////////////////
string CnrMerchantGetRootMerchantTag(string sKeyToMenu)
{
  string sKeyToParent = GetLocalString(GetModule(), sKeyToMenu + "_KeyToParent");

  while (sKeyToParent != "")
  {
    sKeyToMenu = sKeyToParent;
    sKeyToParent = GetLocalString(GetModule(), sKeyToMenu + "_KeyToParent");
  }

  string sMerchantTag;
  int nLenMenu = GetStringLength(sKeyToMenu);
  if (GetStringLeft(sKeyToMenu, 3) == "BUY")
  {
    sMerchantTag = GetStringRight(sKeyToMenu, (nLenMenu - 3));
  }
  else if (GetStringLeft(sKeyToMenu, 4) == "SELL")
  {
    sMerchantTag = GetStringRight(sKeyToMenu, (nLenMenu - 4));
  }
  else // "CPV"
  {
    sMerchantTag = GetStringRight(sKeyToMenu, (nLenMenu - 3));;
  }
  return sMerchantTag;
}

/////////////////////////////////////////////////////////
string CnrMerchantAddItemHelper(string sKeyToMenu, string sItemDesc, string sItemTag, int nBuyPrice, int nSellPrice, int bInfiniteSupply, int nMaxOnHandQty, int nSetSize)
{
  object oModule = GetModule();

  if (nBuyPrice > 0)
  {
    string sKeyToBuyMenu = CnrMerchantBuildAncestorMenus("BUY", sKeyToMenu);

    int nBuyCount = GetLocalInt(oModule, sKeyToBuyMenu + "_BuyCount") + 1;
    SetLocalInt(oModule, sKeyToBuyMenu + "_BuyCount", nBuyCount);

    SetLocalString(oModule, sKeyToBuyMenu + "_BuyDesc_" + IntToString(nBuyCount), sItemDesc);
    SetLocalString(oModule, sKeyToBuyMenu + "_BuyTag_" + IntToString(nBuyCount), sItemTag);
    SetLocalInt(oModule, sKeyToBuyMenu + "_BuyPrice_" + IntToString(nBuyCount), nBuyPrice);
    SetLocalInt(oModule, sKeyToBuyMenu + "_BuyInfinite_" + IntToString(nBuyCount), bInfiniteSupply);
    SetLocalInt(oModule, sKeyToBuyMenu + "_BuySetSize_" + IntToString(nBuyCount), nSetSize);

    // This data must be deferred until we have a merchant object
    string sMerchantTag = CnrMerchantGetRootMerchantTag(sKeyToBuyMenu);
    int nItemCount = GetLocalInt(oModule, sMerchantTag + "_ItemCount") + 1;
    SetLocalInt(oModule, sMerchantTag + "_ItemCount", nItemCount);
    SetLocalInt(oModule, sMerchantTag + "_MaxOfItem_" + IntToString(nItemCount), nMaxOnHandQty);
    SetLocalString(oModule, sMerchantTag + "_TagOfItem_" + IntToString(nItemCount), sItemTag);

    return sKeyToBuyMenu;
  }

  if (nSellPrice > 0)
  {
    string sKeyToSellMenu = CnrMerchantBuildAncestorMenus("SELL", sKeyToMenu);

    int nSellCount = GetLocalInt(oModule, sKeyToSellMenu + "_SellCount") + 1;
    SetLocalInt(oModule, sKeyToSellMenu + "_SellCount", nSellCount);

    SetLocalString(oModule, sKeyToSellMenu + "_SellDesc_" + IntToString(nSellCount), sItemDesc);
    SetLocalString(oModule, sKeyToSellMenu + "_SellTag_" + IntToString(nSellCount), sItemTag);
    SetLocalInt(oModule, sKeyToSellMenu + "_SellPrice_" + IntToString(nSellCount), nSellPrice);
    SetLocalInt(oModule, sKeyToSellMenu + "_SellInfinite_" + IntToString(nSellCount), bInfiniteSupply);
    SetLocalInt(oModule, sKeyToSellMenu + "_SellSetSize_" + IntToString(nSellCount), nSetSize);

    return sKeyToSellMenu;
  }

  return sKeyToMenu;
}

/////////////////////////////////////////////////////////
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
//  nMaxOnHandQty = the max qty of an item the NPC will hold in inventory.
//  nSetSize = the qty of an item the NPC will buy & sell at a time. For example,
//             use a value of 20 to sell 20 arrows at a time.
/////////////////////////////////////////////////////////
void CnrMerchantAddItem(string sMerchantTag, string sItemDesc, string sItemTag, int nBuyPrice, int nSellPrice, int bInfiniteSupply, int nMaxOnHandQty=0, int nSetSize=1);
/////////////////////////////////////////////////////////
void CnrMerchantAddItem(string sMerchantTag, string sItemDesc, string sItemTag, int nBuyPrice, int nSellPrice, int bInfiniteSupply, int nMaxOnHandQty=0, int nSetSize=1)
{
  if (nBuyPrice > 0)
  {
    CnrMerchantAddItemHelper(sMerchantTag, sItemDesc, sItemTag, nBuyPrice, 0, bInfiniteSupply, nMaxOnHandQty, nSetSize);
  }

  if (nSellPrice > 0)
  {
    CnrMerchantAddItemHelper(sMerchantTag, sItemDesc, sItemTag, 0, nSellPrice, bInfiniteSupply, nMaxOnHandQty, nSetSize);
  }
}

/////////////////////////////////////////////////////////
//  sMerchantTag = the tag of the NPC
//  sItemDesc = the text identifying an item you wish to display in the dialog.
//  sItemTag = the tag of the item the NPC will be buying or selling.
//  sItemResRef = the resref of the item. This is required when the item's resref
//                is spelled diferently from the tag.
//  nBuyPrice = if > 0, the NPC will buy this item for this many gold pieces.
//  nSellPrice = if > 0, the NPC will sell this item for this many gold pieces.
//  bInfiniteSupply = If TRUE and nBuyPrice > 0, the NPC will buy an unlimited
//                    number of this item.
//                    If TRUE and nSellPrice > 0, the NPC will sell an unlimited
//                    number of this item.
//                    If FALSE, the NPC will 1) put purchased items in his/her
//                    inventory, and 2) only sell items if they exist in his/her
//                    inventory. (Items sold are removed from inventory).
//  nMaxOnHandQty = the max qty of an item the NPC will hold in inventory.
//  nSetSize = the qty of an item the NPC will buy & sell at a time. For example,
//             use a value of 20 to sell 20 arrows at a time.
/////////////////////////////////////////////////////////
void CnrMerchantAddItem2(string sMerchantTag, string sItemDesc, string sItemTag, string sItemResRef, int nBuyPrice, int nSellPrice, int bInfiniteSupply, int nMaxOnHandQty=0, int nSetSize=1);
/////////////////////////////////////////////////////////
void CnrMerchantAddItem2(string sMerchantTag, string sItemDesc, string sItemTag, string sItemResRef, int nBuyPrice, int nSellPrice, int bInfiniteSupply, int nMaxOnHandQty=0, int nSetSize=1)
{
  CnrMerchantAddItem(sMerchantTag, sItemDesc, sItemTag, nBuyPrice, nSellPrice, bInfiniteSupply, nMaxOnHandQty, nSetSize);
  SetLocalString(GetModule(), "cnrResRef_" + sItemTag, sItemResRef);
}

/////////////////////////////////////////////////////////
void CnrMerchantAddPersistentItemHelper(string sKeyToMenu, string sItemDesc, string sItemTag, int nBuyPrice, int nSellPrice, int nInitialOnHandQty, int nMaxOnHandQty)
{
  object oModule = GetModule();
  string sMerchantTag = CnrMerchantGetRootMerchantTag(sKeyToMenu);

  // Only initialize the persistent database once!
  //int bMakePersistent = GetLocalInt(GetModule(), sMerchantTag + "_MakePersistent");
  //if (bMakePersistent)
  //{
    // Start with nInitialOnHandQty value in the persistent database
    if (nInitialOnHandQty > nMaxOnHandQty)
    {
      nInitialOnHandQty = nMaxOnHandQty;
    }

    int nCount = GetLocalInt(oModule, sMerchantTag + "_PersistentCount") + 1;
    SetLocalInt(oModule, sMerchantTag + "_PersistentCount", nCount);

    SetLocalString(oModule, sMerchantTag + "_ItemTag_" + IntToString(nCount), sItemTag);
    SetLocalInt(oModule, sMerchantTag + "_OnHandQty_" + IntToString(nCount), nInitialOnHandQty);
  //}
}

/////////////////////////////////////////////////////////
//  sKeyToMenu = the submenu
//  sItemDesc = the text identifying an item you wish to display in the dialog.
//  sItemTag = the tag of the item the NPC will be buying or selling.
//  nBuyPrice = if > 0, the NPC will buy this item for this many gold pieces.
//  nSellPrice = if > 0, the NPC will sell this item for this many gold pieces.
//  nInitialOnHandQty = the qty of an item the NPC will start with in inventory.
//  nMaxOnHandQty = the max qty of an item the NPC will hold in inventory.
//  nSetSize = the qty of an item the NPC will buy & sell at a time. For example,
//             use a value of 20 to sell 20 arrows at a time.
/////////////////////////////////////////////////////////
void CnrMerchantAddPersistentItem(string sKeyToMenu, string sItemDesc, string sItemTag, int nBuyPrice, int nSellPrice, int nInitialOnHandQty, int nMaxOnHandQty, int nSetSize=1);
/////////////////////////////////////////////////////////
void CnrMerchantAddPersistentItem(string sKeyToMenu, string sItemDesc, string sItemTag, int nBuyPrice, int nSellPrice, int nInitialOnHandQty, int nMaxOnHandQty, int nSetSize=1)
{
  if (nBuyPrice > 0)
  {
    string sKeyToBuyMenu = CnrMerchantAddItemHelper(sKeyToMenu, sItemDesc, sItemTag, nBuyPrice, 0, FALSE, nMaxOnHandQty, nSetSize);
    CnrMerchantAddPersistentItemHelper(sKeyToBuyMenu, sItemDesc, sItemTag, nBuyPrice, 0, nInitialOnHandQty, nMaxOnHandQty);
  }

  if (nSellPrice > 0)
  {
    string sKeyToSellMenu = CnrMerchantAddItemHelper(sKeyToMenu, sItemDesc, sItemTag, 0, nSellPrice, FALSE, nMaxOnHandQty, nSetSize);
    CnrMerchantAddPersistentItemHelper(sKeyToSellMenu, sItemDesc, sItemTag, 0, nSellPrice, nInitialOnHandQty, nMaxOnHandQty);
  }
}

/////////////////////////////////////////////////////////
//  sMerchantTag = the tag of the NPC
//  sItemDesc = the text identifying an item you wish to display in the dialog.
//  sItemTag = the tag of the item the NPC will be buying or selling.
//  sItemResRef = the resref of the item. This is required when the item's resref
//                is spelled diferently from the tag.
//  nBuyPrice = if > 0, the NPC will buy this item for this many gold pieces.
//  nSellPrice = if > 0, the NPC will sell this item for this many gold pieces.
//  nInitialOnHandQty = the qty of an item the NPC will start with in inventory.
//  nMaxOnHandQty = the max qty of an item the NPC will hold in inventory.
//  nSetSize = the qty of an item the NPC will buy & sell at a time. For example,
//             use a value of 20 to sell 20 arrows at a time.
/////////////////////////////////////////////////////////
void CnrMerchantAddPersistentItem2(string sMerchantTag, string sItemDesc, string sItemTag, string sItemResRef, int nBuyPrice, int nSellPrice, int nInitialOnHandQty, int nMaxOnHandQty, int nSetSize=1);
/////////////////////////////////////////////////////////
void CnrMerchantAddPersistentItem2(string sMerchantTag, string sItemDesc, string sItemTag, string sItemResRef, int nBuyPrice, int nSellPrice, int nInitialOnHandQty, int nMaxOnHandQty, int nSetSize=1)
{
  CnrMerchantAddPersistentItem(sMerchantTag, sItemDesc, sItemTag, nBuyPrice, nSellPrice, nInitialOnHandQty, nMaxOnHandQty, nSetSize);
  SetLocalString(GetModule(), "cnrResRef_" + sItemTag, sItemResRef);
}

/////////////////////////////////////////////////////////
int CnrMerchantGetBuyCount(string sKeyToMenu)
{
  return GetLocalInt(GetModule(), sKeyToMenu + "_BuyCount");
}

/////////////////////////////////////////////////////////
int CnrMerchantGetSellCount(string sKeyToMenu)
{
  return GetLocalInt(GetModule(), sKeyToMenu + "_SellCount");
}

/////////////////////////////////////////////////////////
int CnrMerchantGetCpvCount(string sKeyToMenu)
{
  return CpvGetPersistentInt(GetModule(), sKeyToMenu + "_CpvCount");
}

/////////////////////////////////////////////////////////
string CnrMerchantGetBuyDesc(string sKeyToMenu, int nItemIndex)
{
  string sItemDesc = "INVALID_ITEM";
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetBuyCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    sItemDesc = GetLocalString(oModule, sKeyToMenu + "_BuyDesc_" + IntToString(nItemIndex));
  }

  return sItemDesc;
}

/////////////////////////////////////////////////////////
string CnrMerchantGetSellDesc(string sKeyToMenu, int nItemIndex)
{
  string sItemDesc = "INVALID_ITEM";
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetSellCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    sItemDesc = GetLocalString(oModule, sKeyToMenu + "_SellDesc_" + IntToString(nItemIndex));
  }

  return sItemDesc;
}

/////////////////////////////////////////////////////////
string CnrMerchantGetCpvDesc(string sKeyToMenu, int nItemIndex)
{
  string sItemDesc = "INVALID_ITEM";
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    sItemDesc = CpvGetPersistentString(oModule, sKeyToMenu + "_CpvDesc_" + IntToString(nItemIndex));
  }

  return sItemDesc;
}

/////////////////////////////////////////////////////////
string CnrMerchantGetBuyTag(string sKeyToMenu, int nItemIndex)
{
  string sItemTag = "INVALID_ITEM";
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetBuyCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    sItemTag = GetLocalString(oModule, sKeyToMenu + "_BuyTag_" + IntToString(nItemIndex));
  }

  return sItemTag;
}

/////////////////////////////////////////////////////////
string CnrMerchantGetSellTag(string sKeyToMenu, int nItemIndex)
{
  string sItemTag = "INVALID_ITEM";
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetSellCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    sItemTag = GetLocalString(oModule, sKeyToMenu + "_SellTag_" + IntToString(nItemIndex));
  }

  return sItemTag;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetBuyPrice(string sKeyToMenu, int nItemIndex)
{
  int nItemPrice = 0;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetBuyCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nItemPrice = GetLocalInt(oModule, sKeyToMenu + "_BuyPrice_" + IntToString(nItemIndex));
  }

  return nItemPrice;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetSellPrice(string sKeyToMenu, int nItemIndex)
{
  int nItemPrice = 0;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetSellCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nItemPrice = GetLocalInt(oModule, sKeyToMenu + "_SellPrice_" + IntToString(nItemIndex));
  }

  return nItemPrice;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetCpvBuyPrice(string sKeyToMenu, int nItemIndex)
{
  int nItemPrice = 0;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nItemPrice = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvBuyPrice_" + IntToString(nItemIndex));
  }

  return nItemPrice;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetCpvSellPrice(string sKeyToMenu, int nItemIndex)
{
  int nItemPrice = 0;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nItemPrice = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvSellPrice_" + IntToString(nItemIndex));
  }

  return nItemPrice;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetBuyInfinite(string sKeyToMenu, int nItemIndex)
{
  int bBuyInfinite = FALSE;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetBuyCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    bBuyInfinite = GetLocalInt(oModule, sKeyToMenu + "_BuyInfinite_" + IntToString(nItemIndex));
  }

  return bBuyInfinite;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetSellInfinite(string sKeyToMenu, int nItemIndex)
{
  int bSellInfinite = FALSE;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetSellCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    bSellInfinite = GetLocalInt(oModule, sKeyToMenu + "_SellInfinite_" + IntToString(nItemIndex));
  }

  return bSellInfinite;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetBuySetSize(string sKeyToMenu, int nItemIndex)
{
  int nSetSize = 1;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetBuyCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nSetSize = GetLocalInt(oModule, sKeyToMenu + "_BuySetSize_" + IntToString(nItemIndex));
  }

  return nSetSize;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetSellSetSize(string sKeyToMenu, int nItemIndex)
{
  int nSetSize = 1;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetSellCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nSetSize = GetLocalInt(oModule, sKeyToMenu + "_SellSetSize_" + IntToString(nItemIndex));
  }

  return nSetSize;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetCpvSetSize(string sKeyToMenu, int nItemIndex)
{
  int nSetSize = 1;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nSetSize = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvSetSize_" + IntToString(nItemIndex));
  }

  return nSetSize;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetCpvMaxQty(string sKeyToMenu, int nItemIndex)
{
  int nMaxQty = 1000;
  object oModule = GetModule();

  // validate the index
  int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
  if ((nItemIndex > 0) && (nItemIndex <= nItemCount))
  {
    nMaxQty = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvMaxQty_" + IntToString(nItemIndex));
  }

  return nMaxQty;
}

/////////////////////////////////////////////////////////
int CnrMerchantGetNumItemsOnObject(string sItemTag, object oTarget)
{
  int nItemCount = 0;
  object oItem = GetFirstItemInInventory(oTarget);
  while (oItem != OBJECT_INVALID)
  {
    if (GetTag(oItem) == sItemTag)
    {
      int nStackSize = GetNumStackedItems(oItem);
      nItemCount += nStackSize;
    }
    else if (GetHasInventory(oItem) == TRUE)
    {
      // recursive search
      nItemCount += CnrMerchantGetNumItemsOnObject(sItemTag, oItem);
    }

    oItem = GetNextItemInInventory(oTarget);
  }
  return nItemCount;
}

/////////////////////////////////////////////////////////
void CnrMerchantCreateItemOnObject(string sItemTag, object oTarget, int nQty)
{
  // if the item is a stackable type, then create a stack for convenience to the player
  object oTempItem = CreateObject(OBJECT_TYPE_ITEM, sItemTag, GetLocation(oTarget));
  int eBaseType = GetBaseItemType(oTempItem);
  DestroyObject(oTempItem);

  int bIsStackable = FALSE;
  int nMaxStackSize = 1;
  switch (eBaseType)
  {
    case BASE_ITEM_POTIONS:{bIsStackable=TRUE;nMaxStackSize=10;break;}
    case BASE_ITEM_DART:{bIsStackable=TRUE;nMaxStackSize=50;break;}
    case BASE_ITEM_GEM:{bIsStackable=TRUE;nMaxStackSize=10;break;}
    case BASE_ITEM_BULLET:{bIsStackable=TRUE;nMaxStackSize=99;break;}
    case BASE_ITEM_BOLT:{bIsStackable=TRUE;nMaxStackSize=99;break;}
    case BASE_ITEM_ARROW:{bIsStackable=TRUE;nMaxStackSize=99;break;}
    case BASE_ITEM_GOLD:{bIsStackable=TRUE;nMaxStackSize=50000;break;}
  }

  object oItem;

  if (bIsStackable)
  {
    while (nQty > nMaxStackSize)
    {
      oItem = CreateItemOnObject(sItemTag, oTarget, nMaxStackSize);
      if (CXX_BOOL_FLAG_HANDLED_ITEMS_AS_IDENTIFIED)
      {
        if (GetIsObjectValid(oItem)) SetIdentified(oItem, TRUE);
      }
      nQty -= nMaxStackSize;
    }
    if (nQty > 0)
    {
      oItem = CreateItemOnObject(sItemTag, oTarget, nQty);
      if (CXX_BOOL_FLAG_HANDLED_ITEMS_AS_IDENTIFIED)
      {
        if (GetIsObjectValid(oItem)) SetIdentified(oItem, TRUE);
      }
    }
  }
  else
  {
    int n;
    for (n=0; n<nQty; n++)
    {
      oItem = CreateItemOnObject(sItemTag, oTarget, 1);

      if (CXX_BOOL_FLAG_HANDLED_ITEMS_AS_IDENTIFIED)
      {
        if (GetIsObjectValid(oItem)) SetIdentified(oItem, TRUE);
      }
    }
  }
}

/////////////////////////////////////////////////////////
int CnrMerchantDestroyItemOnObject(string sItemTag, object oTarget, int nItemCount)
{
  if (nItemCount > 0)
  {
    object oItem = GetFirstItemInInventory(oTarget);
    while ((oItem != OBJECT_INVALID) && (nItemCount > 0))
    {
      if (GetTag(oItem) == sItemTag)
      {
        int nStackSize = GetNumStackedItems(oItem);
        if (nStackSize <= nItemCount)
        {
          DestroyObject(oItem);
          nItemCount -= nStackSize;
        }
        else
        {
          // split the stack
          DestroyObject(oItem);
          // DestroyObject is deferred, so create must be deferred also to keep order
          AssignCommand(OBJECT_SELF, CnrMerchantCreateItemOnObject(sItemTag, oTarget, nStackSize-nItemCount));
          nItemCount = 0;
        }
      }
      else if (GetHasInventory(oItem) == TRUE)
      {
        // recursive search
        nItemCount = CnrMerchantDestroyItemOnObject(sItemTag, oItem, nItemCount);
      }

      oItem = GetNextItemInInventory(oTarget);
    }
  }
  return nItemCount;
}

/////////////////////////////////////////////////////////
int CnrMerchantShowAsGreen(object oMerchant, int nMenuIndex)
{
  object oModule = GetModule();
  string sMerchantTag = GetTag(oMerchant);
  object oPC = GetPCSpeaker();

  string sKeyToCurrentMenu = GetLocalString(oPC, "sCnrCurrentMenu");
  int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");

  int nSubMenuCount = GetLocalInt(oModule, sKeyToCurrentMenu + "_SubMenuCount");
  if (nSubMenuCount > 0)
  {
    // items don't display when there are sub menus
    return FALSE;
  }

  // The merchant menus display CMD_SELECTIONS_PER_PAGE items per page
  int nItemIndex = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + nMenuIndex;
  string sMenuType = GetLocalString(oPC, "sCnrMenuType");

  // validate the index
  int nItemCount;
  if (sMenuType == "BUY")
  {
    nItemCount = CnrMerchantGetBuyCount(sKeyToCurrentMenu);
  }
  else if (sMenuType == "SELL")
  {
    nItemCount = CnrMerchantGetSellCount(sKeyToCurrentMenu);
  }
  else //if (sMenuType == "CPV")
  {
    nItemCount = CnrMerchantGetCpvCount(sKeyToCurrentMenu);
  }

  if ((nItemIndex == 0) || (nItemIndex > nItemCount))
  {
    return FALSE;
  }

  if (sMenuType == "BUY")
  {
    // see if PC speaker has enough items with this tag
    string sItemTag = CnrMerchantGetBuyTag(sKeyToCurrentMenu, nItemIndex);
    int nSetSize = CnrMerchantGetBuySetSize(sKeyToCurrentMenu, nItemIndex);
    int nNumItems = CnrMerchantGetNumItemsOnObject(sItemTag, oPC);
    if (nNumItems >= nSetSize)
    {
      return TRUE;
    }
  }
  else if (sMenuType == "SELL")
  {
    int bSellInfinite = CnrMerchantGetSellInfinite(sKeyToCurrentMenu, nItemIndex);
    if (bSellInfinite)
    {
      return TRUE;
    }

    // see if merchant has enough items with this tag
    string sItemTag = CnrMerchantGetSellTag(sKeyToCurrentMenu, nItemIndex);
    int nSetSize = CnrMerchantGetSellSetSize(sKeyToCurrentMenu, nItemIndex);

    if (CpvGetPersistentInt(oModule, sMerchantTag + "_CpvEnabled"))
    {
      string sKeyToCpvQty = GetLocalString(oModule, sKeyToCurrentMenu + "_KeyToQty_" + IntToString(nItemIndex));
      int nOnHandQty = CpvGetPersistentInt(oModule, sKeyToCpvQty);
      if (nOnHandQty >= nSetSize)
      {
        return TRUE;
      }
    }
    else
    {
      int bEnablePersistentInventory = CmdGetPersistentInt(oModule, sMerchantTag + "_IsPersistent");
      if (bEnablePersistentInventory)
      {
        int nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sItemTag);
        if (nOnHandQty >= nSetSize)
        {
          return TRUE;
        }
      }
      else
      {
        int nNumItems = CnrMerchantGetNumItemsOnObject(sItemTag, oMerchant);
        if (nNumItems >= nSetSize)
        {
          return TRUE;
        }
      }
    }
  }
  else // if (sMenuType == "CPV")
  {
    return TRUE;
  }

  return FALSE;
}

/////////////////////////////////////////////////////////
int CnrMerchantShowAsRed(object oMerchant, int nMenuIndex)
{
  object oModule = GetModule();
  string sMerchantTag = GetTag(oMerchant);
  object oPC = GetPCSpeaker();

  string sKeyToCurrentMenu = GetLocalString(oPC, "sCnrCurrentMenu");
  int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");

  int nSubMenuCount = GetLocalInt(oModule, sKeyToCurrentMenu + "_SubMenuCount");
  if (nSubMenuCount > 0)
  {
    // items don't display when there are sub menus
    return FALSE;
  }

  // The merchant menus display CMD_SELECTIONS_PER_PAGE items per page
  int nItemIndex = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + nMenuIndex;
  string sMenuType = GetLocalString(oPC, "sCnrMenuType");

  // validate the index
  int nItemCount;
  if (sMenuType == "BUY")
  {
    nItemCount = CnrMerchantGetBuyCount(sKeyToCurrentMenu);
  }
  else if (sMenuType == "SELL")
  {
    nItemCount = CnrMerchantGetSellCount(sKeyToCurrentMenu);
  }
  else
  {
    return FALSE;
  }

  if ((nItemIndex == 0) || (nItemIndex > nItemCount))
  {
    return FALSE;
  }

  string sItemTag = "";
  if (sMenuType == "BUY")
  {
    // see if PC speaker has enough items with this tag
    string sItemTag = CnrMerchantGetBuyTag(sKeyToCurrentMenu, nItemIndex);
    int nNumItems = CnrMerchantGetNumItemsOnObject(sItemTag, oPC);
    int nSetSize = CnrMerchantGetBuySetSize(sKeyToCurrentMenu, nItemIndex);
    if (nNumItems < nSetSize)
    {
      return TRUE;
    }
  }
  else if (sMenuType == "SELL")
  {
    int bSellInfinite = CnrMerchantGetSellInfinite(sKeyToCurrentMenu, nItemIndex);
    if (bSellInfinite)
    {
      return FALSE;
    }

    // see if merchant has enough items with this tag
    sItemTag = CnrMerchantGetSellTag(sKeyToCurrentMenu, nItemIndex);
    int nSetSize = CnrMerchantGetSellSetSize(sKeyToCurrentMenu, nItemIndex);

    if (CpvGetPersistentInt(oModule, sMerchantTag + "_CpvEnabled"))
    {
      string sKeyToCpvQty = GetLocalString(oModule, sKeyToCurrentMenu + "_KeyToQty_" + IntToString(nItemIndex));
      int nOnHandQty = CpvGetPersistentInt(oModule, sKeyToCpvQty);
      if (nOnHandQty < nSetSize)
      {
        return TRUE;
      }
    }
    else
    {
      int bEnablePersistentInventory = CmdGetPersistentInt(oModule, sMerchantTag + "_IsPersistent");
      if (bEnablePersistentInventory)
      {
        int nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sItemTag);
        if (nOnHandQty < nSetSize)
        {
          return TRUE;
        }
      }
      else
      {
        int nNumItems = CnrMerchantGetNumItemsOnObject(sItemTag, oMerchant);
        if (nNumItems < nSetSize)
        {
          return TRUE;
        }
      }
    }
  }
  else // if (sMenuType == "CPV")
  {
    return FALSE;
  }

  return FALSE;
}

/////////////////////////////////////////////////////////
float CnrMerchantNormalizeFacing(float fFacing)
{
  while (fFacing >= 360.0) fFacing -= 360.0;
  while (fFacing < 0.0) fFacing += 360.0;
  return fFacing;
}

/////////////////////////////////////////////////////////
void CnrMerchantBuyOrSellItem(object oMerchant, int nMenuIndex)
{
  object oPC = GetPCSpeaker();

  string sKeyToCurrentMenu = GetLocalString(oPC, "sCnrCurrentMenu");
  int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");

  // The merchant menus display CMD_SELECTIONS_PER_PAGE items per page
  int nItemIndex = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + nMenuIndex;
  string sMenuType = GetLocalString(oPC, "sCnrMenuType");
  object oModule = GetModule();
  string sMerchantTag = GetTag(oMerchant);
  int bEnablePersistentInventory = CmdGetPersistentInt(oModule, sMerchantTag + "_IsPersistent");

  int bPlayerVendor = CpvGetPersistentInt(oModule, sMerchantTag + "_CpvEnabled");

  if (sMenuType == "BUY")
  {
    string sBuyTag = CnrMerchantGetBuyTag(sKeyToCurrentMenu, nItemIndex);
    int nBuyPrice = CnrMerchantGetBuyPrice(sKeyToCurrentMenu, nItemIndex);
    int bBuyInfinite = CnrMerchantGetBuyInfinite(sKeyToCurrentMenu, nItemIndex);
    int nSetSize = CnrMerchantGetBuySetSize(sKeyToCurrentMenu, nItemIndex);

    ////////////////////////////////////////////////////////////////
    // CPV functionality.
    ////////////////////////////////////////////////////////////////
    if (bPlayerVendor)
    {
      string sKeyToCpvQty = GetLocalString(oModule, sKeyToCurrentMenu + "_KeyToQty_" + IntToString(nItemIndex));
      int nOnHandQty = CpvGetPersistentInt(oModule, sKeyToCpvQty);

      int nMaxOnHandQty = GetLocalInt(oModule, sKeyToCurrentMenu + "_MaxOfItem_" + IntToString(nItemIndex));

      if (nMaxOnHandQty > 0)
      {
        if ((nOnHandQty + nSetSize) > nMaxOnHandQty)
        {
          AssignCommand(oMerchant, ActionSpeakString(CMD_TEXT_SORRY_IVE_GOT_TOO_MANY_OF_THOSE));
          AssignCommand(oMerchant, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
          return;
        }
      }

      ////////////////////////////////////////////////////////////////
      // Don't buy unless vendor has enough gold!
      ////////////////////////////////////////////////////////////////
      if (nBuyPrice > CmdGetMerchantGold(oMerchant))
      {
        AssignCommand(oMerchant, ActionSpeakString(CPV_TEXT_I_CANNOT_AFFORD_IT));
        AssignCommand(oMerchant, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
        return;
      }

      // adjust the CPV qty
      CpvSetPersistentInt(oModule, sKeyToCpvQty, nOnHandQty + nSetSize);

      // Remove the appropriate qty of items from the PC and
      CnrMerchantDestroyItemOnObject(sBuyTag, oPC, nSetSize);

      CmdTakeGoldFromMerchant(oMerchant, nBuyPrice);
    }
    else
    {
      if (!bBuyInfinite)
      {
        int nMaxOnHandQty = GetLocalInt(oMerchant, "MaxOnHand_" + sBuyTag);
        if (nMaxOnHandQty > 0) // if <= 0 use infinite
        {
          int nOnHandQty = 0;

          // if using persistent inventory, do things differently
          if (bEnablePersistentInventory)
          {
            nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sBuyTag);
          }
          else
          {
            nOnHandQty = CnrMerchantGetNumItemsOnObject(sBuyTag, oMerchant);
          }

          if ((nOnHandQty + nSetSize) > nMaxOnHandQty)
          {
            AssignCommand(oMerchant, ActionSpeakString(CMD_TEXT_SORRY_IVE_GOT_TOO_MANY_OF_THOSE));
            AssignCommand(oMerchant, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
            return;
          }
        }
      }

      // Remove the appropriate qty of items from the PC and
      CnrMerchantDestroyItemOnObject(sBuyTag, oPC, nSetSize);

      // add the items to the merchant.
      if (bBuyInfinite)
      {
        // Just remove the items from the PC's inventory
      }
      else
      {
        // if peristent inventory is enabled, do things a bit differently
        if (bEnablePersistentInventory)
        {
          int nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sBuyTag) + nSetSize;
          CmdSetPersistentInt(oMerchant, "OnHandQty_" + sBuyTag, nOnHandQty);
        }
        else
        {
          // if ResRef is not defined, then convert tag to ResRef
          string sBuyResRef = GetLocalString(oModule, "cnrResRef_" + sBuyTag);
          if (sBuyResRef == "")
          {
            sBuyResRef = GetStringLowerCase(sBuyTag);
            if (GetStringLength(sBuyResRef) > 16)
            {
              sBuyResRef = GetStringLeft(sBuyResRef, 16);
            }
          }

          // Create new items on the merchant
          CnrMerchantCreateItemOnObject(sBuyResRef, oMerchant, nSetSize);
        }
      }
    }

    GiveGoldToCreature(oPC, nBuyPrice);
    AssignCommand(oMerchant, ActionSpeakString(CMD_TEXT_THANKS_ANYTHING_ELSE));
    AssignCommand(oMerchant, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
  }
  else // "SELL"
  {
    string sSellTag = CnrMerchantGetSellTag(sKeyToCurrentMenu, nItemIndex);
    int nSellPrice = CnrMerchantGetSellPrice(sKeyToCurrentMenu, nItemIndex);
    int bSellInfinite = CnrMerchantGetSellInfinite(sKeyToCurrentMenu, nItemIndex);
    int nSetSize = CnrMerchantGetSellSetSize(sKeyToCurrentMenu, nItemIndex);

    // if ResRef is not defined, then convert tag to ResRef
    string sSellResRef = GetLocalString(oModule, "cnrResRef_" + sSellTag);
    if (sSellResRef == "")
    {
      sSellResRef = GetStringLowerCase(sSellTag);
      if (GetStringLength(sSellResRef) > 16)
      {
        sSellResRef = GetStringLeft(sSellResRef, 16);
      }
    }

    location locPC = GetLocation(oPC);

    // Position the lootbag in front of the PC so they don't
    // move and/or turn around when they "use" it.
    float fFacing = GetFacingFromLocation(locPC);
    vector vLootBagPos = GetPosition(oPC);
    float fDistanceX = cos(fFacing) * 0.5;
    float fDistanceY = sin(fFacing) * 0.5;
    vLootBagPos.x += fDistanceX;
    vLootBagPos.y += fDistanceY;
    location locLootBag = Location(GetArea(oPC), vLootBagPos, fFacing);

    // create a new loot bag
    object oLootBag = CreateObject(OBJECT_TYPE_PLACEABLE, "cmdLootBag", locLootBag, FALSE);

    SetLocalString(oLootBag, "CmdSellTag", sSellTag);
    SetLocalString(oLootBag, "CmdSellResRef", sSellResRef);
    SetLocalInt(oLootBag, "CmdSellPrice", nSellPrice);
    SetLocalInt(oLootBag, "CmdMenuIndex", nMenuIndex);
    SetLocalInt(oLootBag, "CmdSellSetSize", nSetSize);
    SetLocalObject(oLootBag, "CmdCustomer", oPC);
    SetLocalObject(oPC, "CmdLootBag", oLootBag);

    if (bPlayerVendor)
    {
      string sKeyToCpvQty = GetLocalString(oModule, sKeyToCurrentMenu + "_KeyToQty_" + IntToString(nItemIndex));
      int nOnHandQty = CpvGetPersistentInt(oModule, sKeyToCpvQty);

      if (nOnHandQty < nSetSize)
      {
        // this should never happen, but if it does...
        AssignCommand(oMerchant, ActionSpeakString(CMD_TEXT_SORRY_I_AM_OUT_OF_THAT_ITEM));
        AssignCommand(oMerchant, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
        DestroyObject(oLootBag);
        return;
      }

      SetLocalInt(oLootBag, "CmdQtyOnHand", nOnHandQty);
      SetLocalInt(oLootBag, "CmdSellInfinite", FALSE);
    }
    else
    {
      if (bSellInfinite)
      {
        SetLocalInt(oLootBag, "CmdQtyOnHand", -1);
        SetLocalInt(oLootBag, "CmdSellInfinite", TRUE);
      }
      else
      {
        int nOnHandQty = 0;

        // if using persistent inventory, do things differently
        if (bEnablePersistentInventory)
        {
          nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sSellTag);
        }
        else
        {
          nOnHandQty = CnrMerchantGetNumItemsOnObject(sSellTag, oMerchant);
        }

        if (nOnHandQty < nSetSize)
        {
          // this should never happen, but if it does...
          AssignCommand(oMerchant, ActionSpeakString(CMD_TEXT_SORRY_I_AM_OUT_OF_THAT_ITEM));
          AssignCommand(oMerchant, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
          DestroyObject(oLootBag);
          return;
        }

        SetLocalInt(oLootBag, "CmdQtyOnHand", nOnHandQty);
        SetLocalInt(oLootBag, "CmdSellInfinite", FALSE);
      }
    }

    // add one of the sell items to the loot bag
    object oItem = CreateItemOnObject(sSellResRef, oLootBag, 1);
    //SetLocalObject(oLootBag, "CmdSellItem", oItem);

    if (CXX_BOOL_FLAG_HANDLED_ITEMS_AS_IDENTIFIED)
    {
      SetIdentified(oItem, TRUE);
    }

    SetLocalObject(oLootBag, "CmdMerchant", oMerchant);

    // Note: a delay is required for clean transition from convo to lootbag inventory
    AssignCommand(oPC, DelayCommand(0.5, ActionInteractObject(oLootBag)));

    return;
  }
}

/////////////////////////////////////////////////////////
void CnrMerchantDecrementQtyOnHand(object oMerchant, int nMenuIndex, object oPC, string sSellTag, int nQty)
{
  string sKeyToCurrentMenu = GetLocalString(oPC, "sCnrCurrentMenu");
  int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");

  // The merchant menus display CMD_SELECTIONS_PER_PAGE items per page
  int nItemIndex = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + nMenuIndex;
  object oModule = GetModule();
  string sMerchantTag = GetTag(oMerchant);

  int bPlayerVendor = CpvGetPersistentInt(oModule, sMerchantTag + "_CpvEnabled");
  if (bPlayerVendor)
  {
    string sKeyToCpvQty = GetLocalString(oModule, sKeyToCurrentMenu + "_KeyToQty_" + IntToString(nItemIndex));
    int nOnHandQty = CpvGetPersistentInt(oModule, sKeyToCpvQty) - nQty;
    if (nOnHandQty < 0) nOnHandQty = 0;
    CpvSetPersistentInt(oModule, sKeyToCpvQty, nOnHandQty);
  }
  else
  {
    // if using persistent inventory, do things differently
    int bEnablePersistentInventory = CmdGetPersistentInt(oModule, sMerchantTag + "_IsPersistent");
    if (bEnablePersistentInventory)
    {
      int nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sSellTag) - nQty;
      if (nOnHandQty < 0) nOnHandQty = 0;
      CmdSetPersistentInt(oMerchant, "OnHandQty_" + sSellTag, nOnHandQty);
    }
    else
    {
      CnrMerchantDestroyItemOnObject(sSellTag, oMerchant, nQty);
    }
  }
}

/////////////////////////////////////////////////////////
void CnrMerchantDoSelection(int nSelIndex)
{
  object oPC = GetPCSpeaker();
  string sKeyToCurrentMenu = GetLocalString(oPC, "sCnrCurrentMenu");
  int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");
  int nSubMenuCount = GetLocalInt(GetModule(), sKeyToCurrentMenu + "_SubMenuCount");
  if (nSubMenuCount == 0)
  {
    // The menu was displaying items
    string sMenuType = GetLocalString(oPC, "sCnrMenuType");
    if (sMenuType == "CPV")
    {
      int nItemIndex = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + nSelIndex;
      SetLocalInt(oPC, "CpvItemIndex", nItemIndex);
     }
    else
    {
      CnrMerchantBuyOrSellItem(OBJECT_SELF, nSelIndex);
    }
  }
  else
  {
    // The menu was displaying sub menus
    string sKeyToMenu = sKeyToCurrentMenu + "_" + IntToString((nMenuPage*CMD_SELECTIONS_PER_PAGE) + nSelIndex);
    SetLocalString(oPC, "sCnrCurrentMenu", sKeyToMenu);
    SetLocalInt(oPC, "nCnrMenuPage", 0);
    // cnr_ta_m_buysell will display the menu
  }
}

/////////////////////////////////////////////////////////
void CnrMerchantShowMenu(string sKeyToMenu, int nMenuPage)
{
  object oPC = GetPCSpeaker();
  SetLocalString(oPC, "sCnrCurrentMenu", sKeyToMenu);
  SetLocalInt(oPC, "nCnrMenuPage", nMenuPage);

  object oModule = GetModule();
  string sMerchantTag = GetTag(OBJECT_SELF);

  string sMenuType = GetLocalString(oPC, "sCnrMenuType");

  string sKeyToText;
  string sText;

  if (sMenuType == "TOP")
  {
    sKeyToText = sMerchantTag + "_GreetingText";
    sText = GetLocalString(oModule, sKeyToText);
    if (sText == "")
    {
      sText = CMD_TEXT_DEFAULT_GREETING_TEXT;
    }

    // if CPV enabled
    int bPlayerVendor = CpvGetPersistentInt(oModule, sMerchantTag + "_CpvEnabled");
    if (bPlayerVendor == TRUE)
    {
      // and if employed
      string sEmployer = CpvGetPersistentString(oModule, sMerchantTag + "_CpvEmployer");
      if (sEmployer != "")
      {
        string sPcKey = GetPCPublicCDKey(oPC);
        string sPcName = GetName(oPC);
        int bPcIsEmployer = FALSE;
        if (sEmployer == sPcKey + "_" + sPcName) bPcIsEmployer = TRUE;

        // and if not employed by this PC
        if (!bPcIsEmployer)
        {
          // and if shop is not open
          int bShopIsOpen = CpvGetPersistentInt(oModule, sMerchantTag + "_CpvShopIsOpen");
          if (!bShopIsOpen)
          {
            // then change the greeting
            sText = CPV_TEXT_I_AM_NOT_OPEN;
          }

          int bShowName = CpvGetPersistentInt(oModule, sMerchantTag + "_CpvShowName");
          if (bShowName)
          {
            string sEmployerName = CpvGetPersistentString(oModule, sMerchantTag + "_CpvEmployerName");
            sText += " " + CPV_TEXT_THE_GOODS_BELONG_TO;
            sText += sEmployerName;
          }
        }
        else
        {
          sText = CPV_TEXT_GREETINGS_TO_EMPLOYER;
        }
      }
    }

    SetLocalString(oPC, "sCnrTokenText27010", sText);
    return;
  }
  else if (sMenuType == "BUY")
  {
    sKeyToText = sMerchantTag + "_BuyText";
    sText = GetLocalString(oModule, sKeyToText);
    if (sText == "")
    {
      sText = CMD_TEXT_DEFAULT_BUY_TEXT;
    }
    sText += "\n\n(" + CMD_TEXT_YOU_HAVE + " " + IntToString(GetGold(oPC)) + " " + CMD_TEXT_GPS + ")";
  }
  else if (sMenuType == "SELL")
  {
    sKeyToText = sMerchantTag + "_SellText";
    sText = GetLocalString(oModule, sKeyToText);
    if (sText == "")
    {
      sText = CMD_TEXT_DEFAULT_SELL_TEXT;
    }
    sText += "\n\n(" + CMD_TEXT_YOU_HAVE + " " + IntToString(GetGold(oPC)) + " " + CMD_TEXT_GPS + ")";
  }
  else // if (sMenuType == "CPV")
  {
    string sWhite = GetLocalString(oModule, "CmdColorWhite");
    string sLtCyan = GetLocalString(oModule, "CmdColorLtCyan");
    sText = sWhite + "To add/remove items to/from the merchant's inventory, select 'Adjust inventory here'. ";
    sText += "Each submenu must be configured seperately. Once items exist in the merchant's ";
    sText += "inventory, they will show in the list below. Then, select each item to configure it's pricing. ";
    sText += "Add gold to any submenu to give the merchant funds to buy items. ";
    sText += "\n\n" + sLtCyan + "(Vendor has " + IntToString(GetGold(OBJECT_SELF)) + " gp's)";
  }

  SetLocalString(oPC, "sCnrTokenText27010", sText);

  string sKeyToCount = sKeyToMenu + "_SubMenuCount";
  int nSubCount = GetLocalInt(GetModule(), sKeyToCount);
  if (nSubCount > 0)
  {
    // this menu has submenus
    int nFirst = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + 1;
    int nLast = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + CMD_SELECTIONS_PER_PAGE;
    if (nLast >= nSubCount)
    {
      nLast = nSubCount;
    }

    int n;
    for (n=nFirst; n<=nLast; n++)
    {
      string sKey = sKeyToMenu + "_" + IntToString(n);

      string sTitle = GetLocalString(GetModule(), sKey);
      SetLocalString(oPC, "sCnrTokenText" + IntToString(27001 + (n - nFirst)), sTitle);
    }
  }
  else
  {
    // this menu has items
    int nItemIndexFirst = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + 1;
    int nItemIndexLast = (nMenuPage * CMD_SELECTIONS_PER_PAGE) + CMD_SELECTIONS_PER_PAGE;

    int nItemIndex;
    for (nItemIndex=nItemIndexFirst; nItemIndex<=nItemIndexLast; nItemIndex++)
    {
      string sItemDesc;
      int nItemPrice;
      int nBuyPrice;
      int nSellPrice;
      int nSetSize;
      int nMaxQty;

      if (sMenuType == "BUY")
      {
        sItemDesc = CnrMerchantGetBuyDesc(sKeyToMenu, nItemIndex);
        nItemPrice = CnrMerchantGetBuyPrice(sKeyToMenu, nItemIndex);
        nSetSize = CnrMerchantGetBuySetSize(sKeyToMenu, nItemIndex);
      }
      else if (sMenuType == "SELL")
      {
        sItemDesc = CnrMerchantGetSellDesc(sKeyToMenu, nItemIndex);
        nItemPrice = CnrMerchantGetSellPrice(sKeyToMenu, nItemIndex);
        nSetSize = CnrMerchantGetSellSetSize(sKeyToMenu, nItemIndex);
      }
      else // if (sMenuType == "CPV")
      {
        sItemDesc = CnrMerchantGetCpvDesc(sKeyToMenu, nItemIndex);
        nBuyPrice = CnrMerchantGetCpvBuyPrice(sKeyToMenu, nItemIndex);
        nSellPrice = CnrMerchantGetCpvSellPrice(sKeyToMenu, nItemIndex);
        nSetSize = CnrMerchantGetCpvSetSize(sKeyToMenu, nItemIndex);
        nMaxQty = CnrMerchantGetCpvMaxQty(sKeyToMenu, nItemIndex);
      }

      if (nSetSize > 1)
      {
        sItemDesc += " (" + CMD_TEXT_SET_OF + " " + IntToString(nSetSize) + ")";
      }

      sText = sItemDesc;
      if (sMenuType == "CPV")
      {
        string sDkGreen = GetLocalString(oModule, "CmdColorDkGreen");
        string sDkYellow = GetLocalString(oModule, "CmdColorDkYellow");
        sText += sDkGreen + "\nBuy$ = " + sDkYellow + IntToString(nBuyPrice) + "gp";
        sText += sDkGreen + ", Sell$ = " + sDkYellow + IntToString(nSellPrice) + "gp";
        sText += sDkGreen + ", Max Qty = " + sDkYellow + IntToString(nMaxQty);
      }
      else
      {
        sText += ", " + IntToString(nItemPrice) + "gp";
      }
      SetLocalString(oPC, "sCnrTokenText" + IntToString(27001+(nItemIndex-nItemIndexFirst)), sText);
    }
  }

  SetLocalInt(oPC, "nCnrRedOffset", 1);
  SetLocalInt(oPC, "nCnrGrnOffset", 1);
  SetLocalInt(oPC, "nCnrSubOffset", 1);
}

/////////////////////////////////////////////////////////
int CnrMerchantShowAsSubMenu(object oPC, int menuIndex)
{
  string sKeyToMenu = GetLocalString(oPC, "sCnrCurrentMenu");
  int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");
  int nSubMenuCount = GetLocalInt(GetModule(), sKeyToMenu + "_SubMenuCount");
  if (nSubMenuCount > 0)
  {
    // we are displaying sub menus
    if (((nMenuPage * CMD_SELECTIONS_PER_PAGE) + menuIndex) <= nSubMenuCount)
    {
      return TRUE;
    }
  }
  return FALSE;
}

/////////////////////////////////////////////////////////
void CnrAddMerchant(string sMerchantTag)
{
  object oModule = GetModule();

  // Check if the Merchant has slready been added
  int nMerchantCount = GetLocalInt(oModule, "CnrMerchantCount");
  int nIndex;
  for (nIndex=1; nIndex<=nMerchantCount; nIndex++)
  {
    string sExistingMerchantTag = GetLocalString(oModule, "CnrMerchantTag_" + IntToString(nIndex));
    if (sExistingMerchantTag == sMerchantTag)
    {
      // already exists, so don't add again
      return;
    }
  }

  nMerchantCount++;
  SetLocalString(oModule, "CnrMerchantTag_" + IntToString(nMerchantCount), sMerchantTag);
  SetLocalInt(oModule, "CnrMerchantCount", nMerchantCount);
}

/////////////////////////////////////////////////////////
void CmdIncrementStackCount(object oHost, string sStackCountName = "CmdStackCount")
{
  int nStackCount = GetLocalInt(oHost, sStackCountName) + 1;
  SetLocalInt(oHost, sStackCountName, nStackCount);
}

/////////////////////////////////////////////////////////
void CmdDecrementStackCount(object oHost, string sStackCountName = "CmdStackCount")
{
  int nStackCount = GetLocalInt(oHost, sStackCountName) - 1;
  SetLocalInt(oHost, sStackCountName, nStackCount);
}

/////////////////////////////////////////////////////////
void CmdSetStackCount(object oHost, int nStackCount, string sStackCountName = "CmdStackCount")
{
  SetLocalInt(oHost, sStackCountName, nStackCount);
}

/////////////////////////////////////////////////////////
int CmdGetStackCount(object oHost, string sStackCountName = "CmdStackCount")
{
  int nStackCount = GetLocalInt(oHost, sStackCountName);
  return nStackCount;
}

/////////////////////////////////////////////////////////
void CmdInitializeDeferredMerchantData(object oMerchant)
{
  object oModule = GetModule();
  string sMerchantTag = GetTag(oMerchant);
  string sItemTag;
  int nMaxOnHandQty;

  // This data had been deferred until we had a merchant object

  int nItemCount = GetLocalInt(oModule, sMerchantTag + "_ItemCount");
  int nItemIndex;
  for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
  {
    sItemTag = GetLocalString(oModule, sMerchantTag + "_TagOfItem_" + IntToString(nItemIndex));
    nMaxOnHandQty = GetLocalInt(oModule, sMerchantTag + "_MaxOfItem_" + IntToString(nItemIndex));
    SetLocalInt(oMerchant, "MaxOnHand_" + sItemTag, nMaxOnHandQty);
    DeleteLocalString(oModule, sMerchantTag + "_TagOfItem_" + IntToString(nItemIndex));
    DeleteLocalInt(oModule, sMerchantTag + "_MaxOfItem_" + IntToString(nItemIndex));
  }

  SetLocalInt(oModule, sMerchantTag + "_ItemCount", 0);

  int bInitReqd = GetLocalInt(oModule, sMerchantTag + "_GoldInitReqd");
  if (bInitReqd)
  {
    // clean out bioware spawned gold
    int nGold = GetGold(oMerchant);
    if (nGold > 0) TakeGoldFromCreature(nGold, oMerchant, TRUE);

    // restore persistent gold amount
    nGold = CmdGetPersistentInt(oModule, sMerchantTag + "_CmdGold");
    GiveGoldToCreature(oMerchant, nGold);

    SetLocalInt(oModule, sMerchantTag + "_GoldInitReqd", FALSE);
  }

  int nIndex;
  int nCount = GetLocalInt(oModule, sMerchantTag + "_PersistentCount");
  int bMakePersistent = GetLocalInt(oModule, sMerchantTag + "_MakePersistent");
  if (bMakePersistent)
  {
    for (nIndex=1; nIndex<=nCount; nIndex++)
    {
      sItemTag = GetLocalString(oModule, sMerchantTag + "_ItemTag_" + IntToString(nIndex));
      int nInitialOnHandQty = GetLocalInt(oModule, sMerchantTag + "_OnHandQty_" + IntToString(nIndex));
      CmdSetPersistentInt(oMerchant, "OnHandQty_" + sItemTag, nInitialOnHandQty);
      DeleteLocalString(oModule, sMerchantTag + "_ItemTag_" + IntToString(nIndex));
      DeleteLocalInt(oModule, sMerchantTag + "_OnHandQty_" + IntToString(nIndex));
    }
  }
  else if (CMD_BOOL_RESTORE_LOW_INVENTORIES_ON_LOAD)
  {
    for (nIndex=1; nIndex<=nCount; nIndex++)
    {
      sItemTag = GetLocalString(oModule, sMerchantTag + "_ItemTag_" + IntToString(nIndex));
      int nInitialOnHandQty = GetLocalInt(oModule, sMerchantTag + "_OnHandQty_" + IntToString(nIndex));
      int nCurrentQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sItemTag);
      if (nCurrentQty < nInitialOnHandQty)
      {
        CmdSetPersistentInt(oMerchant, "OnHandQty_" + sItemTag, nInitialOnHandQty);
      }
      DeleteLocalString(oModule, sMerchantTag + "_ItemTag_" + IntToString(nIndex));
      DeleteLocalInt(oModule, sMerchantTag + "_OnHandQty_" + IntToString(nIndex));
    }
  }

  SetLocalInt(oModule, sMerchantTag + "_PersistentCount", 0);
  SetLocalInt(oModule, sMerchantTag + "_MakePersistent", FALSE);

}

/////////////////////////////////////////////////////////
void CmdSpawnCraftablePlayerVendors()
{
  object oModule = GetModule();

  //CmdSetStackCount(oModule, 0);

  int nMerchantCount = GetLocalInt(oModule, "CnrMerchantCount");
  int nIndex;
  for (nIndex=1; nIndex<=nMerchantCount; nIndex++)
  {
    string sMerchantTag = GetLocalString(oModule, "CnrMerchantTag_" + IntToString(nIndex));
    if (sMerchantTag != "")
    {
      if (CpvGetPersistentInt(oModule, sMerchantTag + "_CpvEnabled") == TRUE)
      {
        // Defer processing to avoid TMI errors.
        //CmdIncrementStackCount(oModule);

        int bLocationFound = FALSE;
        location locMerchant;

        if (CpvGetPersistentInt(oModule, sMerchantTag + "_CpvShopIsOpen") == TRUE)
        {
          locMerchant = CpvGetPersistentLocation(oModule, sMerchantTag + "_CpvShopLoc");
          object oArea = GetAreaFromLocation(locMerchant);
          if (GetIsObjectValid(oArea))
          {
            bLocationFound = TRUE;
          }
        }

        if (!bLocationFound)
        {
          // find the location of the waypoint having the tag of CPV_<sMerchantTag>
          object oWP = GetObjectByTag("CPV_" + sMerchantTag);
          if (oWP != OBJECT_INVALID)
          {
            locMerchant = GetLocation(oWP);
            bLocationFound = TRUE;
          }
        }

        if (bLocationFound)
        {
          object oMerchant = CreateObject(OBJECT_TYPE_CREATURE, sMerchantTag, locMerchant, FALSE);

          if (CpvGetPersistentInt(oModule, sMerchantTag + "_CpvShopIsOpen") == TRUE)
          {
            ExecuteScript("cpv_open_shop", oMerchant);
          }
        }
      }
    }
  }
}

/////////////////////////////////////////////////////////
void CmdSpawnCraftablePlayerChests()
{
  object oModule = GetModule();
  string sChestId;

  int nChestCount = CpvGetPersistentInt(oModule, "CpvChestCount");

  int nChestIndex;
  for (nChestIndex=1; nChestIndex<=nChestCount; nChestIndex++)
  {
    sChestId = "CpvChest_" + IntToString(nChestIndex);
    int bChestIsInUse = CpvGetPersistentInt(oModule, sChestId + "_IsInUse");
    if (bChestIsInUse)
    {
      location locChest = CpvGetPersistentLocation(oModule, sChestId + "_Location");
      object oArea = GetAreaFromLocation(locChest);
      if (GetIsObjectValid(oArea))
      {
        object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "cpvVendorChest", locChest);
        if (oChest != OBJECT_INVALID)
        {
          SetLocalString(oChest, "CpvChestId", sChestId);
        }
      }
    }
  }
}

/////////////////////////////////////////////////////////
void CmdInitializeMerchant(string sMerchantTag, object oHost)
{
  ExecuteScript(sMerchantTag, oHost);

  // This code deferred by AssignCommand to avoid TMI errors.
  CmdDecrementStackCount(oHost);
}

/////////////////////////////////////////////////////////
void CmdTestIfAllMerchantsHaveBeenLoaded(object oHost)
{
  int nStackCount = CmdGetStackCount(oHost);
  if (nStackCount > 0)
  {
    DelayCommand(0.2f, CmdTestIfAllMerchantsHaveBeenLoaded(oHost));
  }
  else
  {
    CmdSpawnCraftablePlayerVendors();
    CmdSpawnCraftablePlayerChests();
  }
}

/////////////////////////////////////////////////////////
void CmdLoadAllMerchantsFromScript()
{
  object oModule = GetModule();

  CmdSetStackCount(oModule, 0);

  int nMerchantCount = GetLocalInt(oModule, "CnrMerchantCount");
  int nIndex;
  for (nIndex=1; nIndex<=nMerchantCount; nIndex++)
  {
    string sMerchantTag = GetLocalString(oModule, "CnrMerchantTag_" + IntToString(nIndex));
    if (sMerchantTag != "")
    {
      // Defer processing to avoid TMI errors.
      CmdIncrementStackCount(oModule);

      //AssignCommand(OBJECT_SELF, CmdInitializeMerchant(sMerchantTag, oModule));
      DelayCommand(0.2f, CmdInitializeMerchant(sMerchantTag, oModule));
    }
  }

  CmdTestIfAllMerchantsHaveBeenLoaded(oModule);
}

/////////////////////////////////////////////////////////
void CmdChargeCustomerForItem(object oLootBag, int bTheItemIsMissing)
{
  string sSellTag = GetLocalString(oLootBag, "CmdSellTag");
  int nGoldRequired = GetLocalInt(oLootBag, "CmdSellPrice");
  int nSetSize = GetLocalInt(oLootBag, "CmdSellSetSize");
  object oCustomer = GetLocalObject(oLootBag, "CmdCustomer");
  object oMerchant = GetLocalObject(oLootBag, "CmdMerchant");

  //if (bTheItemIsMissing)
  //{
  //  SendMessageToPC(oCustomer, "Charging for missing item!");
  //}

  int nGoldAvail = GetGold(oCustomer);
  if (nGoldAvail < nGoldRequired)
  {
    if (bTheItemIsMissing)
    {
      // Only stackable items can become missing - due to bioware bug.
      // Do this to prevent foul play.
      object oMissingItem = GetLocalObject(oLootBag, "CmdMissingItem");

      // Search customer's inventory for the missing sell item
      object oItem = GetFirstItemInInventory(oCustomer);
      while (oItem != OBJECT_INVALID)
      {
        if (GetTag(oItem) == sSellTag)
        {
          oMissingItem = oItem;
        }
        oItem = GetNextItemInInventory(oCustomer);
      }

      if (GetIsObjectValid(oMissingItem))
      {
        int nStackSize = GetNumStackedItems(oMissingItem);
        if (nStackSize == 1)
        {
          DestroyObject(oMissingItem);
        }
        else
        {
          SetItemStackSize(oMissingItem, nStackSize-1);
        }
      }
    }
    else
    {
      // Remove the item from the Customer's inventory
      CnrMerchantDestroyItemOnObject(sSellTag, oCustomer, 1);
    }

    if (GetIsObjectValid(oMerchant))
    {
      AssignCommand(oMerchant, ActionSpeakString(CMD_TEXT_YOU_DONT_HAVE_THE_GOLD));
      if (!bTheItemIsMissing)
      {
        AssignCommand(oMerchant, ActionStartConversation(oCustomer, "cnr_c_merchant2", TRUE));
      }
    }

    if (!bTheItemIsMissing)
    {
      CmdDestroyLootBag(oLootBag, FALSE);
    }

    return;
  }
  else
  {
    TakeGoldFromCreature(nGoldRequired, oCustomer, TRUE);

    // In CPV mode, the vendor holds the gold
    int bPlayerVendor = CpvGetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvEnabled");
    if (bPlayerVendor == TRUE)
    {
      CmdGiveGoldToMerchant(oMerchant, nGoldRequired);
    }

    // decrement the qty held by the merchant
    int nQtyOnHand = GetLocalInt(oLootBag, "CmdQtyOnHand") - nSetSize;
    if (nQtyOnHand < 0) nQtyOnHand = 0;
    SetLocalInt(oLootBag, "CmdQtyOnHand", nQtyOnHand);
    int nMenuIndex = GetLocalInt(oLootBag, "CmdMenuIndex");

    // synchronize the merchant's inventory
    CnrMerchantDecrementQtyOnHand(oMerchant, nMenuIndex, oCustomer, sSellTag, nSetSize);

    string sSellResRef = GetLocalString(oLootBag, "CmdSellResRef");

    // Only one Item was dragged to the PC's inventory.
    // Now create the remainder of the set.
    CnrMerchantCreateItemOnObject(sSellResRef, oCustomer, nSetSize-1);

    int bSellInfinite = GetLocalInt(oLootBag, "CmdSellInfinite");
    if ((bSellInfinite == TRUE) || (nQtyOnHand >= nSetSize))
    {
      // Create a new item for the PC to buy
      if (!bTheItemIsMissing)
      {
        object oItem = CreateItemOnObject(sSellResRef, oLootBag, 1);
        if (CXX_BOOL_FLAG_HANDLED_ITEMS_AS_IDENTIFIED)
        {
          SetIdentified(oItem, TRUE);
        }
        //SetLocalObject(oLootBag, "CmdSellItem", oItem);
      }
      return;
    }

    if (!bTheItemIsMissing)
    {
      // the merchant's inventory has been depleted, so go back to the convo
      if (GetIsObjectValid(oMerchant))
      {
        AssignCommand(oMerchant, ActionStartConversation(oCustomer, "cnr_c_merchant2", TRUE));
      }

      CmdDestroyLootBag(oLootBag, FALSE);
    }
  }
}

/////////////////////////////////////////////////////////
void CmdDestroyLootBag(object oLootBag, int bChargeForMissingItem)
{
  if (GetIsObjectValid(oLootBag))
  {
    location locLootBag = GetLocation(oLootBag);
    string sSellTag = GetLocalString(oLootBag, "CmdSellTag");

    int bChargeCustomer = TRUE;
    if (!bChargeForMissingItem)
    {
      bChargeCustomer = FALSE;
    }

    // Destroy all items in this container's inventory
    object oItem = GetFirstItemInInventory(oLootBag);
    while (oItem != OBJECT_INVALID)
    {
      if (GetTag(oItem) == sSellTag)
      {
        bChargeCustomer = FALSE;
      }
      else
      {
        CopyObject(oItem, locLootBag, OBJECT_INVALID);
      }
      DestroyObject(oItem);
      oItem = GetNextItemInInventory(oLootBag);
    }

    // if the item is missing, charge the customer for it!!!
    if (bChargeCustomer)
    {
      CmdChargeCustomerForItem(oLootBag, TRUE);
    }

    // Destroy the container too
    DestroyObject(oLootBag);
  }
}

/////////////////////////////////////////////////////////
void CmdClearMerchantBuyData(string sKeyToMenu)
{
  object oModule = GetModule();

  int nSubCount = GetLocalInt(oModule, sKeyToMenu + "_SubMenuCount");
  DeleteLocalInt(oModule, sKeyToMenu + "_SubMenuCount");
  if (nSubCount > 0)
  {
    int nIndex;
    for (nIndex=1; nIndex<=nSubCount; nIndex++)
    {
      string sKeyToSubMenu = sKeyToMenu + "_" + IntToString(nIndex);
      CmdClearMerchantBuyData(sKeyToSubMenu);
    }
  }
  else
  {
    int nItemCount = GetLocalInt(oModule, sKeyToMenu + "_BuyCount");
    DeleteLocalInt(oModule, sKeyToMenu + "_BuyCount");

    // neutered to reduce lag
    //int nIndex;
    //for (nIndex=1; nIndex<=nItemCount; nIndex++)
    //{
    //  DeleteLocalString(oModule, sKeyToMenu + "_BuyDesc_" + IntToString(nIndex));
    //  DeleteLocalString(oModule, sKeyToMenu + "_BuyTag_" + IntToString(nIndex));
    //  DeleteLocalInt(oModule, sKeyToMenu + "_BuyPrice_" + IntToString(nIndex));
    //  DeleteLocalInt(oModule, sKeyToMenu + "_BuyInfinite_" + IntToString(nIndex));
    //  DeleteLocalInt(oModule, sKeyToMenu + "_BuySetSize_" + IntToString(nIndex));
    //}
  }
}

/////////////////////////////////////////////////////////
void CmdClearMerchantSellData(string sKeyToMenu)
{
  object oModule = GetModule();

  int nSubCount = GetLocalInt(oModule, sKeyToMenu + "_SubMenuCount");
  DeleteLocalInt(oModule, sKeyToMenu + "_SubMenuCount");
  if (nSubCount > 0)
  {
    int nIndex;
    for (nIndex=1; nIndex<=nSubCount; nIndex++)
    {
      string sKeyToSubMenu = sKeyToMenu + "_" + IntToString(nIndex);
      CmdClearMerchantSellData(sKeyToSubMenu);
    }
  }
  else
  {
    int nItemCount = GetLocalInt(oModule, sKeyToMenu + "_SellCount");
    DeleteLocalInt(oModule, sKeyToMenu + "_SellCount");

    // neutered to reduce lag
    //int nIndex;
    //for (nIndex=1; nIndex<=nItemCount; nIndex++)
    //{
    //  DeleteLocalString(oModule, sKeyToMenu + "_SellDesc_" + IntToString(nIndex));
    //  DeleteLocalString(oModule, sKeyToMenu + "_SellTag_" + IntToString(nIndex));
    //  DeleteLocalInt(oModule, sKeyToMenu + "_SellPrice_" + IntToString(nIndex));
    //  DeleteLocalInt(oModule, sKeyToMenu + "_SellInfinite_" + IntToString(nIndex));
    //  DeleteLocalInt(oModule, sKeyToMenu + "_SellSetSize_" + IntToString(nIndex));
    //}
  }
}

/////////////////////////////////////////////////////////
void CmdClearMerchantCpvData(string sKeyToMenu)
{
  object oModule = GetModule();

  int nSubCount = GetLocalInt(oModule, sKeyToMenu + "_SubMenuCount");
  DeleteLocalInt(oModule, sKeyToMenu + "_SubMenuCount");

  if (nSubCount > 0)
  {
    int nIndex;
    for (nIndex=1; nIndex<=nSubCount; nIndex++)
    {
      string sKeyToSubMenu = sKeyToMenu + "_" + IntToString(nIndex);
      CmdClearMerchantCpvData(sKeyToSubMenu);
    }
  }
  else
  {
    int nItemCount = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvCount");
    CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvCount", 0);

    // neutered to reduce lag
    //int nIndex;
    //for (nIndex=1; nIndex<=nItemCount; nIndex++)
    //{
    //  CpvDeletePersistentString(oModule, sKeyToMenu + "_CpvDesc_" + IntToString(nIndex));
    //  CpvDeletePersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nIndex));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvBuyPrice_" + IntToString(nIndex));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvSellPrice_" + IntToString(nIndex));
    //  //CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvInfinite_" + IntToString(nIndex));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvSetSize_" + IntToString(nIndex));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvMaxQty_" + IntToString(nIndex));
    //}
  }
}

/////////////////////////////////////////////////////////
void CmdClearMerchantInventory(object oMerchant)
{
  string sMerchantTag = GetTag(oMerchant);
  CmdClearMerchantBuyData("BUY" + sMerchantTag);
  CmdClearMerchantSellData("SELL" + sMerchantTag);
  //CmdClearMerchantCpvData("CPV" + sMerchantTag);
}
