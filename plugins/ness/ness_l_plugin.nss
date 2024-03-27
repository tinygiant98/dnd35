#include "core_i_framework"
#include "util_i_debug"
#include "util_i_library"
#include "spawn_waypoints"


void ness_OnModuleLoad()
{
   PopulateWorld();
}


void OnLibraryLoad()
{
    if (!GetIfPluginExists("ness"))
    {
        object oPlugin = CreatePlugin("ness");
        SetName(oPlugin, "[Plugin] System :: NESS Spawning System");
        SetDebugPrefix(HexColorString("[NESS]", COLOR_RED), oPlugin);
        SetDebugLevel(DEBUG_LEVEL_ERROR, oPlugin);

        RegisterEventScript(oPlugin, AREA_EVENT_ON_ENTER, "spawn_smpl_onent");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_MODULE_LOAD, "ness_OnModuleLoad");
  
    }
    int n = 0;
    RegisterLibraryScript("ness_OnModuleLoad", n++);
}

void OnLibraryScript(string sScript, int nEntry)
{
    int n = nEntry / 100 * 100;
    switch (n)
    {
        case 0:
        {
            if (nEntry == n++) ness_OnModuleLoad(); break;
        }

        default: CriticalError("Library function " + sScript + " not found");
    }
       
}
