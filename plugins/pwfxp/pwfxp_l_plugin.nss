#include "core_i_framework"
#include "util_i_debug"
#include "util_i_library"

void OnLibraryLoad()
{
    if (!GetIfPluginExists("pwfxp"))
    {
        object oPlugin = CreatePlugin("pwfxp");
        SetName(oPlugin, "[Plugin] System :: PWFXP system");
        SetDebugPrefix(HexColorString("[PWFXP]", COLOR_PINK), oPlugin);
        RegisterEventScript(oPlugin,CREATURE_EVENT_ON_DEATH, "pwfxp");
    }
}

void OnLibraryScript(string sScript, int nEntry)
{

}
