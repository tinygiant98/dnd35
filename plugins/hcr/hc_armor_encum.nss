// HCR 3.03.0b
// New script added by CFX 27 FEB 2005 for Racial and Armor Movement speed toggles

#include "hc_inc"
void main()
{
    //If in crafting mode, exit
    if(GetLocalInt(OBJECT_SELF, "X2_L_CRAFT_MODIFY_MODE") == TRUE)
        return;

    //If armor encumbrance rules are not in effect, exit
    if(GetLocalInt(oMod, "ARMORENCUMBER")!= 1) return;

    int nMode = GetLocalInt(OBJECT_SELF, "EQUIP_MODE");
    switch(nMode)
    {
        case 1: HC_EffectArmorEncumbrance(OBJECT_SELF); return;
        case 2: HC_RemoveArmorEncumbrance(OBJECT_SELF); return;
    }
}
