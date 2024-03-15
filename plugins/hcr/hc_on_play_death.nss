// HCR 3.4.0 - 21st July, 2008
// HCR v3.0.3 - 18th May, 2005 Updated by SJ
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Play_Death
//::////////////////////////////////////////////////////////////////////////////
/*
    *Note* HCR_StripEquipped() can be safely deleted from hc_inc_death at some point - SJ

    Hardcore Death - Creates Death Amulet on player to prevent quit and return
    Also pops up Death GUI where respawn is now pray - Archaegeo

    This script sets the PlayerState to DEAD once they hit -10 hitpoits and
    displays one GUI if they have a deity, and another if they do not. Respawn
    button prays for ressurection on the one, and does nothing on other.

    REZPENALTY code by: Jamos and Majoru
*/
//::////////////////////////////////////////////////////////////////////////////

#include "CRR_Subrace_HC_i"
#include "HC_Inc_DCorpse"
#include "HC_Inc_Death"
#include "HC_Inc_DropBag"
#include "HC_Inc_Gods"
#include "HC_Inc_On_Death"
#include "HC_Inc_RezPen"
#include "HC_Inc_TimeCheck"
#include "HC_Inc_Transfer"
#include "x3_inc_horse"

//::////////////////////////////////////////////////////////////////////////////
void main()
{
    object oPlayer = GetLastPlayerDied();
    object oHorse;
    object oInventory;
    string sID;
    int nC;
    string sT;
    string sR;
    int nCH;
    int nST;
    object oItem;
    effect eEffect;
    string sDB="X3SADDLEBAG"+GetTag(GetModule());

    if (GetStringLength(GetLocalString(GetModule(),"X3_SADDLEBAG_DATABASE"))>0) sDB=GetLocalString(GetModule(),"X3_SADDLEBAG_DATABASE");
    if (HorseGetIsMounted(oPlayer))
    { // Dismount and then die
        //SetCommandable(FALSE,oPlayer);
        //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        DelayCommand(0.3,HORSE_SupportResetUnmountedAppearance(oPlayer));
        DelayCommand(3.0,HORSE_SupportCleanVariables(oPlayer));
        DelayCommand(1.0,HORSE_SupportRemoveACBonus(oPlayer));
        DelayCommand(1.0,HORSE_SupportRemoveHPBonus(oPlayer));
        DelayCommand(1.1,HORSE_SupportRemoveMountedSkillDecreases(oPlayer));
        DelayCommand(1.1,HORSE_SupportAdjustMountedArcheryPenalty(oPlayer));
        DelayCommand(1.2,HORSE_SupportOriginalSpeed(oPlayer));
        if (!GetLocalInt(GetModule(),"X3_HORSE_NO_CORPSES"))
        { // okay to create lootable horse corpses
            sR=GetSkinString(oPlayer,"sX3_HorseResRef");
            sT=GetSkinString(oPlayer,"sX3_HorseMountTag");
            nCH=GetSkinInt(oPlayer,"nX3_HorseAppearance");
            nST=GetSkinInt(oPlayer,"nX3_HorseTail");
            nC=GetLocalInt(oPlayer,"nX3_HorsePortrait");
            if (GetStringLength(sR)>0&&GetStringLeft(sR,GetStringLength(HORSE_PALADIN_PREFIX))!=HORSE_PALADIN_PREFIX)
            { // create horse
                oHorse=HorseCreateHorse(sR,GetLocation(oPlayer),oPlayer,sT,nCH,nST);
                SetLootable(oHorse,TRUE);
                SetPortraitId(oHorse,nC);
                SetLocalInt(oHorse,"bDie",TRUE);
                AssignCommand(oHorse,SetIsDestroyable(FALSE,TRUE,TRUE));
            } // create horse
        } // okay to create lootable horse corpses
        oInventory=GetLocalObject(oPlayer,"oX3_Saddlebags");
        sID=GetLocalString(oPlayer,"sDB_Inv");
        if (GetIsObjectValid(oInventory))
        { // drop horse saddlebags
            if (!GetIsObjectValid(oHorse))
            { // no horse created
                HORSE_SupportTransferInventory(oInventory,OBJECT_INVALID,GetLocation(oPlayer),TRUE);
            } // no horse created
            else
            { // transfer to horse
                HORSE_SupportTransferInventory(oInventory,oHorse,GetLocation(oHorse),TRUE);
                //DelayCommand(2.0,PurgeSkinObject(oHorse));
                //DelayCommand(3.0,KillTheHorse(oHorse));
                //DelayCommand(1.8,PurgeSkinObject(oHorse));
            } // transfer to horse
        } // drop horse saddlebags
        else if (GetStringLength(sID)>0)
        { // database based inventory
            nC=GetCampaignInt(sDB,"nCO_"+sID);
            while(nC>0)
            { // restore inventory
                sR=GetCampaignString(sDB,"sR"+sID+IntToString(nC));
                sT=GetCampaignString(sDB,"sT"+sID+IntToString(nC));
                nST=GetCampaignInt(sDB,"nS"+sID+IntToString(nC));
                nCH=GetCampaignInt(sDB,"nC"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"sR"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"sT"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"nS"+sID+IntToString(nC));
                DeleteCampaignVariable(sDB,"nC"+sID+IntToString(nC));
                if (!GetIsObjectValid(oHorse))
                { // no lootable corpse
                    oItem=CreateObject(OBJECT_TYPE_ITEM,sR,GetLocation(oPlayer),FALSE,sT);
                } // no lootable corpse
                else
                { // lootable corpse
                    oItem=CreateItemOnObject(sR,oHorse,nST,sT);
                } // lootable corpse
                if (GetItemStackSize(oItem)!=nST) SetItemStackSize(oItem,nST);
                if (nCH>0) SetItemCharges(oItem,nCH);
                nC--;
            } // restore inventory
            DeleteCampaignVariable(sDB,"nCO_"+sID);
            //DelayCommand(2.0,PurgeSkinObject(oHorse));
            if (GetIsObjectValid(oHorse)&&GetLocalInt(oHorse,"bDie")) DelayCommand(3.0,KillTheHorse(oHorse));
            //DelayCommand(2.5,PurgeSkinObject(oHorse));
        } // database based inventory
        else if (GetIsObjectValid(oHorse))
        { // no inventory
            //DelayCommand(1.0,PurgeSkinObject(oHorse));
            DelayCommand(2.0,KillTheHorse(oHorse));
            //DelayCommand(1.8,PurgeSkinObject(oHorse));
        } // no inventory
        //eEffect=EffectDeath();
        //DelayCommand(1.6,ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oPlayer));
        //DelayCommand(1.7,SetCommandable(TRUE,oPlayer));
        //return;
    } // Dismount and then die

    // Check User code.
    if (!preEvent())
        return;

    // Prevent re-death while already in fugue. Thanks Sir Elric.
    if (HCR_CheckDeathPlane(oPlayer))
        return;

    // Check Subrace System Death.
    if (GetLocalInt(oMod, "SUBRACES") && !crr_SubraceHCRdeath(oPlayer))
        return;

    // If using the Deity system, check to see if they have a god, and if that
    // god is listening. (5% chance by default, only once per character)
    if (GetLocalInt(oMod, "GODSYSTEM") && RessCheck(oPlayer))
        return;

    // Player is dead and the code should continue processing at this point.
    object oKiller = GetLastAttacker(oPlayer);
    string sName   = GetName(oPlayer);
    string sPCName = GetPCPlayerName(oPlayer);
    sID     = GetPlayerID(oPlayer);
    int nCurState  = GPS(oPlayer);

    // Set/Check last death time.
    int nSSB = SecondsSinceBegin();
    if ((GetLocalInt(oMod, "LASTDIED" + sID) + 60) > nSSB)
        SendMessageToAllDMs("** WARNING **" + sPCName + " might be trying to avoid death.");
    else
        SetLocalInt(oMod, "LASTDIED" + sID, nSSB);

    // Check if the player was PK'd and PK Tracker is used.
    if (GetLocalInt(oMod, "PKTRACKER") > 0)
    {
        // Loop through the masters looking for the player that owns the NPC's.
        // Note DM's should not be considered for this purpose.
        int nCount;
        string sPKName = GetPCPlayerName(oKiller);
        object oMaster = GetMaster(oKiller);
        while (GetIsObjectValid(oMaster))
        {
            if (GetIsPC(oMaster) &&
               !GetIsDM(oMaster) &&
               !GetIsDMPossessed(oMaster))
            {
                sPKName = GetPCPlayerName(oMaster);
                oKiller = oMaster;
                break;
            }
            oMaster = GetMaster(oMaster);
        }

        // If we have a valid PC Name and the killer is not a member of the
        // players faction, then increment the PK count.
        if (sPKName != "" && !GetFactionEqual(oPlayer, oKiller))
        {
            nCount = GetPersistentInt(oMod, "PKCOUNT" + sPKName);
            SetPersistentInt(oMod, "PKCOUNT" + sPKName, nCount + 1);
        }
    }

    // Check if Tell on PK is used.
    if (GetLocalInt(oMod, "TELLONPK") && GetIsPC(oKiller))
        SendMessageToAllDMs("**(PK): " + sName + " was PK'd by " + GetName(oKiller));

    // Set the death location.
    location lPlayer = GetLocation(oPlayer);
    location lDiedHere;
    if (GetLocalInt(oPlayer, "LOGINDEATH"))
    {
        // For graveyard and relogin.
        object oGraveYard = GetObjectByTag("GraveYard");
        if (GetLocalInt(oPlayer, "GRAVEYARD"))
        {
            DeleteLocalInt(oPlayer, "GRAVEYARD");
            lDiedHere = GetLocation(oGraveYard);
        }
        else
        {
            // Set location to previously saved death loc. If for any reason
            // that area is now invalid or was deleted/removed from the DB use
            // the graveyard as the death location.
            lDiedHere = GetPersistentLocation(oMod, "DIED_HERE" + sID);
            if (!GetIsObjectValid(GetAreaFromLocation(lDiedHere)))
                lDiedHere = GetLocation(oGraveYard);
        }

        // Look for a corpse already at the death location.
        object oObject = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, lDiedHere);
        if (GetTag(oObject) == "DeathCorpse" &&
            GetDistanceBetweenLocations(lDiedHere, GetLocation(oObject)) < 0.4)
        {
            // Add random float for drop location when logging in dead. This is
            // to help prevent too many corpses from stacking directly on top of
            // each other at the graveyard.
            float fRan = (IntToFloat(d20()) / 10.0);
            if (d2() == 1)
                fRan *= -1.0;
            vector vAdj = Vector(0.4 + fRan, 0.4 + fRan, 0.0);
            vector vPos = (GetPositionFromLocation(lDiedHere) + vAdj);
            lDiedHere = Location(GetArea(oObject), vPos, GetFacing(oPlayer));
        }
    }
    else
    {
        // Just died. Use current location as the death location.
        lDiedHere = lPlayer;
    }

    // Save the Death Location to the DB.
    SetPersistentLocation(oMod, "DIED_HERE" + sID, lDiedHere);

    // Remove all Henchmen from service.
    int nNth = 1;
    object oHench = GetHenchman(oPlayer, nNth);
    while (GetIsObjectValid(oHench))
    {
        RemoveHenchman(oPlayer, oHench);
        nNth++;
    }

    // If we are using the loot system, strip all items from the dead man.
    object oDeathCorpse;
    int nDEATHSYSTEM = GetLocalInt(oMod, "DEATHSYSTEM");
    int nLOOTSYSTEM = GetLocalInt(oMod, "LOOTSYSTEM");
    int nLIMBO = GetLocalInt(oMod, "LIMBO");
    if (nDEATHSYSTEM)
    {
        // Change the player state.
        SPS(oPlayer, PWS_PLAYER_STATE_DEAD);

        // Drop corpses held on death.
        ExecuteScript("hc_drop_corpse", oPlayer);

        object oDB;
        if (nLOOTSYSTEM)
        {
            // If no Drop Bag exists, make one.
            oDB = GetLocalObject(oMod, "DropBag" + sID);
            location lDB = GetLocation(oDB);
            if (!GetIsObjectValid(oDB) ||
                GetDistanceBetweenLocations(lPlayer, lDB) > 3.0 ||
                GetArea(oDB) != GetArea(oPlayer))
            {
                oDB = DropBag(lDiedHere, oPlayer);
                SetLocalObject(oDB, "Owner", oPlayer);
                SetLocalString(oDB, "Name", sName);
                SetLocalString(oDB, "Key", sPCName);
                SetLocalString(oDB, "Pkey", sID);
                SetLocalObject(oMod, "DropBag" + sID, oDB);
            }

            // Transfer Equipment.
            HC_Transfer_MoveEquipment(oPlayer, oDB);

            // Check to make sure the player wasnt already dying. If the player
            // was dying and Dying Strip is used then inventory is already being
            // transferred. If not dying or that system is off then transfer.
            if (GPS(oPlayer) != PWS_PLAYER_STATE_DYING
            || !GetLocalInt(oMod, "DYINGSTRIP"))
            {
                // Transfer Inventory.
                HC_Transfer_MoveInventory(oPlayer, oDB);

                // Transfer Gold
                HC_Transfer_MoveGold(oPlayer, oDB);
            }

        }

        // Create the Death Corpse.
        oDeathCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "DC", lDiedHere);
        if (oDeathCorpse != OBJECT_INVALID)
        {
            SetLocalObject(oMod, "DeathCorpse" + sID, oDeathCorpse);
            SetLocalObject(oDeathCorpse, "Owner", oPlayer);
            SetLocalString(oDeathCorpse, "Name", sName);
            SetLocalString(oDeathCorpse, "Key", sPCName);
            SetLocalString(oDeathCorpse, "Pkey", sID);
        }

        // Create the "copied" corpse.
        // Note: Using delay to avoid creating copy when the player is not dead.
        DelayCommand(8.0, CreateCorpse(oPlayer));

        // Create a Player Corpse Token (PCT).
        object oDeadMan = GetLocalObject(oMod, "PlayerCorpse" + sID);
        if (GetIsObjectValid(oDeadMan))
            SetLocalInt(oPlayer, "REDEATH", 0);
        else
            oDeadMan = CreateItemOnObject("PlayerCorpse", oDeathCorpse);

        // Set/Update the locals on the PCT, Death Corpse and Player.
        SetLocalObject(oMod, "PlayerCorpse" + sID, oDeadMan);
        SetLocalObject(oPlayer, "PlayerToken", oDeadMan);
        SetLocalObject(oDeadMan, "Owner", oPlayer);
        SetLocalObject(oDeathCorpse, "PlayerCorpse", oDeadMan);
        SetLocalObject(oDeadMan, "DeathCorpse", oDeathCorpse);
        SetLocalString(oDeadMan, "Name", sName);
        SetLocalString(oDeadMan, "Key", sPCName);
        SetLocalString(oDeadMan, "PKey", sID);
        SetLocalString(oDeadMan, "Deity", GetDeity(oPlayer));
        SetLocalInt(oDeadMan, "Alignment", GetAlignmentGoodEvil(oPlayer));


        // If using lIMBO, give feedback, set the moving local and start the
        // transfer to the Death Plane. Otherwise just pop up the GUI with the
        // respawn button disabled.
        if (nLIMBO)
        {
            SendMessageToPC(oPlayer, "You have died and your spirit was sent to the Death Plane. You may exit or wait for help.");
            SetLocalInt(oPlayer, "MOVING", TRUE);
            object oLimbo = GetObjectByTag("FugueMarker");
            HCR_SendToDeathPlane(oPlayer, oLimbo, sID);
        }
        else
        {
            DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, FALSE, TRUE, 0, "You may exit or wait for help."));
        }
    }
    else
    {
        // Check/Set Rez Penalty for respawn.
        if (GetLocalInt(oMod, "REZPENALTY") )
            SetPersistentInt(oMod, "REZPEN" + sID, 1);

        // Not using Death System, let them respawn normally.
        DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer, TRUE, TRUE, 0, "You may exit or respawn."));
    }

    // Reset last recovery check time, last rest time and log in death values.
    DeletePersistentInt(oMod, "LastRecCheck" + sID);
    DeletePersistentInt(oMod, "LastRest" + sID);
    DeleteLocalInt(oPlayer, "LOGINDEATH");

    postEvent();
}
