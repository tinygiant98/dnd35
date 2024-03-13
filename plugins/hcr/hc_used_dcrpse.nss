// sr6.1
// streamlined code to only look for player corpses.
// sr5
#include "hc_inc_transfer"

void main()
{
    object oDC=OBJECT_SELF;
    object oUser = GetLastUsedBy();
    object oItem =  GetFirstItemInInventory(oDC);
    while(GetIsObjectValid(oItem))
        {
            if(GetTag(oItem) != "PlayerCorpse")
               ActionGiveItem(oItem, oUser);
            oItem = GetNextItemInInventory(oDC);
        }


}
