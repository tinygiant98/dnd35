#include "core_i_framework"
#include "util_i_debug"
#include "util_i_library"

void OnLibraryLoad()
{
    if (!GetIfPluginExists("ness"))
    {
        object oPlugin = CreatePlugin("ness");
        SetName(oPlugin, "[Plugin] System :: NESS Spawning System");
        SetDebugPrefix(HexColorString("[NESS]", COLOR_RED), oPlugin);
        RegisterEventScript(oPlugin, AREA_EVENT_ON_ENTER, "spawn_smpl_onent");
        
    }
}

void OnLibraryScript(string sScript, int nEntry)
{
       
}