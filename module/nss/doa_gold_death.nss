/*  destroys the inventory of "gold" bag onDeath
    already put in right place for custom items */

void main() {
    int iGold = GetGold(OBJECT_SELF);
    object oTemp = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oTemp)) {
        if (GetResRef(oTemp) == "nw_it_gold001") {
            DestroyObject(oTemp);
            break;
        }
        oTemp = GetNextItemInInventory(OBJECT_SELF);
    }
}
