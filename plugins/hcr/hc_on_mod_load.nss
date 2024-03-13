// HCR v3.03b - added reworked DoA Gold Encumberance - CFX

// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Mod_Load
//::////////////////////////////////////////////////////////////////////////////
/*

*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_On_Load"
#include "HC_Inc_HTF"
#include "X2_Inc_Switches"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    //Add CNR event
    ExecuteScript("cnr_module_oml", OBJECT_SELF);
    ExecuteScript("otr_module_oml", OBJECT_SELF);
    if (!preEvent())
        return;

    // Bioware Module Switches.
    if (GetGameDifficulty() >= GAME_DIFFICULTY_CORE_RULES)
    {
        // * Setting the switch below will enable a seperate Use Magic Device
        // * Skillcheck for rogues. This only applies to scrolls.
        //SetModuleSwitch(MODULE_SWITCH_ENABLE_UMD_SCROLLS, TRUE);

        // * Activating the switch below will make AOE spells hurt neutral NPCS by
        // * default.
        SetModuleSwitch(MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, TRUE);
    }

    // * AI: Activating the switch below will make the creaures using the WalkWaypoint function
    // * able to walk across areas
    SetModuleSwitch(MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, TRUE);

    // * Spells: Activating the switch below will make the Glyph of Warding spell behave differently:
    // * The visual glyph will disappear after 6 seconds, making them impossible to spot
    //SetModuleSwitch(MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);

    // * Craft Feats: Want 50 charges on a newly created wand? We found this unbalancing,
    // * but since it is described this way in the book, here is the switch to get it back...
    //SetModuleSwitch(MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, TRUE);

    // * Craft Feats: Use this to disable Item Creation Feats if you do not want
    // * them in your module
    //SetModuleSwitch(MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, TRUE);

    // * Palemaster: Deathless master touch in PnP only affects creatures up to a certain size.
    // * We do not support this check for balancing reasons, but you can still activate it...
    //SetModuleSwitch(MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, TRUE);

    // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
    // * did not fit into NWNs spell system and was confusing, so we took it out...
    //SetModuleSwitch(MODULE_SWITCH_EPIC_SPELLS_HURT_CASTER, TRUE);

    // *
    //SetModuleSwitch(MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT, TRUE);

    // * Spellcasting: Some people don't like caster's abusing expertise to raise their AC
    // * Uncommenting this line will drop expertise mode whenever a spell is cast by a player
    //SetModuleSwitch(MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);

    // * SpellScript: This is the name of the spell router script.
    SetModuleOverrideSpellscript("hc_spell_router");

    // Execute the default script and set the HTF area variables.
    ExecuteScript("hc_defaults", oMod);
    ExecuteScript("hc_setareavars", oMod);

    // Store the starting year, month, day and hour.
    if (!GetPersistentInt(oMod, "HourStart"))
        SetPersistentInt(oMod, "HourStart", GetTimeHour());
    if (!GetPersistentInt(oMod, "DayStart"))
        SetPersistentInt(oMod, "DayStart", GetCalendarDay());
    if (!GetPersistentInt(oMod, "MonthStart"))
        SetPersistentInt(oMod, "MonthStart", GetCalendarMonth());
    if (!GetPersistentInt(oMod, "YearStart"))
        SetPersistentInt(oMod, "YearStart", GetCalendarYear());

    // Restore the calendar if one was saved.
    int iCurYear = GetPersistentInt(oMod, "CurrentYear");
    if (iCurYear > 0)
    {
        int iCurMonth = GetPersistentInt(oMod, "CurrentMonth");
        int iCurDay   = GetPersistentInt(oMod, "CurrentDay");
        int iCurHour  = GetPersistentInt(oMod, "CurrentHour");
        int iCurMin   = GetPersistentInt(oMod, "CurrentMin");
        SetCalendar(iCurYear, iCurMonth, iCurDay);
        SetTime(iCurHour, iCurMin, 0, 0);
    }

    //added for reworked DoA Gold Encumberance - CFX
    {
    object oItem = GetModuleItemLost();
    if (!GetIsObjectValid(oItem)) return;
    object oPC = GetModuleItemLostBy();
    if (!GetIsPC(oPC)) return;
    string sItemResRef = GetResRef(oItem);

    /*  DOA Gold Encumbrance System 1.0
    + will only fire if there is not already gold in container */
    if (sItemResRef == "nw_it_gold001") ExecuteScript("doa_goldencum", oPC);
    }


    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
