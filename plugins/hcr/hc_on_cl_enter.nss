/*
HCR 3.4 added horse code for 1.69

HCR v.3.03.0b added PHB Racial Movement - cfx
                 added DoA Gold Encumberance reworked for use with HCR
*/

// HCR v3.2.0 - Re-Added spell tracking code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Cl_Enter
//::////////////////////////////////////////////////////////////////////////////
/*
   This script goes in OnClientEnter in Module Properties - Events. It checks
  to see if they have a Death Amulet on them, and if so. It sets thier player
  state to Dead and rekills them.
*/
//::////////////////////////////////////////////////////////////////////////////
#include "CRR_Subrace_HC_i"
#include "HC_CDrop_On_Ent"
#include "HC_Id"
#include "HC_Inc"
#include "HC_Inc_HTF"
#include "HC_Inc_On_Enter"
#include "HC_Inc_Persist"
#include "HC_Inc_RemEff"
#include "HC_Inc_RezPen"
#include "HC_Inc_TimeCheck"
#include "HC_Text_Enter"
#include "I_TagTests"
#include "omw_plns"
//::////////////////////////////////////////////////////////////////////////////
// If not restarted, kill them.
void CheckFugue(object oPC)
{
    if (GetTag(GetArea(oPC)) != "FuguePlane")
    {
        if (!GetLocalInt(oPC, "ENTERED"))
            SetLocalInt(oPC, "GRAVEYARD", TRUE);

        SetLocalInt(oPC, "LOGINDEATH", 1);

        effect eDeath = EffectDeath(FALSE, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
    }
}
//::////////////////////////////////////////////////////////////////////////////
// New function based on hc_defaults setting.
// Allow PrC's if the player already has it.
void prcunset(object oPC)
{
    // Hark - Added in HOTU PrC's.
    // Unset if PrC in second slot.
    int nClass = GetClassByPosition(2, oPC);
    switch (nClass)
    {
        case CLASS_TYPE_ASSASSIN:
            DeleteLocalInt(oPC, "X1_AllowAsasin");
            break;
        case CLASS_TYPE_ARCANE_ARCHER:
            DeleteLocalInt(oPC, "X1_AllowArcher");
            break;
        case CLASS_TYPE_BLACKGUARD:
            DeleteLocalInt(oPC, "X1_AllowBlkGrd");
            break;
        case CLASS_TYPE_DIVINECHAMPION:
            DeleteLocalInt(oPC, "X2_AllowDivcha");
            break;
        case CLASS_TYPE_DRAGONDISCIPLE:
            DeleteLocalInt(oPC, "X1_AllowDrDis");
            break;
        case CLASS_TYPE_DWARVENDEFENDER:
            DeleteLocalInt(oPC, "X1_AllowDwDef");
            break;
        case CLASS_TYPE_HARPER:
            DeleteLocalInt(oPC, "X1_AllowHarper");
            break;
        case CLASS_TYPE_PALEMASTER:
            DeleteLocalInt(oPC, "X2_AllowPalema");
            break;
        case CLASS_TYPE_SHADOWDANCER:
            DeleteLocalInt(oPC, "X1_AllowShadow");
            break;
        case CLASS_TYPE_SHIFTER:
            DeleteLocalInt(oPC, "X2_AllowShiftr");
            break;
        case CLASS_TYPE_WEAPON_MASTER:
            DeleteLocalInt(oPC, "X2_AllowWM");
            break;
        default: break;
    }

    // Unset if PrC in third slot.
    nClass = GetClassByPosition(3, oPC);
    switch (nClass)
    {
        case CLASS_TYPE_ASSASSIN:
            DeleteLocalInt(oPC, "X1_AllowAsasin");
            break;
        case CLASS_TYPE_ARCANE_ARCHER:
            DeleteLocalInt(oPC, "X1_AllowArcher");
            break;
        case CLASS_TYPE_BLACKGUARD:
            DeleteLocalInt(oPC, "X1_AllowBlkGrd");
            break;
        case CLASS_TYPE_DIVINECHAMPION:
            DeleteLocalInt(oPC, "X2_AllowDivcha");
            break;
        case CLASS_TYPE_DRAGONDISCIPLE:
            DeleteLocalInt(oPC, "X1_AllowDrDis");
            break;
        case CLASS_TYPE_DWARVENDEFENDER:
            DeleteLocalInt(oPC, "X1_AllowDwDef");
            break;
        case CLASS_TYPE_HARPER:
            DeleteLocalInt(oPC, "X1_AllowHarper");
            break;
        case CLASS_TYPE_PALEMASTER:
            DeleteLocalInt(oPC, "X2_AllowPalema");
            break;
        case CLASS_TYPE_SHADOWDANCER:
            DeleteLocalInt(oPC, "X1_AllowShadow");
            break;
        case CLASS_TYPE_SHIFTER:
            DeleteLocalInt(oPC, "X2_AllowShiftr");
            break;
        case CLASS_TYPE_WEAPON_MASTER:
            DeleteLocalInt(oPC, "X2_AllowWM");
            break;
        default: break;
    }
}
//::////////////////////////////////////////////////////////////////////////////
void TakeHPs(object oTarget)
{
    effect eDam = EffectDamage(GetCurrentHitPoints(oTarget) - 1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
}
//::////////////////////////////////////////////////////////////////////////////
void HCRBoot(object oPC, string sReason)
{
    SendMessageToPC(oPC, sReason);
    DelayCommand(10.0, BootPC(oPC));
}
//::////////////////////////////////////////////////////////////////////////////
location GetSavedLocation(object oPC)
{
    location lLoc = GetPersistentLocation(oPC, "PV_START_LOCATION");
    if (GetAreaFromLocation(lLoc) == OBJECT_INVALID)
        SetLocalInt(oPC, "TMP_VALID_SPAWN", 0);
    else
        SetLocalInt(oPC, "TMP_VALID_SPAWN", 1);
    return lLoc;
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    object oPC = GetEnteringObject();
    ExecuteScript("x3_mod_def_enter", oPC);
    // Add CNR event
    ExecuteScript("cnr_module_oce", OBJECT_SELF);
    ExecuteScript("otr_module_oce", OBJECT_SELF);

    if (!preEvent())
        return;

    object oGear;
    string sPDM   = GetPersistentString(oMod, "PLAYERDM");
    string sCDKey = GetPCPublicCDKey(oPC);
    string sCDK   = GetPCPlayerName(oPC);
    string sID    = GetPlayerID(oPC);
    string sName  = GetName(oPC);
    string sRegChar;
    int nGiveLevel = GetLocalInt(oMod, "GIVELEVEL");
    int nPKT = GetLocalInt(oMod, "PKTRACKER");
    int nDM  = GetIsDM(oPC);
    int nSlot;

    // Strip player corpses on enter.
    // Could happen if server restarts while carrying one.
    DropCorpse(oPC);

    // Party rest code.
    SetLocalInt(oPC, "RestOption", 0);

    // Remove invulnerability?
    SetPlotFlag(oPC, FALSE);

    // Check Subrace System Enter.
    if (GetLocalInt(oMod, "SUBRACES"))
        crr_SubraceHCRenter(oPC);




    // Check for allowed prestige classes.
    if (!nDM)
    {
        // Prep all classes as in hc_defaults
        if (!GetLocalInt(oMod, "ASSASIN") &&
            !GetPersistentInt(oMod, "ASSASIN" + sID))
            SetLocalInt(oPC, "X1_AllowAsasin", 1);
        if (!GetLocalInt(oMod, "ARCHER") &&
            !GetPersistentInt(oMod, "ARCHER" + sID))
            SetLocalInt(oPC, "X1_AllowArcher", 1);
        if (!GetLocalInt(oMod, "BLKGUARD") &&
            !GetPersistentInt(oMod, "BLKGUARD" + sID))
          SetLocalInt(oPC, "X1_AllowBlkGrd", 1);
        if (!GetLocalInt(oMod, "CHAMPION") &&
            !GetPersistentInt(oMod, "CHAMPION" + sID))
            SetLocalInt(oPC, "X2_AllowDivcha", 1);
        if (!GetLocalInt(oMod, "DISCIPLE") &&
            !GetPersistentInt(oMod, "DISCIPLE" + sID))
            SetLocalInt(oPC, "X1_AllowDrDis", 1);
        if (!GetLocalInt(oMod, "DEFENDER") &&
            !GetPersistentInt(oMod, "DEFENDER" + sID))
            SetLocalInt(oPC, "X1_AllowDwDef", 1);
        if (!GetLocalInt(oMod, "HARPER") &&
            !GetPersistentInt(oMod, "HARPER" + sID))
            SetLocalInt(oPC, "X1_AllowHarper", 1);
        if (!GetLocalInt(oMod, "PALEMSTR") &&
            !GetPersistentInt(oMod, "PALEMSTR" + sID))
            SetLocalInt(oPC, "X2_AllowPalema", 1);
        if (!GetLocalInt(oMod, "SHADOW") &&
            !GetPersistentInt(oMod, "SHADOW" + sID))
            SetLocalInt(oPC, "X1_AllowShadow", 1);
        if (!GetLocalInt(oMod, "SHIFTER") &&
            !GetPersistentInt(oMod, "SHIFTER" + sID))
            SetLocalInt(oPC, "X2_AllowShiftr", 1);
        if (!GetLocalInt(oMod, "WEAPMSTR") &&
            !GetPersistentInt(oMod, "WEAPMSTR" + sID))
            SetLocalInt(oPC, "X2_AllowWM", 1);

        prcunset(oPC);
    }

    if (nPKT)
    {
        if (GetPersistentInt(oMod, "PKCOUNT" + sCDK) > nPKT)
        {
            SendMessageToAllDMs(sCDK + DMBOOTPK);
            HCRBoot(oPC, PCBOOTPK);
            postEvent();
            return;
        }
    }


    if (GetLocalInt(oMod, "SINGLECHARACTER")  && !nDM)
    {
        sRegChar = GetPersistentString(oMod, "SINGLECHARACTER" + sCDKey);
        if (sRegChar != "" && sRegChar != sName)
        {
            HCRBoot(oPC, SINGLEBOOT + sRegChar);
            postEvent();
            return;
        }
        else
        {
            SetPersistentString(oMod, "SINGLECHARACTER" + sCDKey, sName);
            SendMessageToPC(oPC, SINGLEREG);
        }
    }
    else if (GetLocalInt(oMod, "MULTICHAR") > 0 && !nDM)
    {
        int nCount = 1;
        int nReg = FALSE;
        int nNum = GetLocalInt(oMod, "MULTICHAR");
        for (nCount; nCount <= nNum; nCount++)
        {
            sRegChar = GetPersistentString(oMod, "MULTICHAR" + IntToString(nCount) + sCDKey);
            if (sRegChar == "")
            {
                SetPersistentString(oMod, "MULTICHAR" + IntToString(nCount) + sCDKey, sName);
                SendMessageToPC(oPC, SINGLEREG);
                nCount = nNum + 1;
                nReg = TRUE;
            }
            else if (sRegChar == sName)
            {
                nReg = TRUE;
                nCount = nNum + 1;
            }
        }

        if (!nReg)
        {
            HCRBoot(oPC, MULTIBOOT);
            postEvent();
            return;
        }
    }

    if (GetPersistentInt(oMod, "BANNED" + sCDK))
    {
        HCRBoot(oPC, BANNED);
        postEvent();
        return;
    }

    if (GetLocalInt(oMod, "LOCKED") && !nDM)
    {
        HCRBoot(oPC, LOCKED);
        postEvent();
        return;
    }

    if (GetLocalInt(oMod, "DMRESERVE"))
    {
        int nC;
        object oPlayers = GetFirstPC();
        if (!nDM)
        {
            while (GetIsObjectValid(oPlayers))
            {
                if (!GetIsDM(oPlayers))
                    nC++;
                oPlayers = GetNextPC();
            }
        }

        if (nC > GetLocalInt(oMod, "DMRESERVE") && nDM == FALSE)
        {
            HCRBoot(oPC,DMRES);
            postEvent();
            return;
        }
    }

    if (!GetLocalInt(oMod, "HCRREAD"))
    {
        SendMessageToPC(oPC, NOHCRENABLED);
        return;
    }

    if (GetLocalInt(oMod, "STORESYSTEM"))
    {
        if (GetIsPC(oPC) && !(GetXP(oPC)) && !nDM)
        {
            // If you want everyone to have the same amount of starting gold,
            // modify the lines below:
            //int STARTING_GOLD = 150;
            int STARTING_GOLD = 0;
            int PLAYER_STRIPS = TRUE;

            // Giving PC its starting gold.
            if (nGiveLevel > 1 && STARTING_GOLD == 0)
            {
                switch (nGiveLevel)
                {
                    case 2:  STARTING_GOLD =    900; break;
                    case 3:  STARTING_GOLD =   2700; break;
                    case 4:  STARTING_GOLD =   5400; break;
                    case 5:  STARTING_GOLD =   9000; break;
                    case 6:  STARTING_GOLD =  13000; break;
                    case 7:  STARTING_GOLD =  19000; break;
                    case 8:  STARTING_GOLD =  27000; break;
                    case 9:  STARTING_GOLD =  36000; break;
                    case 10: STARTING_GOLD =  49000; break;
                    case 11: STARTING_GOLD =  66000; break;
                    case 12: STARTING_GOLD =  88000; break;
                    case 13: STARTING_GOLD = 110000; break;
                    case 14: STARTING_GOLD = 150000; break;
                    case 15: STARTING_GOLD = 200000; break;
                    case 16: STARTING_GOLD = 260000; break;
                    case 17: STARTING_GOLD = 340000; break;
                    case 18: STARTING_GOLD = 440000; break;
                    case 19: STARTING_GOLD = 580000; break;
                    case 20: STARTING_GOLD = 760000; break;
                }
            }

            if (!STARTING_GOLD)
            {
                if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC))
                    STARTING_GOLD = d4(4)*10;
                else if (GetLevelByClass(CLASS_TYPE_BARD, oPC))
                    STARTING_GOLD = d4(4)*10;
                else if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC))
                    STARTING_GOLD = d4(5)*10;
                else if (GetLevelByClass(CLASS_TYPE_DRUID, oPC))
                    STARTING_GOLD = d4(2)*10;
                else if (GetLevelByClass(CLASS_TYPE_FIGHTER, oPC))
                    STARTING_GOLD = d4(6)*10;
                else if (GetLevelByClass(CLASS_TYPE_MONK, oPC))
                    STARTING_GOLD = d4(5);
                else if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC))
                    STARTING_GOLD = d4(6)*10;
                else if (GetLevelByClass(CLASS_TYPE_RANGER, oPC))
                    STARTING_GOLD = d4(6)*10;
                else if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC))
                    STARTING_GOLD = d4(5)*10;
                else if (GetLevelByClass(CLASS_TYPE_SORCERER, oPC))
                    STARTING_GOLD = d4(3)*10;
                else if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC))
                    STARTING_GOLD = d4(3)*10;
                else
                    STARTING_GOLD = d4(4)*10;
            }

            AssignCommand(oPC, TakeGoldFromCreature(GetGold(oPC), oPC, TRUE));

            // hcr3.1
            if (!crr_SubraceHCRstartGold(oPC) ||
                !GetLocalInt(oMod, "SUBRACES"))
                AssignCommand(oPC, DelayCommand(2.0, GiveGoldToCreature(oPC, STARTING_GOLD)));

            if (PLAYER_STRIPS)
            {
                // Removing PC's equipment.
                for (nSlot = 0; nSlot <= NUM_INVENTORY_SLOTS; nSlot++)
                {
                    if (nSlot != INVENTORY_SLOT_CARMOUR &&
                        nSlot != INVENTORY_SLOT_CWEAPON_B &&
                        nSlot != INVENTORY_SLOT_CWEAPON_L &&
                        nSlot != INVENTORY_SLOT_CWEAPON_R &&
                        nSlot != INVENTORY_SLOT_CHEST)
                    {
                        oGear = GetItemInSlot(nSlot, oPC);
                        if (GetIsObjectValid(oGear) && !GetPlotFlag(oGear) &&
                           !GetItemCursedFlag(oGear))
                        {
                            DestroyObject(oGear);
                        }
                    }
                }
            }

            // Removing PC's inventory.
            oGear = GetFirstItemInInventory(oPC);
            while (GetIsObjectValid(oGear) && !GetPlotFlag(oGear) &&
                  !GetItemCursedFlag(oGear))
            {
                DestroyObject(oGear);
                oGear = GetNextItemInInventory(oPC);
            }

            // Greet PC.
            DelayCommand(3.0, SendMessageToPC(oPC, NOGOLD + IntToString(STARTING_GOLD) + " gp."));
            DelayCommand(3.0, SendMessageToPC(oPC, HCRINTRO));
        }
    }

    if (nDM || (sCDK != "" && sCDK == sPDM))
    {
        effect eImmune = EffectImmunity(IMMUNITY_TYPE_TRAP);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmune, oPC);
    }

    if (GetHitDice(oPC) < nGiveLevel && nGiveLevel > 1)
    {
        SendMessageToPC(oPC, NEWLEVEL + IntToString(nGiveLevel));

        int nNewXP = (nGiveLevel * (nGiveLevel - 1)) / 2 * 1000;
        DelayCommand(2.0, SetXP(oPC, nNewXP));

        if (GetLocalInt(oMod, "LEVELTRAINER"))
            DelayCommand(2.1, SetPersistentInt(oPC, "ALLOWLEVEL", 1));
    }

    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) &&
        GetIsObjectValid(GetItemPossessedBy(oPC, "TrackerTool")) == FALSE)
        CreateItemOnObject("trackertool", oPC);

    // Give Paladins their tools that simulate missing abilities
    if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 1 &&
        GetIsObjectValid(GetItemPossessedBy(oPC, "hc_palbadgecour")) == FALSE)
        CreateItemOnObject("paladinsbadgeofc", oPC);

    if (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) &&
        GetIsObjectValid(GetItemPossessedBy(oPC, "hc_paladinsymb")) == FALSE)
        CreateItemOnObject("paladinsholysymb", oPC);

    // Give PC healing ability as per 3e.
    if (!GetIsObjectValid(GetItemPossessedBy(oPC, "HC_HEAL_NODROP")))
        CreateItemOnObject("healability", oPC);


    /***********      HCRHELPER WANDS      *********/


    /*** DM WANDS ***/
    // Give PC DM's a wand version of the HCR helper
    if (sCDK != "" && sCDK == sPDM)
    {
        if (GetIsObjectValid(GetItemPossessedBy(oPC, "HCRHelpwand")) == FALSE)
            CreateItemOnObject("HCRHelpwand", oPC);
    }

    // Give DM's a HCR Helper in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "HCRHelper")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("HCRHelper", oPC);


    /***********      DMHELPER WANDS       *********/


    /***********  PLAYER CHARACTER WANDS   *********/
    // Give PC's an EmoteWand if using the DMHelper set.
    if (!GetIsObjectValid(GetItemPossessedBy(oPC, "EmoteWand")))
        CreateItemOnObject("emotewand", oPC);

    // Set emote wand to plot 5.4.1(bug fix)
    object oItem = GetItemPossessedBy(oPC, "EmoteWand");
    if (GetIsObjectValid(oItem))
        SetPlotFlag(oItem, TRUE);

    /*** DM WANDS ***/
    // Give DM's a FXWand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "WandOfFX")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("WandOfFX", oPC);

    // Give DM's a DMHelper in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "DMsHelper")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("DMsHelper", oPC);

    /*********** NEW DMFI WAND PACKAGE 3.0 *********/

    /*** PLAYER CHARACTER WANDS ***/

    // Give PC's an EmoteWand if using the DMFIHelper set.
    if (!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_emote")))
        CreateItemOnObject("dmfi_pc_emote", oPC);

    // Give PC's a Dicebag if using the DMFIHelper set.
    if (!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_dicebag")))
        CreateItemOnObject("dmfi_pc_dicebag", oPC);

    // Give PC's a Follow wand if using the DMFIHelper set.
    if (!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_follow")))
        CreateItemOnObject("dmfi_pc_follow", oPC);

    /*** DM WANDS ***/
/*
    // Remarked out because the onering does all this and creates less clutter.
    // If you want individual wands instead unremark the wands you want to use.

    // Give DM's a DMFI Wand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_dmw")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("dmfi_dmw", oPC);
    // Give DM's a DMFI FXWand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_fx")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("dmfi_fx", oPC);
    // Give DM's a DMFI SoundWand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_sound")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == GetPersistentString(oMod, "PLAYERDM"))))
        CreateItemOnObject("dmfi_sound", oPC);
    // Give DM's a DMFI AfflictWand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_afflict")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("dmfi_afflict", oPC);
    // Give DM's a DMFI XPWand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_xp")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("dmfi_xp", oPC);
    // Give DM's a DMFI MusicWand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_music")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("dmfi_music", oPC);
    // Give DM's a DMFI NPC Control wand in inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_faction")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("dmfi_faction", oPC);
*/

    // Give DM's a the one ring to be able to use all wand function in thier inventory
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_onering")) == FALSE &&
       (nDM || (sCDK != "" && sCDK == sPDM)))
        CreateItemOnObject("dmfi_onering", oPC);

    /*********** END OF WAND PACKAGES *********/

    // Give new PC's some food.
    if (GetLocalInt(oMod, "FOODSYSTEM") ||
        GetLocalInt(oMod, "HUNGERSYSTEM"))
    {
        if (!GetXP(oPC) && !nDM)
            CreateItemOnObject("FoodRation", oPC);
    }

    // Give new PC's a bedroll for the rest system.
    if (GetLocalInt(oMod, "BEDROLLSYSTEM"))
    {
        if (!GetXP(oPC) && !nDM)
        {
            if (GetIsObjectValid(GetItemPossessedBy(oPC, "bedroll")) == FALSE)
                CreateItemOnObject("bedroll", oPC);
        }
    }

    // Start of playerstate checking

    // return if a dm.
    if (nDM)
        return;

    // persistence code
    int nPersist = GetLocalInt(oMod, "PERSIST");
    // hcr3 only do if deathsystem is on.
    if (GetLocalInt(oMod, "DEATHSYSTEM"))
    {
        if (nPersist && !GetLocalInt(oPC, "ENTERED"))
            HCLoadDB(sID, oPC);

        int nCurState = GPS(oPC);
        //SendMessageToPC(oPC, "STATE: " + IntToString(nCurState));
        int nHP = GetPersistentInt(oMod, "LastHP" + sID);
        int nCHP = GetCurrentHitPoints(oPC);
        // changed to limbo and not bleedsystem.
        if (GetLocalInt(oMod, "LIMBO"))
        {
            if (nCurState == PWS_PLAYER_STATE_RESURRECTED ||
                nCurState == PWS_PLAYER_STATE_RESTRUE ||
                nCurState == PWS_PLAYER_STATE_RAISEDEAD)
            {
                HCR_RemoveEffects(oPC);

                if (GetItemPossessedBy(oPC, "fuguerobe") != OBJECT_INVALID)
                    DestroyObject(GetItemPossessedBy(oPC, "fuguerobe"));

                if (nCurState != PWS_PLAYER_STATE_RESTRUE &&
                    GetLocalInt(oMod, "REZPENALTY"))
                    DelayCommand(1.0, hcRezPenalty(oPC));

                // if not entered then move to graveyard.
                if (!GetLocalInt(oPC, "ENTERED"))
                {
                    location lGrave = GetLocation(GetObjectByTag("GraveYard"));
                    DelayCommand(2.5, AssignCommand(oPC, JumpToLocation(lGrave)));
                }

                if (nCurState == PWS_PLAYER_STATE_RAISEDEAD)
                {
                    if (GetLocalInt(oMod, "REZPENALTY") && GetIsPC(oPC))
                        DelayCommand(2.0, TakeHPs(oPC));
                }

                SPS(oPC, PWS_PLAYER_STATE_ALIVE);
                location lWhere = GetPersistentLocation(oMod, "RESLOC" + sID);
                DelayCommand(4.0,AssignCommand(oPC, JumpToLocation(lWhere)));
                //DeletePersistentLocation(oMod, "RESLOC" + sID);
            }
            else if (GetItemPossessedBy(oPC, "fuguerobe") != OBJECT_INVALID &&
                     nCurState == PWS_PLAYER_STATE_ALIVE)
            {
                DestroyObject(GetItemPossessedBy(oPC, "fuguerobe"));

                if (GetLocalInt(oMod, "DEATHOVERREBOOT"))
                    DelayCommand(4.5, CheckFugue(oPC));
            }
            else if (nCurState == PWS_PLAYER_STATE_ALIVE)
            {
                if (nHP && nCHP > nHP)
                {
                    // Fix for fugue check.
                    SetLocalInt(oPC, "LOGINDEATH", 1);
                    effect eDam = EffectDamage(nCHP - nHP);
                    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
                }
            }
            else
            {
                if (GetLocalInt(oMod, "DEATHOVERREBOOT"))
                {
                    effect eDam = ExtraordinaryEffect(EffectParalyze());
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, 8.0);
                    DelayCommand(8.5, CheckFugue(oPC));
                }
            }
        }
        else if (GetLocalInt(oMod, "DEATHSYSTEM"))
        {
            SetLocalInt(oPC, "LOGINDEATH", 1);
            effect eDeath = EffectDeath(FALSE, FALSE);
            if (nCurState == PWS_PLAYER_STATE_DEAD)
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
        }
    }

    InitPCHTFLevels(oPC);

    if (GetXP(oPC) == 0)
        SetXP(oPC, 1);

    // Send a login message to all players if one exists.
    string sMsg = GetLocalString(oMod, "LOGINMESSAGE");
    if (sMsg != "NONE" && sMsg != "")
        SendMessageToPC(oPC, sMsg);

    // check to see if the pc has entered before. if so run strip talents.
    // changed to local no longer need persistent var.
    if (GetLocalInt(oMod, "DECONENTER"))
    {
        if (GetLocalInt(oPC, "ENTERED"))
            ExecuteScript("st_strip_talents", oPC);
    }

    // check to see if PHB Rcial Movement is enabled and apply if so
    if (GetLocalInt(oMod, "RACIALMOVEMENT"))
       HC_SetRacialMovementRate(oPC);

    //added for Old Man Whistlers loot notification - cfx
    if(GetLocalInt(oMod, "LOOTNOTIFY"))
    DelayCommand(2.0, PLNSLoadNotificationOnClientEnter(GetEnteringObject()));

    //added by CFX for the reworked DOA Gold Encumberance for use with HCR v3.03b
    {
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;

    /* ===== PC pseudo-heartbeat ==================
    DOA Gold Encumbrance System 1.0
    Den, Project Lead at Carpe Terra (http://carpeterra.com) */
    AssignCommand(oPC, ExecuteScript("gbl_pc_heartbeat", oPC));
    }


    DelayCommand(10.0, SetLocalInt(oPC, "ENTERED", TRUE));
    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
