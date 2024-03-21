#include "core_i_framework"
#include "util_i_debug"
#include "util_i_library"

#include "util_i_csvlists"
#include "util_i_chat"
#include "util_i_libraries"
#include "quest_i_main"

void quest_OnModuleLoad()
{
    CreateModuleQuestTables(TRUE);
    LoadLibrariesByPattern("*_q_*");
}

void quest_OnClientEnter()
{
    object oPC = GetEnteringObject();
    CreatePCQuestTables(oPC);
    UpdatePCQuestTables(oPC);
    CleanPCQuestTables(oPC);
    UpdateJournalQuestEntries(oPC);
}

void quest_OnAcquireItem()
{
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();

    if (GetIsPC(oPC))
        SignalQuestStepProgress(oPC, GetTag(oItem), QUEST_OBJECTIVE_GATHER);   
}

void quest_OnUnacquireItem()
{
    object oItem = GetModuleItemLost();
    object oPC = GetModuleItemLostBy();

    if (GetIsPC(oPC))
        SignalQuestStepRegress(oPC, GetTag(oItem), QUEST_OBJECTIVE_GATHER); 
}

void quest_OnCreatureDeath()
{
    object oVictim = OBJECT_SELF;
    object oPC = GetLastKiller();

    if (!GetIsPC(oPC))
        oPC = GetLocalObject(oVictim, "QUEST_PROTECTOR");

    if (GetIsObjectValid(oPC) && GetIsPC(oPC))
        SignalQuestStepProgress(oPC, GetTag(oVictim), QUEST_OBJECTIVE_KILL);
}

void quest_OnCreatureConversation()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetLastSpeaker();

    if (GetIsPC(oPC))
        SignalQuestStepProgress(oPC, GetTag(oNPC), QUEST_OBJECTIVE_SPEAK);
}

void quest_OnTriggerEnter()
{
    object oTrigger = OBJECT_SELF;
    object oPC = GetEnteringObject();

    SignalQuestStepProgress(oPC, GetTag(oTrigger), QUEST_OBJECTIVE_DISCOVER);
}

void quest_OnPCPerception()
{
    object oPC = OBJECT_SELF;
    object oPerceived = GetLastPerceived();

    if (GetIsPC(oPC) && !GetIsPC(oPerceived) && (GetLastPerceptionSeen() || GetLastPerceptionHeard()))
        SignalQuestStepProgress(oPC, GetTag(oPerceived), QUEST_OBJECTIVE_DISCOVER);
}

void OnLibraryLoad()
{
    if (!GetIfPluginExists("quest"))
    {
        object oPlugin = CreatePlugin("quest");
        SetName(oPlugin, "[Plugin] System :: Quest Management System");
        SetDebugPrefix(HexColorString("[QUEST]", COLOR_BLUE_LIGHT), oPlugin);

        RegisterEventScript(oPlugin, MODULE_EVENT_ON_MODULE_LOAD, "quest_OnModuleLoad");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_CLIENT_ENTER, "quest_OnClientEnter");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_ACQUIRE_ITEM, "quest_OnAcquireItem");
        RegisterEventScript(oPlugin, MODULE_EVENT_ON_UNACQUIRE_ITEM, "quest_OnUnacquireItem");

        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_DEATH, "quest_OnCreatureDeath");
        RegisterEventScript(oPlugin, CREATURE_EVENT_ON_CONVERSATION, "quest_OnCreatureConversation");
        RegisterEventScript(oPlugin, PC_EVENT_ON_PERCEPTION, "quest_OnPCPerception");

        RegisterEventScript(oPlugin, TRIGGER_EVENT_ON_ENTER, "quest_OnTriggerEnter");

        RegisterEventScript(oPlugin, CHAT_PREFIX + "!quest", "quest_i_chat");
    }

    int n = 0;
    RegisterLibraryScript("quest_OnModuleLoad", n++);
    RegisterLibraryScript("quest_OnClientEnter", n++);
    RegisterLibraryScript("quest_OnAcquireItem", n++);
    RegisterLibraryScript("quest_OnUnacquireItem", n++);
    
    int n = 100;
    RegisterLibraryScript("quest_OnCreatureDeath", n++);
    RegisterLibraryScript("quest_OnCreatureConversation", n++);
    RegisterLibraryScript("quest_OnPCPerception", n++);

    int n = 200;
    RegisterLibraryScript("quest_OnTriggerEnter", n++);
}

void OnLibraryScript(string sScript, int nEntry)
{
    int n = nEntry / 100 * 100;
    switch (n)
    {
        case 0:
        {
            if      (nEntry == n++) quest_OnModuleLoad();
            else if (nEntry == n++) quest_OnClientEnter();
            else if (nEntry == n++) quest_OnAcquireItem();
            else if (nEntry == n++) quest_OnUnacquireItem();
        } break;
        case 100:
        {
            if      (nEntry == n++) quest_OnCreatureDeath();
            else if (nEntry == n++) quest_OnCreatureConversation();
            else if (nEntry == n++) quest_OnPCPerception();
        } break;
        case 200:
        {
            if      (nEntry == n++) quest_OnTriggerEnter();
        } break;

        default: CriticalError("Library function " + sScript + " not found");
    }
}
