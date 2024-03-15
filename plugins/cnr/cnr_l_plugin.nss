#include "core_i_framework"
#include "util_i_debug"
#include "util_i_library"

void OnLibraryLoad()
{
    if (!GetIfPluginExists("cnr"))
    {
        object oPlugin = CreatePlugin("cnr");
        SetName(oPlugin, "[Plugin] System :: Craftable Natural Resources");
        SetDebugPrefix(HexColorString("[CNR]", COLOR_PINK), oPlugin);

        RegisterEventScript(oPlugin, MODULE_EVENT_ON_ACTIVATE_ITEM, "cnr_module_onact");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_CLIENT_ENTER, "cnr_module_oce");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_MODULE_LOAD, "cnr_module_oml");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_UNACQUIRE_ITEM, "cnr_module_oui");
    }
}

void OnLibraryScript(string sScript, int nEntry)
{

}
