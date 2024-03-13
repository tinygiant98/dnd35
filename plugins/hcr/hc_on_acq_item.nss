// HCR v3.03b - Added reworked DoA Gold Encumberance - CFX

// HCR v3.2.0 - Removed old craft trap exploit code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Acq_Item
//::////////////////////////////////////////////////////////////////////////////
/*

*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_On_Acq"
#include "HC_Inc_Transfer"
#include "omw_plns"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    if (!preEvent())
        return;

    object oItem = GetModuleItemAcquired();
    object oPC   = GetItemPossessor(oItem);
    string sTag  = GetTag(oItem);

    if (sTag == "HCRHelpwand")
    {
        //
        if (GetPCPlayerName(oPC) != GetPersistentString(oMod, "PLAYERDM"))
        {
            DestroyObject(oItem);
            SendMessageToPC(oPC, "This may only be used by Player DM's!");
        }
    }
    else if (sTag == "NW_WSWMLS013"    || sTag == "NW_IT_CREWSW002" ||
             sTag == "NW_IT_CREWGS006" || sTag == "NW_IT_CREWLS006" ||
             sTag == "NW_IT_CREWSW001" || sTag == "NW_IT_CREWBS001" ||
             sTag == "NW_IT_CREWGS005" || sTag == "NW_IT_CREWLS005")
    {
        // Fix for disarming weapon exploit. (Summoned Hound Archon Sword,
        // Summoned Helmed Horror Sword, Summoned Celestial Avenger Sword,
        // Balor Sword, Balor Lord Sword, Helmed/Battle Horror Sword,
        // Celestial Avenger Sword and Tenser's Sword.)
        if (!GetIsDM(oPC) && !GetIsDMPossessed(oPC))
        {
            DestroyObject(oItem);
            SendMessageToPC(oPC, "The " + GetName(oItem) + " mysteriously vanishes from your pack!");
        }
    }
    else if (sTag == "hc_lantern")
    {
        int nBurnTime  = GetLocalInt(oMod, "BURNTORCH");
        int nBurnCount = GetLocalInt(oItem, "BURNCOUNT");
        if (nBurnTime > 0 && nBurnCount == 0)
        {
            nBurnCount = (nBurnTime*(FloatToInt(HoursToSeconds(1)/6.0)));
            SetLocalInt(oItem, "BURNCOUNT", nBurnCount);
        }
    }
    else if (sTag == "bagofgold")
    {
        int nAmtGold = GetLocalInt(oItem, "AmtGold");
        GiveGoldToCreature(oPC, nAmtGold);
        DestroyObject(oItem);
    }

    // Check for Scroll's Aquired.
    if (GetBaseItemType(oItem) == BASE_ITEM_SPELLSCROLL)
    {
        if ((GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0) ||
            (GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 3) ||
            (GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0)  ||
            (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 3) ||
            (GetLevelByClass(CLASS_TYPE_SORCERER, oPC) > 0) ||
            (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) > 0) ||
            (GetLevelByClass(CLASS_TYPE_BARD, oPC) > 0))
            SetIdentified(oItem, TRUE);
    }

    // Check for No-Drop Items Aquired.
    if (GetIsNoDrop(oItem))
    {
        if (!GetItemCursedFlag(oItem))
            SetItemCursedFlag(oItem, TRUE);
    }

    // Added for reworked DoA Gold Encumberance for HCR v3.03b - CFX
    {
    object oPC = GetModuleItemAcquiredBy();
    if (!GetIsPC(oPC)) return;
    int iItemStack = GetModuleItemAcquiredStackSize();

    /*  DOA Gold Encumbrance System 1.0
    Den, Project Lead at Carpe Terra (http://carpeterra.com)
    + gold acquired does not generate tag or resref; we can guess it is
      gold if stacksize > 99 */
    if (iItemStack > 99) ExecuteScript("doa_goldencum", oPC);
    }

    //added for old man whistlers loot notification - cfx
    if (GetLocalInt(oMod,"LOOTNOTIFY"))
    RunLootNotificationOnAcquire();


    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
