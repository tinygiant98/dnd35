#include "core_i_framework"
#include "util_i_debug"
#include "util_i_chat"
#include "util_i_constants"
#include "util_i_library"
#include "dlg_i_dialogs"

void cnr_OnPlayerChat()
{
    object oPC = GetPCChatSpeaker();
    if (HasChatKey(oPC, "device"))
    {
        string sDevice = GetChatKeyValue(oPC, "device");
        object oDevice = CreateObject(OBJECT_TYPE_PLACEABLE, sDevice, GetLocation(oPC), FALSE);
        HookObjectEvents(oDevice, TRUE, TRUE);

        Notice("Device event scripts:");
        int n = 9000;
        for (n; n <= 9015; n++)
        {
            string s = GetEventScript(oDevice, n);
            string sEvent = HexColorString(GetConstantName("EVENT_SCRIPT_PLACEABLE_ON_", JsonInt(n), TRUE), COLOR_BLUE_LIGHT);
            if (s == "") s = HexColorString("<none>", COLOR_RED_LIGHT);
            else s = HexColorString(s, COLOR_GREEN_LIGHT);

            Debug("  " + sEvent + ": " + s);
        }

        return;
    }
    else if (HasChatKey(oPC, "item"))
    {
        int nQty = 1;
        string sItem = GetChatKeyValue(oPC, "item");
        if (HasChatKey(oPC, "qty"))
            nQty = GetChatKeyValueInt(oPC, "qty");

        int n; for (n; n < nQty; n++)
             CreateItemOnObject(sItem, oPC);
        
        return;
    }
    else if (HasChatKey(oPC, "clear"))
    {   
        int n;
        string sDevice = GetChatKeyValue(oPC, "clear");
        object oDevice = GetNearestObjectByTag(sDevice, oPC, ++n);
        while (GetIsObjectValid(oDevice))
        {
            DestroyObject(oDevice);
            oDevice = GetNearestObjectByTag(sDevice, oPC, ++n);
        }
        
        return;
    }
    else if (HasChatOption(oPC, "convo"))
    {
        string sTag;
        if (HasChatKey(oPC, "to"))
            sTag = GetChatKeyValue(oPC, "to");
    
        if (sTag == "")
            return;

        object oTarget = GetNearestObjectByTag(sTag, oPC);
        SendChatResult("Target Tag is " + sTag, oPC, FLAG_INFO);

        SetLocalString(oTarget, "*Dialog", "cnrCraftingDialog");
        string sResref = "dlg_convnozoom";

        SendChatResult("OBJECT_SELF is " + GetTag(OBJECT_SELF), oPC, FLAG_INFO);

        AssignCommand(oTarget, ActionStartConversation(oPC, sResref, TRUE, FALSE));
    }
}

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

        RegisterEventScript(oPlugin, CHAT_PREFIX + "!cnr", "cnr_OnPlayerChat");
    
        RegisterLibraryScript("cnr_OnPlayerChat", 1);
    }
}

void OnLibraryScript(string sScript, int nEntry)
{
    if (nEntry == 1) cnr_OnPlayerChat();


}
