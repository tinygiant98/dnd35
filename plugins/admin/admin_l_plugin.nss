// -----------------------------------------------------------------------------
//    File: admin_l_plugin.nss
//  System: Persistent World Administration (library)
// -----------------------------------------------------------------------------
// Description:
//  Library functions for PW Administration
// -----------------------------------------------------------------------------
// Builder Use:
//  None!  Leave me alone.
// -----------------------------------------------------------------------------

#include "util_i_library"
#include "core_i_framework"

// -----------------------------------------------------------------------------
//                               Library Dispatch
// -----------------------------------------------------------------------------

void OnLibraryLoad()
{
    if (!GetIfPluginExists("admin"))
    {
        object oPlugin = CreatePlugin("admin");
        SetName(oPlugin, "[Plugin] PW Administration");
        SetDescription(oPlugin,
            "This plugin controls all administrative functions for the pw.");
        SetDebugPrefix(HexColorString("[Admin]", COLOR_BLUE_SLATE_MEDIUM), oPlugin);

        // These are default bioware events in case other systems don't override them.
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_ACQUIRE_ITEM,         "x2_mod_def_aqu",   2.0);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_ACTIVATE_ITEM,        "x2_mod_def_act",   2.0);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_CLIENT_ENTER,         "x3_mod_def_enter", 2.0);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_MODULE_LOAD,          "x2_mod_def_load",  2.0);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_DEATH,         "nw_o0_death",      EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_DYING,         "nw_o0_dying",      EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_EQUIP_ITEM,    "x2_mod_def_equ",   2.0);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_RESPAWN,       "nw_o0_respawn",    2.0);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_REST,          "x2_mod_def_rest",  EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_UNEQUIP_ITEM,  "x2_mod_def_unequ", 2.0);
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_UNACQUIRE_ITEM,       "x2_mod_def_unaqu", 2.0);

        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_BLOCKED,            "nw_c2_defaulte",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_COMBAT_ROUND_END,   "nw_c2_default3",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_CONVERSATION,       "nw_c2_default4",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_DAMAGED,            "nw_c2_default6",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_DEATH,              "nw_c2_default7",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_DISTURBED,          "nw_c2_default8",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_HEARTBEAT,          "nw_c2_default1",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_PERCEPTION,         "nw_c2_default2",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_PHYSICAL_ATTACKED,  "nw_c2_default5",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_RESTED,             "nw_c2_defaulta",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_SPAWN,              "nw_c2_default9",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_SPELL_CAST_AT,      "nw_c2_defaultb",   EVENT_PRIORITY_DEFAULT);
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_USER_DEFINED,       "nw_c2_defaultd",   EVENT_PRIORITY_DEFAULT);
    }
}

void OnLibraryScript(string sScript, int nEntry)
{

}
