// HCR v3.0.3 - Added rest fix - 18th May, 2005 - SE
// HCR v3.2.0 - Added big module clock fix - Sunjammer
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_HeartBeat
//::////////////////////////////////////////////////////////////////////////////
/*
    OnHeartBeat event script for the Module to manage various repeating checks
    and updates.
*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_HTF"
#include "HC_Inc_On_HrtBt"
#include "HC_Inc_TimeCheck"
#include "HC_Inc_Wandering"
#include "HC_Text_HrtBeat"
#include "CRR_Subrace_HC_i"
//::////////////////////////////////////////////////////////////////////////////


// Setting this to TRUE will force the clock to update which fixes a problem
// with time not progressing on large modules.
const int HCR_BIG_MODULE_CLOCK_FIX = FALSE;


//::////////////////////////////////////////////////////////////////////////////
void main()
{
    if (!preEvent())
        return;

    int nCurrentHour = GetTimeHour();

    // Forced time update.
    if (HCR_BIG_MODULE_CLOCK_FIX)
        SetTime(nCurrentHour, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());

    // Subrace heart beat.
    if (GetLocalInt(oMod, "SUBRACES"))
        crr_SubraceHCRheartbeat();

    // hunger, thirst and fatigue system check
    if (SecondsSinceBegin() > GetLocalInt(oMod, "NEXTHTFCHECK"))
        SignalEvent(oMod, EventUserDefined(HTFCHKEVENTNUM));

    // player related checks:
    object oPlayer = GetFirstPC();
    string sID     = GetPlayerID(oPlayer);
    while (GetIsObjectValid(oPlayer))
    {
        string sCDK = GetPCPlayerName(oPlayer);

        // Remove invulnerbility?
        if (GetPlotFlag(oPlayer) && !GetLocalInt(oPlayer, "GHOST") &&
           !GetIsDM(oPlayer) && !GetIsDMPossessed(oPlayer))
            SetPlotFlag(oPlayer, FALSE);

        // Update the rest GUI button?
        if (GetLocalInt(oMod, "RESTSYSTEM"))
        {
           if(!GetLocalInt(oMod, sID))
           {
              SetPanelButtonFlash(oPlayer,PANEL_BUTTON_REST,1);
           }
        }

        // Store current HP.
        if (!GetIsDM(oPlayer))
        {
            int nHP = GetCurrentHitPoints(oPlayer);
            SetPersistentInt(oMod, "LastHP" + GetName(oPlayer) + sCDK, nHP);
        }

        // Torches and lanterns check.
        if (GetLocalInt(oMod, "BURNTORCH"))
        {
            if (!GetIsDM(oPlayer))
            {
                object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPlayer);
                string sTag = GetTag(oTorch);

                if (sTag == "NW_IT_TORCH001" || sTag == "hc_torch" || sTag == "hc_lantern")
                {
                    // Update burn count, get burn limit.
                    int nBurnCount = GetLocalInt(oTorch, "BURNCOUNT") + 1;
                    int nBurnLimit = GetLocalInt(oMod, "BURNTORCH") * FloatToInt(HoursToSeconds(1) / 6.0);

                    if (nBurnCount >= nBurnLimit)
                    {
                        // If burned out then ...
                        if (sTag == "NW_IT_TORCH001" || sTag == "hc_torch")
                        {
                            // ... destroy torches ...
                            DestroyObject(oTorch);
                            SendMessageToPC(oPlayer,TORCHOUT);
                        }
                        else
                        {
                            // ... and unequip lanterns ...
                            AssignCommand(oPlayer, ActionUnequipItem(oTorch));
                            SendMessageToPC(oPlayer, LANTERNOUT);
                        }
                    }
                    else
                    {
                        // .. otherwise store updated burn count
                        SetLocalInt(oTorch, "BURNCOUNT", nBurnCount);
                    }
                }
            }
        }

        // Boot PC's exceeding limit.
        if (GetLocalInt(oMod, "PKTRACKER"))
        {
            if(GetPersistentInt(oMod, "PKCOUNT" + sCDK) > GetLocalInt(oMod, "PKTRACKER"))
            {
                WriteTimestampedLogEntry("** Booted: " + sCDK + " for excessive PK");
                SendMessageToAllDMs(sCDK + DMBOOTPK);
                BootPC(oPlayer);
                postEvent();
                return;
            }
        }

        // Wandering monsters check(Old redundant system, can be removed - Sir Elric)
        /*if (GetLocalInt(oMod, "WANDERSYSTEM") && GetLocalInt(oPlayer, "RESTING"))
        {
            int nChance = GetLocalInt(GetArea(oPlayer), "WANDERCHANCE");
            int nStrength = GetLocalInt(GetArea(oPlayer), "WANDERSTRENGTH");
            wander_check(oPlayer, nChance, nStrength);
        }*/

        // Get next player.
        oPlayer = GetNextPC();
    }

    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
