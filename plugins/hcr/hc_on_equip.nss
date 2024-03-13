// HCR 3.4.0
/* New Script to work with the Racial and Armor Movement Speed toggles
   - added by CFX 27 Feb 2005
*/

#include "x2_inc_switches"
#include "x3_inc_horse"

const int EQUIPPED = 1;

void SetMode(object oPC, int nMode)
{
    SetLocalInt(oPC, "EQUIP_MODE", nMode);
}
void main()
{
    object oPC = GetPCItemLastEquippedBy();
    object oItem = GetPCItemLastEquipped();

    if(GetIsDM(oPC) == TRUE) return;

    SetMode(oPC, EQUIPPED);
    ExecuteScript("hc_armor_encum", oPC);

    // -------------------------------------------------------------------------
    // Mounted benefits control
    // -------------------------------------------------------------------------
    if (GetWeaponRanged(oItem))
    {
        SetLocalInt(oPC,"bX3_M_ARCHERY",TRUE);
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }
}
