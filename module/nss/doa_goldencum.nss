/*  DOA Gold Encumbrance System 1.0
    Den, Project Lead at Carpe Terra (http://carpeterra.com)
    Modified for use with HCR 3.03b by CFX */

//HCR Addition
#include "hc_inc"

void main() {
    int bModDebug = GetLocalInt(GetModule(),"bModDebug");
    object oPC = OBJECT_SELF;
    object oItem, oTemp;
    int iNewGold = GetGold(oPC);

    //HCR Addition for v3.03b
    //Check for System turned on or not - CFX
    int nDoGoldSys = GetLocalInt(oMod,"GOLDENCUMBER");
    if(nDoGoldSys == 0) iNewGold = 0;

    int iMinEncumBags = iNewGold/500;
    int iCountEncumBags;

    oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        if (GetResRef(oItem) == "gold_pouch") iCountEncumBags++;
        oItem = GetNextItemInInventory(oPC);
    }
    iMinEncumBags = iMinEncumBags - iCountEncumBags;
    if (iMinEncumBags > 0) { // weigh em down
        location locItem = GetLocation(oPC);
        for (iCountEncumBags = 0; iCountEncumBags < iMinEncumBags; iCountEncumBags++) {
            oTemp = CreateItemOnObject("gold_pouch", oPC);
            if (GetItemPossessor(oTemp) == OBJECT_INVALID) {
                // not enough room... drop gold
                DestroyObject(oTemp);
                AssignCommand(oPC, TakeGoldFromCreature(500, oPC, TRUE));
                oTemp = CreateObject(OBJECT_TYPE_PLACEABLE,"gold_lg",locItem);
                CreateItemOnObject("nw_it_gold001", oTemp, 500);
            }
        }
    } else if (iMinEncumBags < 0) { // let em breath
        iCountEncumBags = 0;
        oItem = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oItem)) {
            if (GetResRef(oItem) == "gold_pouch") {
                DestroyObject(oItem);
                iCountEncumBags--;
            }
            if (iCountEncumBags == iMinEncumBags) break;
            oItem = GetNextItemInInventory(oPC);
        }
    }
    SetLocalInt(oPC, "doa_gold", iNewGold);
}
