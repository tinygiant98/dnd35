/*  gives gold in "gold" bag onUsed and destroys itself
    already put in right place for custom items */

#include "inc_givewtgold"

void main() {
    int bModDebug = GetLocalInt(GetModule(),"bModDebug");
    int iGold = GetGold(OBJECT_SELF);
    int x;
    object oPC = GetLastOpenedBy(); //GetLastUsedBy();
    object oTemp;

    /*  integration with DOA Player Loot Notification: Auto-Gold feature,
        will only fire once Auto-Gold has been run for the first time */
    oTemp = GetFirstFactionMember(oPC);
    while (GetIsObjectValid(oTemp)) {
        x++; if (x > 1) break;
        oTemp = GetNextFactionMember(oPC);
    }
    if (GetLocalInt(GetModule(),"doa_lootnotify_autogold") && (bModDebug || (x > 1))) {
        if (bModDebug) SendMessageToPC(GetFirstPC(), "[DOA_gold_used] Executing doa_lootnotify: auto-gold...");
        ExecuteScript("doa_lootnotify_o", OBJECT_SELF);
    } else {

    /* normal execution */
        GiveWtGoldToCreature(oPC, iGold);
        oTemp = GetFirstItemInInventory(OBJECT_SELF);
        while (GetIsObjectValid(oTemp)) {
            if (GetResRef(oTemp) == "nw_it_gold001") {
                DestroyObject(oTemp);
                break;
            }
            oTemp = GetNextItemInInventory(OBJECT_SELF);
        }
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));
    }
    DestroyObject(OBJECT_SELF);
}
