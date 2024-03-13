// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Ply_Dying
//::////////////////////////////////////////////////////////////////////////////
/*
     Hardcore Dying, Bleed's Out at -1.0 hp / 6 sec.

     This script is used in OnPlayerDying event in Module Properties. It is
    called if the players hit points drop to 0 to -9. This will set the
    PlayerState to dying and strip inventory if DYINGSTRIP is used.
*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_DBagCheck"
#include "HC_Inc_DropBag"
#include "HC_Inc_On_Dying"
#include "HC_Inc_Persist"
#include "HC_Inc_Transfer"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    if (!preEvent())
        return;

    // Prevent bleeding while already in fugue. Thanks Sir Elric.
    object oPlayer = GetLastPlayerDying();
    effect eDeath = EffectDeath(FALSE, FALSE);
    if (GetTag(GetArea(oPlayer)) == "FuguePlane")
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPlayer);
        return;
    }

    // Prevent Bleed while currently possessing a Familiar or Companion. They
    // should be killed and treated as they just died.
    object oMaster = GetMaster(oPlayer);
    if (GetIsObjectValid(oMaster))
    {
        if (GetLocalInt(oMod, "REALFAM"))
        {
            int nXPPen = (200 * GetHitDice(oMaster));
            if (FortitudeSave(oMaster, 15) > 0)
                nXPPen /= 2;
            SetLocalInt(oMaster, "TAKEXP", nXPPen);
            ExecuteScript("hc_takexp", oMaster);
            SetLocalInt(oMod, "FAMDIED" + GetPlayerID(oMaster), 1);
        }
        else
        {
            int nDam = d6();
            int nCHP = GetCurrentHitPoints(oMaster);
            if (nDam >= nCHP)
                nDam = (nCHP - 1);
            effect eDam = EffectDamage(nDam);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, oMaster);
        }

        SendMessageToPC(oMaster, "Your familiar is dead.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPlayer);
        return;
    }

    // Only execute Bleed code if that system is on and the player is actually
    // dying. Just kill the player if they bypassed dying and went straight to
    // dead. The Death code will handle corpse and drop bag creation as well as
    // inventory transfer.
    int nBleed = GetLocalInt(oMod, "BLEEDSYSTEM");
    int nCHP   = GetCurrentHitPoints(oPlayer);
    if (nBleed && nCHP < 1 && nCHP > -10)
    {
        string sID = GetPlayerID(oPlayer);
        location lPlayer = GetLocation(oPlayer);

        //
        SPS(oPlayer, PWS_PLAYER_STATE_DYING);
        SetPersistentInt(oMod, "LastHP" + sID, nCHP);
        DelayCommand(6.0, ExecuteScript("hc_bleeding", oPlayer));
        SetPersistentLocation(oMod, "DIED_HERE" + sID, lPlayer);

        // Create Death Corpse and transfer inventory items to it.
        if (GetLocalInt(oMod, "DEATHSYSTEM") &&
            GetLocalInt(oMod, "LOOTSYSTEM") &&
            GetLocalInt(oMod, "DYINGSTRIP"))
        {
            object oDropBag   = GetLocalObject(oMod, "DropBag" + sID);
            location lDropBag = GetLocation(oDropBag);

            // If no death corpse exists, make one
            if (GetIsObjectValid(oDropBag) == FALSE ||
                GetDistanceBetweenLocations(lPlayer, lDropBag) > 3.0 ||
                GetAreaFromLocation(lDropBag) != GetArea(oPlayer))
            {
                oDropBag = DropBag(lPlayer, oPlayer);
                SetLocalObject(oMod, "DropBag" + sID, oDropBag);
                SetLocalObject(oDropBag, "Owner", oPlayer);
                SetLocalString(oDropBag, "Name", GetName(oPlayer));
                SetLocalString(oDropBag, "Key", GetPCPlayerName(oPlayer));
                SetLocalString(oDropBag, "Pkey", sID);
            }

            // Move all inventory items to the death corpse.
            hcTakeObjects(oPlayer, oDropBag);

            // Transfer gold.
            int nAmtGold = GetGold(oPlayer);
            if (nAmtGold > 0)
            {
                object oBag = CreateItemOnObject("bagofgold", oDropBag);
                SetLocalInt(oBag, "AmtGold", nAmtGold);
                SetLocalInt(oDropBag, "AmtGold", nAmtGold);
                AssignCommand(oDropBag, TakeGoldFromCreature(nAmtGold, oPlayer, TRUE));
            }

            //
            CheckDbag(oDropBag);

            //
            if (GetLocalInt(oMod, "PERSIST"))
                DelayCommand(4.5, HCStoreDB(sID));
        }
    }
    else
    {
        // Bleed System is off, kill the player.
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPlayer);
    }

    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
