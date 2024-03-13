// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_Inc_Death
//::////////////////////////////////////////////////////////////////////////////
/*
     This file contains functions used by the On Player Death Event.
*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_RemEff"
//::////////////////////////////////////////////////////////////////////////////


// * FUNCTION PROTOTYPES


// This will check and return TRUE if oPlayer has died while already in the
// Death Plane. If the player did die in the Death Plane this will also return
// them back to life. Returns FALSE otherwise.
int  HCR_CheckDeathPlane(object oPlayer);

int  HCR_GetIsNotDead(object oPlayer, string sID);

void HCR_RaiseAndMovePlayer(object oPlayer, object oLimbo, string sID);

void HCR_SendToDeathPlane(object oPlayer, object oLimbo, string sID);

void HCR_StripEquipped(object oPlayer, object oCorpse, object oItem);


// * FUNCTION DEFINITIONS


//::////////////////////////////////////////////////////////////////////////////
int HCR_CheckDeathPlane(object oPlayer)
{
    if (GetTag(GetArea(oPlayer)) == "FuguePlane")
    {
        effect eRez  = EffectResurrection();
        int    nHeal = (abs(GetCurrentHitPoints(oPlayer)) + GetMaxHitPoints(oPlayer));
        effect eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRez, oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);
        return TRUE;
    }
    return FALSE;
}
//::////////////////////////////////////////////////////////////////////////////
int HCR_GetIsNotDead(object oPlayer, string sID)
{
    if (GetLocalInt(oMod, "LOOTSYSTEM"))
    {
        if (GetLocalInt(oPlayer, "NOTFUGUE") ||
            GPS(oPlayer) != PWS_PLAYER_STATE_DEAD)
        {
            object oDB = GetLocalObject(oMod, "DropBag" + sID);
            if (oDB != OBJECT_INVALID)
                AssignCommand(oDB, ClearAllActions());
            DeleteLocalInt(oPlayer, "NOTFUGUE");
            return TRUE;
        }
    }

    return FALSE;
}
//::////////////////////////////////////////////////////////////////////////////
void HCR_RaiseAndMovePlayer(object oPlayer, object oLimbo, string sID)
{
    // If the player has been rez's or is no longer dead, abort transfer.
    if (HCR_GetIsNotDead(oPlayer, sID) == TRUE)
        return;

    // Rez the player so they can be moved to fugue.
    effect eRez  = EffectResurrection();
    int    nHeal = (abs(GetCurrentHitPoints(oPlayer)) + GetMaxHitPoints(oPlayer));
    effect eHeal = EffectHeal(nHeal);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRez, oPlayer);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPlayer);

    // Remove any possible lingering effects.
    HCR_RemoveEffects(oPlayer);

    // Move the player to fugue.
    AssignCommand(oPlayer, ClearAllActions());
    AssignCommand(oPlayer, ActionJumpToLocation(GetLocation(oLimbo)));
}
//::////////////////////////////////////////////////////////////////////////////
void HCR_SendToDeathPlane(object oPlayer, object oLimbo, string sID)
{
    // If the player has been rez's or is no longer dead, abort transfer.
    if (HCR_GetIsNotDead(oPlayer, sID) == TRUE)
        return;

    // Turn up delay if you are getting lots of lag on transfering items.
    // Note: Delay is at 8.1 so the PC is moved AFTER the corpse gets created.
    DelayCommand(8.1, HCR_RaiseAndMovePlayer(oPlayer, oLimbo, sID));
}
//::////////////////////////////////////////////////////////////////////////////
void HCR_StripEquipped(object oPlayer, object oCorpse, object oItem)
{
    if (GetIsObjectValid(oItem))
    {
        object oNew = CopyItem(oItem, oCorpse, TRUE);
        if (oNew != OBJECT_INVALID)
            DestroyObject(oItem);
    }
}
//::////////////////////////////////////////////////////////////////////////////
//void main(){}
