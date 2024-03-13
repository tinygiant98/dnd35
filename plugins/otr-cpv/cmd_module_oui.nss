#include "cnr_merch_utils"

void main()
{
  object oLoser = GetModuleItemLostBy();
  if (!GetIsPC(oLoser)) return;
  object oLootBag = GetLocalObject(oLoser, "CmdLootBag");
  if (!GetIsObjectValid(oLootBag)) return;

  object oItemLost = GetModuleItemLost();
  string sSellTag = GetLocalString(oLootBag, "CmdSellTag");
  if (GetTag(oItemLost) != sSellTag) return;

  int bChargeCustomer = TRUE;

    // search all items in this container's inventory for the
    // item being sold
  object oItem = GetFirstItemInInventory(oLootBag);
  while (oItem != OBJECT_INVALID)
  {
    if (GetTag(oItem) == sSellTag)
    {
      bChargeCustomer = FALSE;
    }
    oItem = GetNextItemInInventory(oLootBag);
  }

  // if the item is missing, charge the customer for it!!!
  if (bChargeCustomer)
  {
    SetLocalObject(oLootBag, "CmdMissingItem", oItemLost);
    CmdChargeCustomerForItem(oLootBag, TRUE);
  }

  // Destroy the container too
  DestroyObject(oLootBag);
}
