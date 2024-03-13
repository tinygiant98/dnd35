/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_chest_oc
//
//  Desc:  The OnClose handler for the cpvVendorChest
//         placeable. This chest is where a player
//         vendor drops an employer's loot when the
//         contract runs out.
//
//  Author: David Bobeck (aka Festyx)
//
/////////////////////////////////////////////////////////
#include "cpv_vendor_utils"

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
void CpvZeroChestsVirtualInventory(object oChest)
{
  object oModule = GetModule();
  string sChestId = GetLocalString(oChest, "CpvChestId");

  int nItemCount = CpvGetPersistentInt(oModule, sChestId + "_CpvCount");
  int nItemIndex;
  for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
  {
    CpvSetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nItemIndex), 0);
  }

  CpvSetPersistentInt(oModule, sChestId + "_CpvCount", 0);

  // Zero the virtual gold too!
  CpvSetPersistentInt(oModule, sChestId + "_Gold", 0);
}

///////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
void CpvCleanChestVirtualInventory(object oChest)
{
  object oModule = GetModule();
  string sChestId = GetLocalString(oChest, "CpvChestId");

  int nItemCountNew = 0;

  int nItemCountOld = CpvGetPersistentInt(oModule, sChestId + "_CpvCount");
  int nItemIndexOld;
  for (nItemIndexOld=1; nItemIndexOld<=nItemCountOld; nItemIndexOld++)
  {
    int nQty = CpvGetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nItemIndexOld));
    if (nQty > 0)
    {
      nItemCountNew++;
      if (nItemIndexOld > nItemCountNew)
      {
        string sCpvTag = CpvGetPersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nItemIndexOld));
        int nCpvQty = CpvGetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nItemIndexOld));

        CpvSetPersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nItemCountNew), sCpvTag);
        CpvSetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nItemCountNew), nCpvQty);
      }
    }

    // neutered to reduce lag
    //if (nItemIndexOld > nItemCountNew)
    //{
    //  CpvDeletePersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nItemIndexOld));
    //  CpvDeletePersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nItemIndexOld));
    //}
  }

  CpvSetPersistentInt(oModule, sChestId + "_CpvCount", nItemCountNew);
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
void CpvCloseTheChestHelper(object oChest, object oItem)
{
  object oModule = GetModule();
  int nStackSize = GetNumStackedItems(oItem);

  string sChestId = GetLocalString(oChest, "CpvChestId");

  if (GetTag(oItem) == "NW_IT_GOLD001")
  {
    int nQtyOfGold = CpvGetPersistentInt(oModule, sChestId + "_Gold");
    CpvSetPersistentInt(oModule, sChestId + "_Gold", nQtyOfGold+nStackSize);
    CmdDecrementStackCount(oChest, "CpvCloseTheChest");
    return;
  }

  int nItemCount = CpvGetPersistentInt(oModule, sChestId + "_CpvCount");
  int nMatchingIndex = nItemCount + 1;
  int nQtyOfItem = nStackSize;

  // Determine if we already have a matching tag to consolidate the inventory
  if (CPV_BOOL_CONSOLIDATE_VIRTUAL_INVENTORY)
  {
    int nIndex;
    for (nIndex=1; nIndex<=nItemCount; nIndex++)
    {
      string sTagOfItem = CpvGetPersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nIndex));
      if (sTagOfItem == GetTag(oItem))
      {
        // we have a match
        nMatchingIndex = nIndex;
        nQtyOfItem = CpvGetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nIndex)) + nStackSize;
      }
    }
  }

  if (nMatchingIndex == (nItemCount + 1))
  {
    CpvSetPersistentInt(oModule, sChestId + "_CpvCount", nMatchingIndex);
    CpvSetPersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nMatchingIndex), GetTag(oItem));
  }

  CpvSetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nMatchingIndex), nQtyOfItem);

  //DestroyObject(oItem);

  CmdDecrementStackCount(oChest, "CpvCloseTheChest");
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
void LoopUntilChestTransferCompletes(object oChest)
{
  int nStackCount =  CmdGetStackCount(oChest, "CpvCloseTheChest");
  if (nStackCount > 0)
  {
    DelayCommand(0.2, LoopUntilChestTransferCompletes(oChest));
  }
  else
  {
    // destroy the chest's physical inventory
    object oItem = GetFirstItemInInventory(oChest);
    while (oItem != OBJECT_INVALID)
    {
      DestroyObject(oItem);
      oItem = GetNextItemInInventory(oChest);
    }

    // purge the chest's virtual inventory that has Qty == 0
    CpvCleanChestVirtualInventory(oChest);

    // if the chest is empty, destroy it
    string sChestId = GetLocalString(oChest, "CpvChestId");
    int nItemCount = CpvGetPersistentInt(GetModule(), sChestId + "_CpvCount");
    if (nItemCount == 0)
    {
      CpvDestroyVendorChest(oChest);
    }

    CmdDecrementStackCount(oChest, "CpvCloseTheChest");
    SetLocked(OBJECT_SELF, FALSE);
  }
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
void CpvCloseTheChest(object oChest)
{
  string sChestId = GetLocalString(oChest, "CpvChestId");

  // zero the chest's virtual inventory
  CpvZeroChestsVirtualInventory(oChest);

  CmdSetStackCount(oChest, 0, "CpvCloseTheChest");

  // transfer all items in this chest's physical inventory to the chest's virtual inventory
  object oItem = GetFirstItemInInventory(oChest);
  while (oItem != OBJECT_INVALID)
  {
    CmdIncrementStackCount(oChest, "CpvCloseTheChest");
    AssignCommand(oChest, CpvCloseTheChestHelper(oChest, oItem));
    oItem = GetNextItemInInventory(oChest);
  }

  DelayCommand(0.2, LoopUntilChestTransferCompletes(oChest));
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
void main()
{
  object oUser = GetLastClosedBy();

  string sChestId = GetLocalString(OBJECT_SELF, "CpvChestId");
  string sEmployerKey = CpvGetPersistentString(GetModule(), sChestId + "_EmployerKey");
  string sPcKey = GetPCPublicCDKey(oUser);
  string sPcName = GetName(oUser);
  string sPlayerKey = sPcKey + "_" + sPcName;

  if ( (sPlayerKey == sEmployerKey) ||
       (CPV_BOOL_CHEST_INVENTORY_VISIBLE_TO_ALL == TRUE) ||
       (GetIsDM(oUser)) )
  {
    CpvCloseTheChest(OBJECT_SELF);
  }
}

