#include "core_i_framework"
#include "util_i_debug"
#include "util_i_library"

void OnLibraryLoad()
{
    if (!GetIfPluginExists("hcr"))
    {
        object oPlugin = CreatePlugin("hcr");
        SetName(oPlugin, "[Plugin] System :: Hard Core Rules");
        SetDebugPrefix(HexColorString("[HCR]", COLOR_PINK), oPlugin);

        RegisterEventScript(oPlugin, MODULE_EVENT_ON_ACQUIRE_ITEM, "hc_on_acq_item");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_ACTIVATE_ITEM, "hc_on_act_item");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_CLIENT_ENTER, "hc_on_cl_enter");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_CLIENT_LEAVE, "hc_on_cl_leave");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_EQUIP_ITEM, "hc_on_equip");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_HEARTBEAT, "hc_on_heartbeat");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_MODULE_LOAD, "hc_on_mod_load");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_DEATH, "hc_on_play_death");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_REST, "hc_on_play_rest");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_DYING, "hc_on_play_dying");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_LEVEL_UP, "hc_on_ply_lvl_up");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_RESPAWN, "hc_on_ply_respawn");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_UNACQUIRE_ITEM, "hc_on_unacq_item");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_PLAYER_UNEQUIP_ITEM, "hc_on_unequip");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_USER_DEFINED, "hc_on_usr_define");
    }
}

void OnLibraryScript(string sScript, int nEntry)
{
       
}