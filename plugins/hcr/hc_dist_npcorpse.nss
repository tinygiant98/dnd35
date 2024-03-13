//  ----------------------------------------------------------------------------
//  hc_dist_npccorpse
//  ----------------------------------------------------------------------------
/*
    OnDisturbed event script for an invisible NPC Corpse placeable to destroy
    the visible original when a copied item is removed from the corpse.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 26 July 2004 - Sunjammer
    - rewritten

    Credits:
    - Keron Blackfeld
*/
//  ----------------------------------------------------------------------------
#include "hc_inc_npccorpse"

void main()
{
    // pre-emptive abort for if not in copy mode
    if(HC_NPCCorpse_GetIsUsingCopyMode() == FALSE)
        return;

    if(GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        object oBody = GetLocalObject(OBJECT_SELF, HC_VAR_NPCCORPSE_BODY);
        object oItem = GetInventoryDisturbItem();

        // an item was removed: check for/parse the copied flag and destroy the
        // corresponding object
        switch(GetLocalInt(oItem, HC_VAR_NPCCORPSE_COPIED))
        {
            case INVENTORY_SLOT_CHEST:
                DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oBody));
                break;

            case INVENTORY_SLOT_HEAD:
                DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD, oBody));
                break;

            case INVENTORY_SLOT_LEFTHAND:
                DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oBody));
                break;

            case INVENTORY_SLOT_RIGHTHAND:
                DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oBody));
                break;
        }

        // remove the copied flag
        DeleteLocalInt(oItem, HC_VAR_NPCCORPSE_COPIED);
    }
}

