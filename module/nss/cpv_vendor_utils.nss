/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_vendor_utils
//
//  Desc:  A collection of functions specifically written
//         for player vendors.
//
//  Author: David Bobeck
//
/////////////////////////////////////////////////////////

#include "cnr_merch_utils"
#include "cmd_config_v47"

/////////////////////////////////////////////////////////
void CpvDestroyVendorChest(object oChest)
{
  string sChestId = GetLocalString(oChest, "CpvChestId");
  CpvSetPersistentInt(GetModule(), sChestId + "_IsInUse", FALSE);
  DestroyObject(oChest);
}

/////////////////////////////////////////////////////////
void CpvDeleteVendorInventory(string sKeyToMenu)
{
  object oModule = GetModule();

  // neutered to reduce lag
  //int nItemCount = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvCount");
  //int nItemIndex;
  //for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
  //{
  //  CpvDeletePersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nItemIndex));
  //  CpvDeletePersistentString(oModule, sKeyToMenu + "_CpvDesc_" + IntToString(nItemIndex));
  //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvBuyPrice_" + IntToString(nItemIndex));
  //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvSellPrice_" + IntToString(nItemIndex));
  //  //CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvInfinite_" + IntToString(nItemIndex));
  //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvSetSize_" + IntToString(nItemIndex));
  //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nItemIndex));
  //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvMaxQty_" + IntToString(nItemIndex));
  //}

  CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvCount", 0);
}

/////////////////////////////////////////////////////////
void CpvCleanVendorInventory(string sKeyToMenu)
{
  object oModule = GetModule();

  int nItemCountNew = 0;

  int nItemCountOld = CnrMerchantGetCpvCount(sKeyToMenu);
  int nItemIndexOld;
  for (nItemIndexOld=1; nItemIndexOld<=nItemCountOld; nItemIndexOld++)
  {
    int nQty = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nItemIndexOld));
    if (nQty > 0)
    {
      nItemCountNew++;
      if (nItemIndexOld > nItemCountNew)
      {
        string sCpvTag = CpvGetPersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nItemIndexOld));
        string sCpvDesc = CpvGetPersistentString(oModule, sKeyToMenu + "_CpvDesc_" + IntToString(nItemIndexOld));
        int nCpvBuyPrice = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvBuyPrice_" + IntToString(nItemIndexOld));
        int nCpvSellPrice = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvSellPrice_" + IntToString(nItemIndexOld));
        //int nCpvInfinite = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvInfinite_" + IntToString(nItemIndexOld));
        int nCpvSetSize = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvSetSize_" + IntToString(nItemIndexOld));
        int nCpvQty = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nItemIndexOld));
        int nCpvMaxQty = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvMaxQty_" + IntToString(nItemIndexOld));

        CpvSetPersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nItemCountNew), sCpvTag);
        CpvSetPersistentString(oModule, sKeyToMenu + "_CpvDesc_" + IntToString(nItemCountNew), sCpvDesc);
        CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvBuyPrice_" + IntToString(nItemCountNew), nCpvBuyPrice);
        CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvSellPrice_" + IntToString(nItemCountNew), nCpvSellPrice);
        //CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvInfinite_" + IntToString(nItemCountNew), nCpvInfinite);
        CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvSetSize_" + IntToString(nItemCountNew), nCpvSetSize);
        CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nItemCountNew), nCpvQty);
        CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvMaxQty_" + IntToString(nItemCountNew), nCpvMaxQty);
      }
    }

    // neutered to reduce lag
    //if (nItemIndexOld > nItemCountNew)
    //{
    //  CpvDeletePersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nItemIndexOld));
    //  CpvDeletePersistentString(oModule, sKeyToMenu + "_CpvDesc_" + IntToString(nItemIndexOld));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvBuyPrice_" + IntToString(nItemIndexOld));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvSellPrice_" + IntToString(nItemIndexOld));
    //  //CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvInfinite_" + IntToString(nItemIndexOld));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvSetSize_" + IntToString(nItemIndexOld));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nItemIndexOld));
    //  CpvDeletePersistentInt(oModule, sKeyToMenu + "_CpvMaxQty_" + IntToString(nItemIndexOld));
    //}
  }

  CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvCount", nItemCountNew);
}

/////////////////////////////////////////////////////////
void CpvZeroVendorInventory(string sKeyToMenu)
{
  object oModule = GetModule();

  int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
  int nItemIndex;
  for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
  {
    CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nItemIndex), 0);
  }
}

/////////////////////////////////////////////////////////
void CpvStockChestsVirtualInventory(string sKeyToMenu, object oChest)
{
  object oModule = GetModule();
  string sChestId = GetLocalString(oChest, "CpvChestId");

  int nSubCount = GetLocalInt(oModule, sKeyToMenu + "_SubMenuCount");
  if (nSubCount > 0)
  {
    int nIndex;
    for (nIndex=1; nIndex<=nSubCount; nIndex++)
    {
      string sKeyToSubMenu = sKeyToMenu + "_" + IntToString(nIndex);

      CmdIncrementStackCount(oChest, "CpvStockChestsVirtualInventory");
      DelayCommand(0.2, CpvStockChestsVirtualInventory(sKeyToSubMenu, oChest));
    }
  }
  else
  {
    int nSourceCount = CnrMerchantGetCpvCount(sKeyToMenu);
    int nSourceIndex;
    for (nSourceIndex=1; nSourceIndex<=nSourceCount; nSourceIndex++)
    {
      string sItemTag = CpvGetPersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nSourceIndex));
      int nItemQty = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nSourceIndex));

      // Determine if we already have a matching tag
      int nItemCount = CpvGetPersistentInt(oModule, sChestId + "_CpvCount");
      int nMatchingIndex = nItemCount + 1;
      int nQtyOfItem = nItemQty;

      if (CPV_BOOL_CONSOLIDATE_VIRTUAL_INVENTORY)
      {
        int nIndex;
        for (nIndex=1; nIndex<=nItemCount; nIndex++)
        {
          string sTagOfItem = CpvGetPersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nIndex));
          if (sTagOfItem == sItemTag)
          {
            // we have a match
            nMatchingIndex = nIndex;
            nQtyOfItem = CpvGetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nIndex)) + nItemQty;
          }
        }
      }

      if (nMatchingIndex == (nItemCount + 1))
      {
        CpvSetPersistentInt(oModule, sChestId + "_CpvCount", nMatchingIndex);
        CpvSetPersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nMatchingIndex), sItemTag);
      }

      CpvSetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nMatchingIndex), nQtyOfItem);
    }

    CpvDeleteVendorInventory(sKeyToMenu);
  }

  CmdDecrementStackCount(oChest, "CpvStockChestsVirtualInventory");
}

/////////////////////////////////////////////////////////
string CpvGetEmptyChestId()
{
  object oModule = GetModule();
  string sChestId;

  int nChestCount = CpvGetPersistentInt(oModule, "CpvChestCount");

  int nChestIndex;
  for (nChestIndex=1; nChestIndex<=nChestCount; nChestIndex++)
  {
    sChestId = "CpvChest_" + IntToString(nChestIndex);
    int bChestIsInUse = CpvGetPersistentInt(oModule, sChestId + "_IsInUse");
    if (!bChestIsInUse)
    {
      CpvSetPersistentInt(oModule, sChestId + "_IsInUse", TRUE);
      return sChestId;
    }
  }

  // None empty, so add a new one
  nChestCount++;
  CpvSetPersistentInt(oModule, "CpvChestCount", nChestCount);
  sChestId = "CpvChest_" + IntToString(nChestCount);
  CpvSetPersistentInt(oModule, sChestId + "_IsInUse", TRUE);
  return sChestId;
}

/////////////////////////////////////////////////////////
void WaitForCpvStockChestsVirtualInventoryToFinish(object oChest)
{
  int nStackCount = CmdGetStackCount(oChest, "CpvStockChestsVirtualInventory");
  if (nStackCount > 0)
  {
    // keep waiting
    DelayCommand(0.2, WaitForCpvStockChestsVirtualInventoryToFinish(oChest));
  }
  else
  {
    string sChestId = GetLocalString(oChest, "CpvChestId");

    // if the chest is empty, destroy it to prevent unnecessary trash in PW
    int nItemCount = CpvGetPersistentInt(GetModule(), sChestId + "_CpvCount");
    if (nItemCount == 0)
    {
      CpvDestroyVendorChest(oChest);
    }
  }
}

/////////////////////////////////////////////////////////
void CpvMakeChestPersistent(object oChest, object oVendor, int nGold)
{
  object oModule = GetModule();

  string sChestId = CpvGetEmptyChestId();
  SetLocalString(oChest, "CpvChestId", sChestId);

  location locChest = GetLocation(oChest);
  string sEmployerKey = GetLocalString(oChest, "CpvEmployerKey");

  CpvSetPersistentLocation(oModule, sChestId + "_Location", locChest);
  CpvSetPersistentString(oModule, sChestId + "_EmployerKey", sEmployerKey);
  CpvSetPersistentInt(oModule, sChestId + "_Gold", nGold);

  // CpvStockChestsVirtualInventory is asynchronous - it uses AssignCommand to avoid TMI
  CmdSetStackCount(oChest, 1, "CpvStockChestsVirtualInventory");
  CpvStockChestsVirtualInventory("CPV"+GetTag(oVendor), oChest);

  DelayCommand(0.2, WaitForCpvStockChestsVirtualInventoryToFinish(oChest));
}

/////////////////////////////////////////////////////////
void CpvDropAllInventory(object oVendor)
{
  object oModule = GetModule();
  string sVendorTag = GetTag(oVendor);

  location locVendor = GetLocation(oVendor);

  // Position the chest in front of the vendor so they don't
  // move and/or turn around when it's created.
  float fFacing = GetFacingFromLocation(locVendor);
  vector vChestPos = GetPosition(oVendor);
  float fDistanceX = cos(fFacing) * 1.0;
  float fDistanceY = sin(fFacing) * 1.0;

  // spin the chest around
  fFacing = fFacing + 180.0f;
  CnrMerchantNormalizeFacing(fFacing);

  vChestPos.x += fDistanceX;
  vChestPos.y += fDistanceY;
  location locChest = Location(GetArea(oVendor), vChestPos, fFacing);

  string sEmployerKey = CpvGetPersistentString(oModule, GetTag(oVendor) + "_CpvEmployer");

  // clear some flags that enable the vendor
  CpvSetPersistentString(oModule, GetTag(oVendor) + "_CpvEmployer", "");
  CpvSetPersistentString(oModule, GetTag(oVendor) + "_CpvEmployerName", "");
  CpvSetPersistentInt(oModule, GetTag(oVendor) + "_CpvShopIsOpen", FALSE);
  CpvSetPersistentInt(oModule, GetTag(oVendor) + "_CpvShowName", FALSE);
  CpvSetPersistentInt(oModule, GetTag(oVendor) + "_CpvDaysContracted", 0);

  // create the chest
  object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "cpvVendorChest", locChest, FALSE);
  SetLocalString(oChest, "CpvEmployerKey", sEmployerKey);

  // put all the player's gold in the chest as well
  int nGold = CmdGetMerchantGold(oVendor);
  CmdTakeGoldFromMerchant(oVendor, nGold);

  // make the chest persistent
  CpvMakeChestPersistent(oChest, oVendor, nGold);

  // send the vendor off to their starting location
  object oWP = GetObjectByTag("CPV_" + GetTag(oVendor));
  if (oWP != OBJECT_INVALID)
  {
    AssignCommand(oVendor, ClearAllActions());
    DelayCommand(2.5f, AssignCommand(oVendor, ActionMoveToObject(oWP)));
  }
}

/////////////////////////////////////////////////////////
void CpvAdjustInventory()
{
  object oPC = GetPCSpeaker();
  location locPC = GetLocation(oPC);
  object oModule = GetModule();
  string sVendorTag = GetTag(OBJECT_SELF);

  // Position the lootbag in front of the PC so they don't
  // move and/or turn around when they "use" it.
  float fFacing = GetFacingFromLocation(locPC);
  vector vVendorBagPos = GetPosition(oPC);
  float fDistanceX = cos(fFacing) * 0.5;
  float fDistanceY = sin(fFacing) * 0.5;
  vVendorBagPos.x += fDistanceX;
  vVendorBagPos.y += fDistanceY;
  location locVendorBag = Location(GetArea(oPC), vVendorBagPos, fFacing);

  // create a new vendor bag
  object oVendorBag = CreateObject(OBJECT_TYPE_PLACEABLE, "cpvInvBag", locVendorBag, FALSE);
  SetLocalObject(oVendorBag, "CpvVendor", OBJECT_SELF);

  string sKeyToMenu = GetLocalString(oPC, "sCnrCurrentMenu");

  // create the vendor inventory from virtual data
  int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
  int nIndex;
  for (nIndex=1; nIndex<=nItemCount; nIndex++)
  {
    string sItemTag = CpvGetPersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nIndex));
    int nQtyOfItem = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nIndex));
    CnrMerchantCreateItemOnObject(sItemTag, oVendorBag, nQtyOfItem);
  }

  // Make the vendor's gold available too
  int nQtyOfGold = CmdGetMerchantGold(OBJECT_SELF);
  if (nQtyOfGold > 0)
  {
    CmdTakeGoldFromMerchant(OBJECT_SELF, nQtyOfGold);

    while (nQtyOfGold >= 50000)
    {
      CreateItemOnObject("NW_IT_GOLD001", oVendorBag, 50000);
      nQtyOfGold -= 50000;
    }
    if (nQtyOfGold > 0)
    {
      CreateItemOnObject("NW_IT_GOLD001", oVendorBag, nQtyOfGold);
    }
  }

  AssignCommand(oPC, DelayCommand(0.5, ActionInteractObject(oVendorBag)));
}

/////////////////////////////////////////////////////////
void CpvCloseInventoryBagHelper(object oInventoryBag, object oUser, object oItem)
{
  object oModule = GetModule();
  object oVendor = GetLocalObject(oInventoryBag, "CpvVendor");

  if (GetIsObjectValid(oVendor))
  {
    int nStackSize = GetNumStackedItems(oItem);

    // If gold, move to NPC's purse
    if (GetTag(oItem) == "NW_IT_GOLD001")
    {
      CmdGiveGoldToMerchant(oVendor, nStackSize);
    }
    else
    {
      int bAllowThisItem = TRUE;

      if (CPV_BOOL_ALLOW_STACKABLE_ITEMS == FALSE)
      {
        // don't accept stackable items (avoid exploit)
        int eBaseType = GetBaseItemType(oItem);
        switch (eBaseType)
        {
          case BASE_ITEM_POTIONS:
          case BASE_ITEM_DART:
          case BASE_ITEM_GEM:
          case BASE_ITEM_BULLET:
          case BASE_ITEM_BOLT:
          case BASE_ITEM_ARROW:
          {
            bAllowThisItem = FALSE;
            AssignCommand(oVendor, ActionSpeakString(CPV_TEXT_I_CANT_PEDDLE + GetName(oItem)));
            CnrMerchantCreateItemOnObject(GetResRef(oItem), oUser, nStackSize);
            break;
          }
        }
      }

      if (CPV_BOOL_ALLOW_STOLEN_ITEMS == FALSE)
      {
        if (GetStolenFlag(oItem))
        {
          bAllowThisItem = FALSE;
          AssignCommand(oVendor, ActionSpeakString(CPV_TEXT_I_WILL_NOT_PEDDLE_STOLEN_GOODS + GetName(oItem)));
          CnrMerchantCreateItemOnObject(GetResRef(oItem), oUser, nStackSize);
        }
      }

      if (CPV_BOOL_ALLOW_PLOT_ITEMS == FALSE)
      {
        if (GetPlotFlag(oItem))
        {
          bAllowThisItem = FALSE;
          AssignCommand(oVendor, ActionSpeakString(CPV_TEXT_I_CANT_PEDDLE + GetName(oItem)));
          CnrMerchantCreateItemOnObject(GetResRef(oItem), oUser, nStackSize);
        }
      }

      if (bAllowThisItem)
      {
        // Determine if we already have a matching tag
        string sKeyToMenu = GetLocalString(oUser, "sCnrCurrentMenu");
        int nItemCount = CnrMerchantGetCpvCount(sKeyToMenu);
        int nMatchingIndex = nItemCount + 1;
        int nQtyOfItem = nStackSize;

        //if (CPV_BOOL_CONSOLIDATE_VIRTUAL_INVENTORY)
        {
          int nIndex;
          for (nIndex=1; nIndex<=nItemCount; nIndex++)
          {
            string sTagOfItem = CpvGetPersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nIndex));
            if (sTagOfItem == GetTag(oItem))
            {
              // we have a match
              nMatchingIndex = nIndex;
              nQtyOfItem = CpvGetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nIndex)) + nStackSize;
            }
          }
        }

        if (nMatchingIndex == (nItemCount + 1))
        {
          CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvCount", nMatchingIndex);
          CpvSetPersistentString(oModule, sKeyToMenu + "_CpvTag_" + IntToString(nMatchingIndex), GetTag(oItem));
          CpvSetPersistentString(oModule, sKeyToMenu + "_CpvDesc_" + IntToString(nMatchingIndex), GetName(oItem));
          CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvSetSize_" + IntToString(nMatchingIndex), 1);
          CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvMaxQty_" + IntToString(nMatchingIndex), 1000);
        }

        CpvSetPersistentInt(oModule, sKeyToMenu + "_CpvQty_" + IntToString(nMatchingIndex), nQtyOfItem);
      }
    }
  }

  CmdDecrementStackCount(oUser, "CpvCloseInventoryBagCount");
}

/////////////////////////////////////////////////////////
void LoopUntilBagTransferCompletes(object oInventoryBag, object oUser)
{
  int nStackCount =  CmdGetStackCount(oUser, "CpvCloseInventoryBagCount");
  if (nStackCount > 1)
  {
    AssignCommand(OBJECT_SELF, LoopUntilBagTransferCompletes(oInventoryBag, oUser));
  }
  else
  {
    string sKeyToMenu = GetLocalString(oUser, "sCnrCurrentMenu");

    // destroy all physical items
    object oItem = GetFirstItemInInventory(oInventoryBag);
    while (oItem != OBJECT_INVALID)
    {
      DestroyObject(oItem);
      oItem = GetNextItemInInventory(oInventoryBag);
    }

    // clean the vendor's virtual inventory that has Qty == 0
    CpvCleanVendorInventory(sKeyToMenu);

    CmdSetStackCount(oUser, 0, "CpvCloseInventoryBagCount");
  }
}

/////////////////////////////////////////////////////////
void CpvCloseInventoryBag(object oInventoryBag, object oUser)
{
  if (GetIsObjectValid(oInventoryBag))
  {
    string sKeyToMenu = GetLocalString(oUser, "sCnrCurrentMenu");

    // zero the vendor's virtual inventory
    CpvZeroVendorInventory(sKeyToMenu);

    int bAlertAboutStackables = FALSE;

    // transfer all items in this container's inventory to the vendor's virtual inventory
    object oItem = GetFirstItemInInventory(oInventoryBag);
    while (oItem != OBJECT_INVALID)
    {
      CmdIncrementStackCount(oUser, "CpvCloseInventoryBagCount");
      AssignCommand(OBJECT_SELF, CpvCloseInventoryBagHelper(oInventoryBag, oUser, oItem));
      oItem = GetNextItemInInventory(oInventoryBag);
    }

    AssignCommand(OBJECT_SELF, LoopUntilBagTransferCompletes(oInventoryBag, oUser));
  }
}

/////////////////////////////////////////////////////////
void CpvInitializeVendorSubMenus(string sKeyToMenu, object oVendor)
{
  int m;
  string sKeyToSubMenu;

  int nSubMenuCount = GetLocalInt(GetModule(), sKeyToMenu + "_SubMenuCount");
  for (m=1; m<=nSubMenuCount; m++)
  {
    CmdIncrementStackCount(oVendor, "CpvInitializeVendorSubMenus");
    sKeyToSubMenu = sKeyToMenu + "_" + IntToString(m);
    //DelayCommand(0.2f, CpvInitializeVendorSubMenus(sKeyToSubMenu, oVendor));
    CpvInitializeVendorSubMenus(sKeyToSubMenu, oVendor);
  }

  if (nSubMenuCount == 0)
  {
    CnrMerchantBuildAncestorMenus("CPV", sKeyToMenu);
  }

  // This code deferred by AssignCommand to avoid TMI errors.
  CmdDecrementStackCount(oVendor, "CpvInitializeVendorSubMenus");
}

/////////////////////////////////////////////////////////
void CpvDoSelection(int nSelIndex)
{
  object oModule = GetModule();
  object oPC = GetPCSpeaker();
  string sKeyToCurrentMenu = GetLocalString(oPC, "sCnrCurrentMenu");
  //int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");
  int nItemIndex = GetLocalInt(oPC, "CpvItemIndex");

  int nDelta = 0;
  if (nSelIndex == 0) nDelta = 10000;
  else if (nSelIndex == 1) nDelta = 1000;
  else if (nSelIndex == 2) nDelta = 100;
  else if (nSelIndex == 3) nDelta = 10;
  else if (nSelIndex == 4) nDelta = 1;
  else if (nSelIndex == 5) nDelta = -1;
  else if (nSelIndex == 6) nDelta = -10;
  else if (nSelIndex == 7) nDelta = -100;
  else if (nSelIndex == 8) nDelta = -1000;
  else if (nSelIndex == 9) nDelta = -10000;

  string sCpvConfigType = GetLocalString(oPC, "CpvConfigType");
  if (sCpvConfigType == "SET_SIZE")
  {
    int nSetSize = CpvGetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvSetSize_" + IntToString(nItemIndex)) + nDelta;
    if (nSetSize < 1) nSetSize = 1;
    CpvSetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvSetSize_" + IntToString(nItemIndex), nSetSize);
  }
  else if (sCpvConfigType == "BUY_PRICE")
  {
    int nBuyPrice = CpvGetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvBuyPrice_" + IntToString(nItemIndex)) + nDelta;
    if (nBuyPrice < 0) nBuyPrice = 0;
    CpvSetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvBuyPrice_" + IntToString(nItemIndex), nBuyPrice);
  }
  else if (sCpvConfigType == "SELL_PRICE")
  {
    int nSellPrice = CpvGetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvSellPrice_" + IntToString(nItemIndex)) + nDelta;
    if (nSellPrice < 0) nSellPrice = 0;
    CpvSetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvSellPrice_" + IntToString(nItemIndex), nSellPrice);
  }
  else if (sCpvConfigType == "MAX_QTY")
  {
    int nMaxQty = CpvGetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvMaxQty_" + IntToString(nItemIndex)) + nDelta;
    if (nMaxQty < 1) nMaxQty = 1;
    CpvSetPersistentInt(oModule, sKeyToCurrentMenu + "_CpvMaxQty_" + IntToString(nItemIndex), nMaxQty);
  }
  else if (sCpvConfigType == "HOURS")
  {
    int nDaysAdjusted = GetLocalInt(OBJECT_SELF, "CpvDaysAdjusted") + nDelta;
    if (nDaysAdjusted < 0) nDaysAdjusted = 0;
    SetLocalInt(OBJECT_SELF, "CpvDaysAdjusted", nDaysAdjusted);
  }

}

/////////////////////////////////////////////////////////
void CpvAddPersistentItem(string sKeyToMenu, string sItemDesc, string sItemTag, int nBuyPrice, int nSellPrice, string sKeyToCpvQty, int nMaxOnHandQty, int nSetSize=1)
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
    SetLocalInt(oModule, sKeyToBuyMenu + "_BuyInfinite_" + IntToString(nBuyCount), FALSE);
    SetLocalInt(oModule, sKeyToBuyMenu + "_BuySetSize_" + IntToString(nBuyCount), nSetSize);
    SetLocalString(oModule, sKeyToBuyMenu + "_KeyToQty_" + IntToString(nBuyCount), sKeyToCpvQty);
    SetLocalInt(oModule, sKeyToBuyMenu + "_MaxOfItem_" + IntToString(nBuyCount), nMaxOnHandQty);
  }

  if (nSellPrice > 0)
  {
    string sKeyToSellMenu = CnrMerchantBuildAncestorMenus("SELL", sKeyToMenu);

    int nSellCount = GetLocalInt(oModule, sKeyToSellMenu + "_SellCount") + 1;
    SetLocalInt(oModule, sKeyToSellMenu + "_SellCount", nSellCount);

    SetLocalString(oModule, sKeyToSellMenu + "_SellDesc_" + IntToString(nSellCount), sItemDesc);
    SetLocalString(oModule, sKeyToSellMenu + "_SellTag_" + IntToString(nSellCount), sItemTag);
    SetLocalInt(oModule, sKeyToSellMenu + "_SellPrice_" + IntToString(nSellCount), nSellPrice);
    SetLocalInt(oModule, sKeyToSellMenu + "_SellInfinite_" + IntToString(nSellCount), FALSE);
    SetLocalInt(oModule, sKeyToSellMenu + "_SellSetSize_" + IntToString(nSellCount), nSetSize);
    SetLocalString(oModule, sKeyToSellMenu + "_KeyToQty_" + IntToString(nSellCount), sKeyToCpvQty);
  }
}

/////////////////////////////////////////////////////////
void CpvStockMerchantInventory(string sKeyToCpvMenu)
{
  object oModule = GetModule();

  int nSubCount = GetLocalInt(oModule, sKeyToCpvMenu + "_SubMenuCount");
  if (nSubCount > 0)
  {
    int nIndex;
    for (nIndex=1; nIndex<=nSubCount; nIndex++)
    {
      string sKeyToSubMenu = sKeyToCpvMenu + "_" + IntToString(nIndex);
      CpvStockMerchantInventory(sKeyToSubMenu);
    }
  }
  else
  {
    // remove the "CPV" from the menu key
    int nLen = GetStringLength(sKeyToCpvMenu);
    string sKeyToCmdMenu = GetStringRight(sKeyToCpvMenu, nLen - 3);

    int nSourceCount = CnrMerchantGetCpvCount(sKeyToCpvMenu);
    int nSourceIndex;
    for (nSourceIndex=1; nSourceIndex<=nSourceCount; nSourceIndex++)
    {
      string sItemTag = CpvGetPersistentString(oModule, sKeyToCpvMenu + "_CpvTag_" + IntToString(nSourceIndex));
      string sItemDesc = CpvGetPersistentString(oModule, sKeyToCpvMenu + "_CpvDesc_" + IntToString(nSourceIndex));
      int nBuyPrice = CpvGetPersistentInt(oModule, sKeyToCpvMenu + "_CpvBuyPrice_" + IntToString(nSourceIndex));
      int nSellPrice = CpvGetPersistentInt(oModule, sKeyToCpvMenu + "_CpvSellPrice_" + IntToString(nSourceIndex));
      int nSetSize = CpvGetPersistentInt(oModule, sKeyToCpvMenu + "_CpvSetSize_" + IntToString(nSourceIndex));
      int nMaxQty = CpvGetPersistentInt(oModule, sKeyToCpvMenu + "_CpvMaxQty_" + IntToString(nSourceIndex));
      string sKeyToCpvQty = sKeyToCpvMenu + "_CpvQty_" + IntToString(nSourceIndex);

      CpvAddPersistentItem(sKeyToCmdMenu, sItemDesc, sItemTag, nBuyPrice, nSellPrice, sKeyToCpvQty, nMaxQty, nSetSize);
    }
  }
}

/////////////////////////////////////////////////////////
void CpvTestIfVendorSubMenusAreInitialized(object oMerchant)
{
  int nStackCount = CmdGetStackCount(oMerchant, "CpvInitializeVendorSubMenus");
  if (nStackCount > 0)
  {
    DelayCommand(0.2f, CpvTestIfVendorSubMenusAreInitialized(oMerchant));
  }
  else
  {
    CpvStockMerchantInventory("CPV" + GetTag(oMerchant));
    CpvSetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvShopIsOpen", TRUE);
  }
}

/////////////////////////////////////////////////////////
void CpvWorkAnHour(object oMerchant)
{
  int bShopIsOpen = CpvGetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvShopIsOpen");
  if (bShopIsOpen == FALSE) return;

  int nDaysContracted = CpvGetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvDaysContracted");
  int nHoursElapsed = CpvGetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvHoursElapsed") + 1;
  if (nHoursElapsed >= 24)
  {
    nHoursElapsed = 0;
    nDaysContracted = nDaysContracted - 1;
  }

  CpvSetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvDaysContracted", nDaysContracted);
  CpvSetPersistentInt(GetModule(), GetTag(oMerchant) + "_CpvHoursElapsed", nHoursElapsed);

  if (nDaysContracted == 0)
  {
    // Terminate the contract. Drop the inventory.
    CpvDropAllInventory(oMerchant);
  }
  else
  {
    float fSecsPerHour = HoursToSeconds(1);
    DelayCommand(fSecsPerHour, CpvWorkAnHour(oMerchant));
  }
}

/////////////////////////////////////////////////////////
void CpvOpenShop(object oMerchant)
{
  CmdClearMerchantInventory(oMerchant);

  // CpvInitializeVendor is asynchronous - it uses AssignCommand to avoid TMI
  CmdSetStackCount(oMerchant, 1, "CpvInitializeVendorSubMenus");
  CpvInitializeVendorSubMenus(GetTag(oMerchant), oMerchant);
  CpvTestIfVendorSubMenusAreInitialized(oMerchant);

  float fSecsPerHour = HoursToSeconds(1);
  DelayCommand(fSecsPerHour, CpvWorkAnHour(oMerchant));
}

/////////////////////////////////////////////////////////
void CpvWipePlayerChest(string sPlayerKey)
{
  object oModule = GetModule();
  string sChestId;

  // find and destroy all chests belonging to the pc
  int nChestCount = CpvGetPersistentInt(oModule, "CpvChestCount");

  int nChestIndex;
  for (nChestIndex=1; nChestIndex<=nChestCount; nChestIndex++)
  {
    sChestId = "CpvChest_" + IntToString(nChestIndex);
    int bChestIsInUse = CpvGetPersistentInt(oModule, sChestId + "_IsInUse");
    if (bChestIsInUse)
    {
      // determine if this chest belongs to the PC
      string sEmployerKey = CpvGetPersistentString(oModule, sChestId + "_EmployerKey");
      if (sPlayerKey == sEmployerKey)
      {
        CpvSetPersistentInt(oModule, sChestId + "_IsInUse", FALSE);

        // find the chest object
        int bFound = FALSE;
        int nObjectIndex;
        for (nObjectIndex=0; nObjectIndex<=nChestCount && !bFound; nObjectIndex++)
        {
          object oChest = GetObjectByTag("cpvVendorChest", nObjectIndex);
          string sTargetId = GetLocalString(oChest, "CpvChestId");
          if (sTargetId == sChestId)
          {
            int nItemCount = CpvGetPersistentInt(oModule, sChestId + "_CpvCount");
            int nItemIndex;
            for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
            {
              CpvSetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nItemIndex), 0);
            }

            CpvSetPersistentInt(oModule, sChestId + "_CpvCount", 0);

            // Zero the virtual gold too!
            CpvSetPersistentInt(oModule, sChestId + "_Gold", 0);

            DestroyObject(oChest);
            bFound = TRUE;
          }
        }
      }
    }
  }
}

/////////////////////////////////////////////////////////
void CpvWipePlayerVendor(string sPlayerKey)
{
  object oModule = GetModule();

  // find all vendors employed by the pc
  int nMerchantCount = GetLocalInt(oModule, "CnrMerchantCount");
  int nIndex;
  for (nIndex=1; nIndex<=nMerchantCount; nIndex++)
  {
    string sMerchantTag = GetLocalString(oModule, "CnrMerchantTag_" + IntToString(nIndex));
    if (sMerchantTag != "")
    {
      object oMerchant = GetObjectByTag(sMerchantTag);
      if (oMerchant != OBJECT_INVALID)
      {
        string sEmployer = CpvGetPersistentString(oModule, sMerchantTag + "_CpvEmployer");
        if (sEmployer == sPlayerKey)
        {
          CpvDropAllInventory(oMerchant);
        }
      }
    }
  }

  AssignCommand(oModule, DelayCommand(5.0, CpvWipePlayerChest(sPlayerKey)));
}


