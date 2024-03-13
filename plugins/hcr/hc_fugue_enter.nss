// HCR 3.03 - 18th May, 2005
// -----------------------------------------------------------------------------
// FileName:  hc_fugue_enter
// -----------------------------------------------------------------------------
/*
    OnEnter area event script for Fugue to strip any remaining equipment
*/
// -----------------------------------------------------------------------------
/*
    Unofficial fix for HCR 3.03 - 04 May 2005 - Sunjammer
    - moved and corrected Strip functionality from hc_inc_strip
*/
// -----------------------------------------------------------------------------
#include "hc_inc"
#include "hc_inc_dbagcheck"
#include "hc_inc_htf"
#include "hc_inc_transfer"
#include "hc_inc_persist"


void FugueStrip(object oPC, string sID)
{
    object oDropBag = GetLocalObject(oPC, "DROPBAG");

    if(GetIsObjectValid(oDropBag))
    {
        // transfer inventory
        // 18th May, 2005 - TODO: check if this is can be avoided as No Drop code is expensive
        // and if it has already been done the only items remaining will be
        // No Drop Items
        HC_Transfer_MoveInventory(oPC, oDropBag);

        // transfer equipment if not done already
        if(GetLocalInt(oMod, "INVSTRIP") == FALSE)
        {
            HC_Transfer_MoveEquipment(oPC, oDropBag);
        }

        // persistence code (unchecked)
        DelayCommand(4.0, CheckDbag(oDropBag));
        if(GetLocalInt(oMod, "PERSIST"))
        {
            DelayCommand(12.0, HCStoreDB(sID));
        }
    }
}

// -----------------------------------------------------------------------------
//  MAIN
// -----------------------------------------------------------------------------

void main()
{
    object oPC = GetEnteringObject();
    string sID = GetPlayerID(oPC);

    // pre-emptive abort: the object is a DM or not a PC
    if(!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
       return;

    // set immortal to prevent PC being killed by indirect damange (e.g. traps)
    SetImmortal(oPC, TRUE);

    // reset (save) the last hitpoints.
    SetPersistentInt(oMod, "LastHP" + sID, GetCurrentHitPoints(oPC));

    // using the Loot System: strip the items from the player
    if(GetLocalInt(oMod, "LOOTSYSTEM"))
        FugueStrip(oPC, sID);

    // reset HTF settings
    if(GetLocalInt(oMod, "FATIGUESYSTEM")
    || GetLocalInt(oMod, "HUNGERSYSTEM"))
        ResetHTFLevels(oPC);

    // clear the moving variable so the player may be raised
    DelayCommand(2.0, DeleteLocalInt(oPC, "MOVING"));
}
