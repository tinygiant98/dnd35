// hcr3
// changed copyobject to copyitem to hopefully speed up item transfer.
// sr5.4
// new script to transfer boxes and thier inventories from players inventory.

#include "i_tagtests"

int MoveSelectedItem(object oMod, object oPC, object oTo, object oItem)
{
    if ((oItem != OBJECT_INVALID) && (GetLocalInt(oItem, "destroy")==0))
    {
        if (GetIsObjectValid(CopyItem(oItem, oTo)))
        {
            SetLocalInt(oItem, "destroy", 1);
            AssignCommand(oMod, DestroyObject(oItem));
            return 1;
        }
    }
    return 0;
}

int MoveBag(object oMod, object oPC, object oTo)
{
    object oItem = GetFirstItemInInventory(oPC);
    while ((oItem != OBJECT_INVALID) && (oTo != OBJECT_INVALID))
    {
        if ((GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX) && (GetIsNoDrop(oItem) == FALSE))
            if (MoveSelectedItem(oMod, oPC, oTo, oItem) > 0)
                return 1;
        oItem = GetNextItemInInventory(oPC);
    }
    return 0;
}

void main()
{
    object oPC = OBJECT_SELF;
    object oMod = GetModule();
    object oTo = GetLocalObject(oMod, "oTo" + GetPCPlayerName(oPC) + GetName(oPC));

    if (MoveBag(oMod, oPC, oTo) == 0)
       return;

    return;
}


