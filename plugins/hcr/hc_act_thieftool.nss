// sr5.3
// added new DM conversation invisible object and create it where the player is
// inserted line 61/62, changed line 64
#include "hc_text_activate"
void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    string sItemTag=GetLocalString(oUser,"TAG");
    DeleteLocalString(oUser,"TAG");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
    location lPlayer = GetLocation(OBJECT_SELF);
    object oDM=CreateObject(OBJECT_TYPE_PLACEABLE, "InvisDM", lPlayer);
    if (GetResRef(oItem) == "bwthievestools" ||GetResRef(oItem) == "thievestoolsm001" )
    {
      object oEquip1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser);
      object oEquip2 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oUser);
      if (oEquip1 != oItem && oEquip2 != oItem)
      {
         SendMessageToPC(oUser, MUSTEQUIP);
         return;
      }
    }
    // added to detect hidden trap triggers used by some traps
    object oTrigger;
    if (GetSubString(GetTag(oOther), 0, 5) == "HCTP_")
       oTrigger = GetNearestObjectByTag("Hidden_Trap_Trigger");
    else
       oTrigger = oOther;
        if (GetDistanceBetween(oUser, oTrigger) > (FeetToMeters(10.0)))
            SendMessageToPC(oUser, MOVECLOSER);
        else
        {
            int nSkillMod = 0;
            int nTrapped=GetIsTrapped(oOther);
            int nDetected=GetTrapDetectedBy(oOther, oUser);
            if (sItemTag == "thievesToolsMaster") nSkillMod = 2;

            // Check to see if the item is trapped, and if the trap is detected
            if (nTrapped && nDetected)
            {
                SetLocalObject(oUser, "oToolTarget", oOther);
                SetLocalInt(oUser, "nSkillMod", nSkillMod);
                AssignCommand(oUser, ActionStartConversation(oUser, "hc_c_thieftool", TRUE, FALSE));
            }
            else if (nTrapped && !nDetected)
            {
                switch (GetObjectType(oOther))
                {
                case OBJECT_TYPE_DOOR:
                    AssignCommand(oUser, ActionDoCommand(SetLocked(oOther, FALSE)));
                    AssignCommand(oUser, ActionOpenDoor(oOther));
                    AssignCommand(oUser, ActionDoCommand(SetLocked(oOther, TRUE)));
                    break;
                case OBJECT_TYPE_PLACEABLE:
                    AssignCommand(oUser, ActionInteractObject(oOther));
                    break;
                case OBJECT_TYPE_TRIGGER:
                    AssignCommand(oUser, ActionForceMoveToObject(oTrigger));
                    break;
                }
            }
            else if (GetLocked(oOther))
            {
                if (GetLockKeyRequired(oOther))
                {
                    SendMessageToPC(oUser, NEEDKEY);
                }
                else
                {
                    int iTrapDC = GetLockUnlockDC(oOther);
                    if(iTrapDC>=101)
                     iTrapDC=iTrapDC-100;
                    int nUnlock = GetSkillRank(SKILL_OPEN_LOCK, oUser);
                    //SendMessageToPC(oUser, "Open Lock Skill : "+IntToString(nUnlock));
                    // if using the new style masterworktools on standard locks then
                    // set the skill mod to 0 as its already accounted for by its
                    // properties.
                    if (GetResRef(oItem) == "bwthievestools") nSkillMod = 0;
                    int nDCCheck = d20() + nUnlock +nSkillMod;
                    if (nDCCheck >= iTrapDC && (nUnlock >= 1)) // Door Unlocked
                    {
                        SetLocked(oOther, FALSE);
                        SendMessageToPC(oUser, UNLOCK);
                    }
                    else
                    {
                        SendMessageToPC(oUser, FAILUNLOCK);
                        if(d100() < (iTrapDC/2))
                        {
                            DestroyObject(oItem);
                            SendMessageToPC(oUser, TOOLBREAK);
                        }
                    }
                }
           }
     }
}

