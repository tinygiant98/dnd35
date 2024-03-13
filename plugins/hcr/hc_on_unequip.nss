// HCR 3.4.0
/* New Script for Racial and Armor movement toggles
   - added by CFX - 27 FEB 2005
*/

#include "x2_inc_switches"
#include "x3_inc_horse"

const int UNEQUIPPED = 2;

void SetMode(object oPC, int nMode)
{
    SetLocalInt(oPC, "EQUIP_MODE", nMode);
}
void main()
{
     object oItem = GetPCItemLastUnequipped();
     object oPC   = GetPCItemLastUnequippedBy();

    SetMode(oPC, UNEQUIPPED);
    ExecuteScript("hc_armor_encum", oPC);

    // -------------------------------------------------------------------------
    // Mounted benefits control
    // -------------------------------------------------------------------------
    if (GetWeaponRanged(oItem))
    {
        DeleteLocalInt(oPC,"bX3_M_ARCHERY");
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }
}
