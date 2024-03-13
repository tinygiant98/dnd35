// sr5.2
#include "hc_inc_transfer"

void main()
{
    object oDC=OBJECT_SELF;
    object oUser = GetLastUsedBy();
    object oItem =  GetFirstItemInInventory(oDC);
    string sOwner = GetLocalString(oDC,"Name");
    if(sOwner == GetName(oUser))
    {
        while(GetIsObjectValid(oItem))
        {
            ActionGiveItem(oItem, oUser);
            oItem = GetNextItemInInventory(oDC);
        }
     }

}
