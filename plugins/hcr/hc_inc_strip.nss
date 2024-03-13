// hcr3 8/12/2003
// changed function name.
// persist code.
// added to not strip equipped items with INVSTRIP toggle from hc_defaults.
// if bag doesnt exist dont strip.
// strip equipped items after transfer to avoid lag.

#include "hc_inc_transfer"
// hcr3 7/26/2003
#include "hc_inc_persist"
#include "hc_inc_dbagcheck"

void strip_equipped(object oPlayer, object oDropBag, object oEquip)
{
 if(GetIsObjectValid(oEquip)&& (GetIsNoDrop(oEquip) == FALSE))
 { // AssignCommand(oDeathCorpse, ActionTakeItem(oEquip, oPlayer));
    CopyItem(oEquip, oDropBag);
    DestroyObject(oEquip);
 }
}

void Strip(object oPlayer, string sID)
{
   object oDropBag = GetLocalObject(oPlayer, "DROPBAG");
   // hcr3 7/18/2003 dont strip if bag is invalid.
   if (!GetIsObjectValid(oDropBag))
       return;
   hcTakeObjects(oPlayer, oDropBag);
   // hcr3 7/22/2003
   if (!GetLocalInt(GetModule(), "INVSTRIP"))
   {
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_ARMS, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_ARROWS, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_BELT, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_BOLTS, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_BOOTS, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_BULLETS, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_CHEST, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_CLOAK, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_HEAD, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_NECK, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPlayer));
    strip_equipped(oPlayer, oDropBag, GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPlayer));
   }
   // hcr3 7/26/2003
   // persistence code
   int nPersist = GetLocalInt(oMod, "PERSIST");
   DelayCommand(4.0, CheckDbag(oDropBag));
   if (nPersist)
        DelayCommand(12.0, HCStoreDB(sID));
}
