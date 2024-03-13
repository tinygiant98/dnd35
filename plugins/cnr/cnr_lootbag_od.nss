/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_lootbag_od
//
//  Desc:  This is the OnDistubed event handler for
//         the CMD merchant's loot bag.
//
//  Author: David Bobeck 26Apr03
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void main()
{
  object oPC = GetLastDisturbed();
  if (!GetIsPC(oPC)) return;

  object oItem = GetInventoryDisturbItem();
  if (!GetIsObjectValid(oItem)) return;

  object oMerchant = GetLocalObject(OBJECT_SELF, "CmdMerchant");
  location locLootBag = GetLocation(OBJECT_SELF);
  string sItemTag = GetTag(oItem);

  int nType = GetInventoryDisturbType();
  if (nType == INVENTORY_DISTURB_TYPE_ADDED)
  {
    if (GetIsObjectValid(oMerchant))
    {
      AssignCommand(oMerchant, ActionSpeakString(CMD_TEXT_YOU_MIGHT_LOSE_IT));
    }
    return;
  }
  else if (nType == INVENTORY_DISTURB_TYPE_REMOVED)
  {
    // Stackable items don't generate OnDisturbed events if they are dragged
    // and dropped on similar stackable items - a Bioware bug.
    string sSellTag = GetLocalString(OBJECT_SELF, "CmdSellTag");
    if (sItemTag != sSellTag)
    {
      return;
    }

    CmdChargeCustomerForItem(OBJECT_SELF, FALSE);
  }
}
