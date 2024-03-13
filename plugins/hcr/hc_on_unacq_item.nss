// HCR v3.03b Added reworked DoA Gold Encumberance - CFX

// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_UnAcq_Item
//::////////////////////////////////////////////////////////////////////////////
/*

*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_DCorpse"
#include "HC_Inc_On_UnAcq"
#include "HC_Inc_Transfer"
#include "HC_Text_UnAcq"
#include "omw_plns"
//::////////////////////////////////////////////////////////////////////////////
void Uniditem(object oItem, object oPC)
{
    // If item tag has "_AID" in it, never unidentify on drop.
    if (GetItemPossessor(oItem) == OBJECT_INVALID &&
       (FindSubString(GetTag(oItem), "_AID") == -1))
        SetIdentified(oItem, FALSE);
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    // Add CNR event
    ExecuteScript("cnr_module_oui", OBJECT_SELF);
    // Oxen Trade Routes
    ExecuteScript("otr_module_oui", OBJECT_SELF);
    if (!preEvent())
        return;

    object oItem = GetModuleItemLost();
    object oPC   = GetModuleItemLostBy();
    string sTag  = GetTag(oItem);

    //
    if (sTag == "PlayerCorpse")
    {
        // If someone drops a corpse, move the Death Corpse (item container) to
        // where the PC Token was dropped, and then put the PC Token back in it.
        if (GetLocalInt(oMod, "DEATHSYSTEM"))
        {
            object oPoss = GetItemPossessor(oItem);
            if (oPoss == OBJECT_INVALID && GetTag(GetArea(oItem)) == "")
            {
                postEvent();
                return;
            }

            object oDC    = GetLocalObject(oItem, "DeathCorpse");
            object oOwner = GetLocalObject(oItem, "Owner");
            string sName  = GetLocalString(oItem, "Name");
            string sCDK   = GetLocalString(oItem, "Key");
            string sID    = (sName + sCDK);
            object oDeathCorpse = CopyFromFugue(oOwner, oPC, oItem);
            if (GetIsObjectValid(oDeathCorpse))
            {
                // Transfer the variables.
                SetLocalObject(oMod, "DeathCorpse" + sID, oDeathCorpse);
                SetLocalObject(oDeathCorpse, "Owner", oOwner);
                SetLocalString(oDeathCorpse, "Name", sName);
                SetLocalString(oDeathCorpse, "Key", sCDK);
                SetLocalString(oDeathCorpse, "Pkey", sID);

                // Change Death Location.
                location lDiedHere = GetLocation(oDeathCorpse);
                SetPersistentLocation(oMod, "DIED_HERE" + sID, lDiedHere);

                // Copy the PCT and all of its variables into the new Corpse.
                object oDeadMan = CopyItem(oItem, oDeathCorpse, TRUE);
                if (GetIsObjectValid(oDeadMan))
                {
                    // Update the local object pointers and remove the old PCT.
                    SetLocalObject(oMod, "PlayerCorpse" + sID, oDeadMan);
                    SetLocalObject(oOwner, "PlayerToken", oDeadMan);
                    SetLocalObject(oDeadMan, "DeathCorpse", oDeathCorpse);
                    SetLocalObject(oDeathCorpse, "PlayerCorpse", oDeadMan);
                    DestroyObject(oItem);
                }
            }
        }
        else
        {
            // Death System is off. Remove the useless PCT.
            DestroyObject(oItem);
        }
    }

    //
    if (GetIsNoDrop(oItem) || GetTag(GetArea(oPC)) == "FuguePlane")
    {
        if (!GetIsDM(oPC) && !GetIsDMPossessed(oPC))
        {
            object oNew;
            object oArea = GetAreaFromLocation(GetLocation(oItem));
            object oPoss = GetItemPossessor(oItem);
            switch (GetObjectType(oPoss))
            {
                case OBJECT_TYPE_PLACEABLE:
                case OBJECT_TYPE_STORE:
                    DestroyObject(oItem);
                    break;
                default:
                    if (GetIsObjectValid(oArea))
                    {
                        oNew = CopyItem(oItem, oPC, TRUE);
                        if (GetIsObjectValid(oNew))
                        {
                            SendMessageToPC(oPC, "The " + GetName(oItem) + " may not be dropped!");
                            DestroyObject(oItem);
                        }
                    }
                    break;
            }
        }
    }
    else
    {
        // If UNIDONDROP is set unidentify the item on drop to ground after 5
        // min. This prevents players iding something and dropping it and
        // someone else comes along and picks it up and its id'ed for them. Very
        // unrealistic. Also when you die you lost memory of your identified
        // items after a certain period of time.
        if (GetLocalInt(oMod, "UNIDONDROP"))
            DelayCommand(300.0, Uniditem(oItem, oPC));
    }

    // Added for reworked HCR version of DoA Gold Encumberance - CFX
    {
    object oItem = GetModuleItemLost();
    if (!GetIsObjectValid(oItem)) return;
    object oPC = GetModuleItemLostBy();
    if (!GetIsPC(oPC)) return;
    string sItemResRef = GetResRef(oItem);

    /*  DOA Gold Encumbrance System 1.0
    + will only fire if there is not already gold in container */
    if (sItemResRef == "nw_it_gold001") ExecuteScript("doa_goldencum", oPC);
    }

    // added for old man whistlers loot notification
    if (GetLocalInt(oMod, "LOOTNOTIFY"))
    RunLootNotificationOnUnAcquire();

    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
