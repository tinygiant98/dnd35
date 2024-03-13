/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_chest_oo
//
//  Desc:  The OnOpen handler for the cpvVendorChest
//         placeable. This chest is where a player
//         vendor drops an employer's loot when the
//         contract runs out.
//
//  Author: David Bobeck (aka Festyx)
//
/////////////////////////////////////////////////////////
#include "cpv_vendor_utils"

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
void CpvOpenTheChest(object oChest)
{
  object oModule = GetModule();
  string sChestId = GetLocalString(oChest, "CpvChestId");

  int nItemCount = CpvGetPersistentInt(oModule, sChestId + "_CpvCount");
  int nIndex;
  for (nIndex=1; nIndex<=nItemCount; nIndex++)
  {
    string sItemTag = CpvGetPersistentString(oModule, sChestId + "_CpvTag_" + IntToString(nIndex));
    int nQtyOfItem = CpvGetPersistentInt(oModule, sChestId + "_CpvQty_" + IntToString(nIndex));
    CnrMerchantCreateItemOnObject(sItemTag, oChest, nQtyOfItem);
  }

  // And add the gold too
  int nQtyOfGold = CpvGetPersistentInt(oModule, sChestId + "_Gold");
  CnrMerchantCreateItemOnObject("NW_IT_GOLD001", oChest,nQtyOfGold);
}

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
void main()
{
  object oUser = GetLastOpenedBy();

  string sChestId = GetLocalString(OBJECT_SELF, "CpvChestId");
  string sEmployerKey = CpvGetPersistentString(GetModule(), sChestId + "_EmployerKey");
  string sPcKey = GetPCPublicCDKey(oUser);
  string sPcName = GetName(oUser);
  string sPlayerKey = sPcKey + "_" + sPcName;

  if ( (sPlayerKey == sEmployerKey) ||
       (CPV_BOOL_CHEST_INVENTORY_VISIBLE_TO_ALL == TRUE) ||
       (GetIsDM(oUser)) )
  {
    // fill the chest with real loot
    CpvOpenTheChest(OBJECT_SELF);
    SetLocked(OBJECT_SELF, TRUE);
    FloatingTextStringOnCreature("Walk away to close", oUser);
  }
}

