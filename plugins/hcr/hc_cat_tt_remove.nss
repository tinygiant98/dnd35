// sr5.2
#include "hc_text_traps"
#include "hc_inc_traps"

void triggerTrap(object oTrap, object oVictim);

void main()
{
    object oPC = GetPCSpeaker();
    SendMessageToPC(oPC, REMOVING);

    if (oPC != OBJECT_INVALID)
    {
        int nRogueLevel = GetLevelByClass(CLASS_TYPE_ROGUE, oPC);
        int nSkillMod = GetLocalInt(oPC, "nSkillMod");
        object oTrappedItem = GetLocalObject(oPC, "oToolTarget");
        int iTrapDC = GetTrapDisarmDC(oTrappedItem);
        if(iTrapDC>=101)iTrapDC=iTrapDC-100;
        iTrapDC=iTrapDC+5;
        int bCanDisarmTrap = FALSE; // Assume that the person cannot spot a trap.
        // Determine spotting capability
        if ((iTrapDC <= 20) || ((iTrapDC > 20) && (nRogueLevel >= 1)))
            bCanDisarmTrap = TRUE;
        // Only check to see if detected if not previously detected
        // and the PC has the ability to do detect it.
        if (bCanDisarmTrap)
        {
            int nDisarm = GetSkillRank(SKILL_DISABLE_TRAP, oPC);
            int nDCCheck = d20() + nDisarm + nSkillMod;
            if (nDCCheck >= iTrapDC && nDisarm >= 1) // Trap disarmed
            {
                SetTrapDisabled(oTrappedItem);
                SendMessageToPC(oPC, REMOVED);
                CreateItemOnObject(DetermineTrap(oTrappedItem),oPC);
            }
            else if ((nDCCheck - iTrapDC) < -4)
            {
                SendMessageToPC(oPC, TRAPTRIGGERED);
                triggerTrap(oTrappedItem, oPC);
            }
            else
                SendMessageToPC(oPC, FAILREMOVE);
        }
        else
        {
            triggerTrap(oTrappedItem, oPC);
        }

        DeleteLocalObject(oPC, "oToolTarget");
        DeleteLocalInt(oPC, "nSkillMod");

    }
}

void triggerTrap(object oTrappedObject, object oVictim)
{
    switch (GetObjectType(oTrappedObject))
    {
        case OBJECT_TYPE_DOOR:
            AssignCommand(oVictim, ActionDoCommand(SetLocked(oTrappedObject, FALSE)));
            AssignCommand(oVictim, ActionOpenDoor(oTrappedObject));
            AssignCommand(oVictim, ActionDoCommand(SetLocked(oTrappedObject, TRUE)));
            break;
        case OBJECT_TYPE_PLACEABLE:
            AssignCommand(oVictim, ActionInteractObject(oTrappedObject));
            break;
        case OBJECT_TYPE_TRIGGER:
            AssignCommand(oVictim, ActionForceMoveToLocation(GetLocation(oTrappedObject)));
            break;
    }
}
