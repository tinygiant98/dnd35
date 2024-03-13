// sr5.2
#include "hc_text_traps"

void triggerTrap(object oTrap, object oVictim);

void main()
{
    object oPC = GetPCSpeaker();
    SendMessageToPC(oPC, MARKING);

    if (oPC != OBJECT_INVALID)
    {

        int nSkillMod = GetLocalInt(oPC, "nSkillMod");
        object oTrappedItem = GetLocalObject(oPC, "oToolTarget");
        int iTrapDC = GetTrapDisarmDC(oTrappedItem);
        object oParty;
        if(iTrapDC>=101)iTrapDC=iTrapDC-100;
        iTrapDC=iTrapDC-10;

            int nDisarm = GetSkillRank(SKILL_DISABLE_TRAP, oPC);
            int nDCCheck = d20() + nDisarm + nSkillMod;
            if (nDCCheck >= iTrapDC && nDisarm >= 1) // Trap disarmed
            {
              oParty=GetFirstFactionMember(oPC);
              while(GetIsObjectValid(oParty))
               {
                SetTrapDetectedBy(oTrappedItem,oParty);
                oParty=GetNextFactionMember(oPC);
               }
              SendMessageToPC(oPC, MARKED);
            }
            else if ((nDCCheck - iTrapDC) < -4)
            {
                SendMessageToPC(oPC, TRAPTRIGGERED);
                triggerTrap(oTrappedItem, oPC);
            }
            else
                SendMessageToPC(oPC, FAILMARK);

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
