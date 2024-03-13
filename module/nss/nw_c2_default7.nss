//  ----------------------------------------------------------------------------
//  nw_c2_default7
//  ----------------------------------------------------------------------------
/*
    OnDeath Creature Event Script

    Added respawn code if you want a monster to respawn put RESPAWN in its TAG
    name. If you want it to respawn at a certain point add a waypoint with same
    TAG name as monster. If you want to use random spawn points add waypoints with
    same TAG name as monster + 1 to 10. Respawn timer can be changed if desired.

    If you want monsters to respawn with different delays use multiple scripts.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 09 Oct 2004 - Sunjammer
    - quick and dirty patch for 1.64 (removed 0xp hack)
    - note this file is currently being rewitten for 3.02

    Credits:
    - Preston Watamaniuk
*/
//  ----------------------------------------------------------------------------
#include "hc_inc"
#include "hc_inc_exp"
#include "hc_inc_fatigue"
#include "crr_subrace_hc_i"
#include "x0_i0_spawncond"
#include "x2_inc_compon"


//  ----------------------------------------------------------------------------
//  PROTOTYPES
//  ----------------------------------------------------------------------------

void HC_ClearInventory();
void HC_RespawnObject(int nType, string sResRef, location lLoc, float fFacing, string sNewTag);
void HC_DoCreatureRespawn();


//  ----------------------------------------------------------------------------
//  FUNCTIONS
//  ----------------------------------------------------------------------------

void HC_ClearInventory()
{
    // Destroy all equipped slots.
    object oItem;
    int nSlot;
    for (nSlot = 0; nSlot < NUM_INVENTORY_SLOTS; nSlot++)
    {
        oItem = GetItemInSlot(nSlot);
        if (GetIsObjectValid(oItem) && !GetDroppableFlag(oItem))
            DestroyObject(oItem);
    }

    // Destroy all inventory items.
    oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        if (!GetDroppableFlag(oItem))
            DestroyObject(oItem);

        oItem = GetNextItemInInventory();
    }
}


void HC_RespawnObject(int nType, string sResRef, location lLoc, float fFacing, string sNewTag)
{
  object oRespawn = CreateObject(nType, sResRef, lLoc);
  object oNew = CopyObject(oRespawn, lLoc, OBJECT_INVALID, sNewTag);
  DestroyObject(oRespawn);
  AssignCommand(oNew, ActionDoCommand(SetFacing(fFacing)));
  SetLocalInt(GetModule(), "ONCE", 1);
}


void HC_DoCreatureRespawn()
{
  location lLoc;
  float fFacing;
  int nType = GetObjectType(OBJECT_SELF);
  string sRef = GetResRef(OBJECT_SELF);
  string sTag = GetTag(OBJECT_SELF);
  string sRan = IntToString(d10(1));
  object oWaypoint = GetWaypointByTag(sTag + sRan);
  if (GetIsObjectValid(oWaypoint))
    {
     lLoc = GetLocation(oWaypoint);
     fFacing = GetFacing(oWaypoint);
    }
  else
    {
     oWaypoint = GetWaypointByTag(GetTag(OBJECT_SELF));
     if (GetIsObjectValid(oWaypoint))
       {
        lLoc = GetLocation(oWaypoint);
        fFacing = GetFacing(oWaypoint);
       }
     else
       {
        lLoc = GetLocalLocation(OBJECT_SELF, "spawn");
        if (GetIsObjectValid(GetAreaFromLocation(lLoc)))
          { DeleteLocalInt(OBJECT_SELF, "spawn"); }
        else
          { lLoc = GetLocation(OBJECT_SELF); }
        fFacing = GetFacing(OBJECT_SELF);
       }
    }

  // The following is a random time to respawn, to use uncomment line below and comment the second line.
  //float fDelay = IntToFloat(d100(3) + 60);
  float fDelay = 160.0;// 300.0 = 5 minute delay. Adjust as desired.
  AssignCommand(oMod, DelayCommand(fDelay, HC_RespawnObject(nType, sRef, lLoc, fFacing, sTag)));
}


//  ----------------------------------------------------------------------------
//  MAIN
//  ----------------------------------------------------------------------------

void main()
{
    // Fix for NWN bug w/ NPC's that are not dead calling this script.
    if (GetLocalInt(OBJECT_SELF, "DEAD") == TRUE)
    {
        DeleteLocalInt(OBJECT_SELF, "DEAD");
        return;
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "DEAD", TRUE);
    }

    object oKiller = GetLastKiller();

    // pre-emptive abort: creature killed itself
    if (oKiller == OBJECT_SELF)
        return;

    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);

    // If we're a good/neutral commoner, adjust the killer's alignment evil.
    if (nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    // Call to allies to let them know we're dead.
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    // Shout Attack my target, only works with the On Spawn In setup.
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: The On Death user-defined event does not trigger reliably and
    // should probably be removed.
    if (GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    // Create player craftable items.
    craft_drop_items(oKiller);

    // Respawn this creature if it is tagged for it.
    if (FindSubString(GetTag(OBJECT_SELF), "RESPAWN") > -1)
    {
        HC_DoCreatureRespawn();
    }

    // Create NPC corpse or clear out inventory.
    if (GetLocalInt(oMod, "NPCCORPSE"))
    {
        ExecuteScript("hc_npccorpse", OBJECT_SELF);
    }
    else
    {
        HC_ClearInventory();
    }

    //  ------------------------------------------------------------------------
    //  Begin XP Gen Mod
    //  ------------------------------------------------------------------------

    // Declare major variables for XP Gen.
    object oPC;
    object oHench;
    int bIsDm;
    int nAdd;
    int nPCHD;
    int nHenHD;
    int nMonsterXP;
    int nPartyMembers;
    int nPartyLevelSum;
    int nHenchmen  = 0;
    int nHighLevel = 0;

    // If XP System is turned off. Dont generate any XP.
    if (!GetLocalInt(oMod, "HCREXP")) { return; }

    // Dont give XP if killer was a DM.
    if (GetIsDM(oKiller)) { return; }

    // Dont give XP for Summoned Creatures, Animal Companions or Familiars.
    object oMaster = GetMaster();
    if (GetIsObjectValid(oMaster))
    {
        object oAni = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oMaster);
        if (oAni == OBJECT_SELF) { return; }
        object oFam = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster);
        if (oFam == OBJECT_SELF) { return; }
        object oSum = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oMaster);
        if (oSum == OBJECT_SELF) { return; }
    }

    // If tag has "_NXP", then dont give XP.
    if (FindSubString(GetTag(OBJECT_SELF), "_NXP") > -1)
    {
        SendMessageToPC(oKiller, "You gain no experience from this kill!");
        return;
    }

    // Search through all PC faction members.
    oPC = GetFirstFactionMember(oKiller);
    while (GetIsObjectValid(oPC))
    {
        // Advance the party count.
        nPartyMembers++;

        // If not a DM. Check for Henchmen.
        bIsDm = GetIsDM(oPC);
        if (!bIsDm)
        {
            oHench = GetHenchman(oPC);
            while (GetIsObjectValid(oHench))
            {
                nHenchmen++;
                nPartyMembers++;
                nHenHD = GetHitDice(oHench);
                nPartyLevelSum += nHenHD;
                if (nHenHD > nHighLevel)
                { nHighLevel = nHenHD; }
                oHench = GetHenchman(oHench);
            }
        }

        // Adjust levels if they are more than 4 apart.
        nAdd = 0;
        nPCHD = GetHitDice(oPC);
        if (nPCHD > nHighLevel)
        { nHighLevel = nPCHD; }
        else if ((nHighLevel - nPCHD) > 4)
        { nAdd = nHighLevel; }

        if (bIsDm)
        { nPartyMembers--; }
        else if (nAdd == 0)
        { nPartyLevelSum += nPCHD; }
        else
        { nPartyLevelSum += nAdd; }

        oPC = GetNextFactionMember(oKiller);
    }

    // If no PC's was found, exit out.
    if (nPartyMembers == 0) { return; }

    // Compute XP based on average party level and monster CR using the XP table.
    // Note: Bonus XP is added AFTER the XP is computed from the table.
    int nBaseExp = GetLocalInt(oMod, "BASEXP");
    float fCR    = GetChallengeRating(OBJECT_SELF);
    float fPLAvg = (IntToFloat(nPartyLevelSum)/IntToFloat(nPartyMembers));
    int nLevel   = FloatToInt(fPLAvg);
    nMonsterXP   = UseXPTable(nBaseExp, fCR, nLevel);
    nMonsterXP  += GetLocalInt(oMod, "BONUSXP");
    int nCharXP  = (nMonsterXP/nPartyMembers);

    // If CR is less than 1, multiply XP by CR.
    if (fCR < 1.0)
    { nCharXP = FloatToInt(nCharXP * fCR); }

    // HCR - Fix for henchmen getting only 3/4 xp for kills rest goes to party.
    if (nHenchmen > 0)
    {
        int nHenchmenbonus = ((nCharXP*nHenchmen)/8) / (nPartyMembers-nHenchmen);
        nCharXP = nCharXP + nHenchmenbonus;
    }

    // Loop through the faction again, this time to give out the adjusted XP.
    object oMyArea = GetArea(OBJECT_SELF);
    int bLvlTrain  = GetLocalInt(oMod, "LEVELTRAINER");
    int bSubraces  = GetLocalInt(oMod, "SUBRACES");
    int nHenchmenbonus;
    int nSCharXP;
    int nCR;

    oPC = GetFirstFactionMember(oKiller);
    while (GetIsObjectValid(oPC))
    {
        if (!GetIsDM(oPC) && oMyArea == GetArea(oPC))
        {
            // Discourages grouping of higher levels with lower levels to get XP.
            nLevel      = GetHitDice(oPC);
            nMonsterXP  = UseXPTable(nBaseExp, fCR, nLevel);
            nMonsterXP += GetLocalInt(oMod, "BONUSXP");
            nSCharXP    = nMonsterXP / nPartyMembers;

            // If CR is less than 1, multiply XP by CR.
            if (fCR < 1.0)
            { nSCharXP = FloatToInt(nSCharXP * fCR); }

            // Fix for henchmen getting only 3/4 xp for kills rest goes to party.
            if (nHenchmen > 0)
            {
                nHenchmenbonus = ((nSCharXP*nHenchmen)/8)/(nPartyMembers-nHenchmen);
                nSCharXP = (nSCharXP + nHenchmenbonus);
            }

            // Party XP should never be more than Single XP.
            if (nCharXP > nSCharXP && nPartyMembers > 1)
            { nCharXP = nSCharXP; }

            // Should never get XP if 7+ CR levels above CR.
            nCR = 0;
            if (fCR < 1.0)
            { nCR = 1; }
            else
            { nCR = FloatToInt(fCR); }

            if ((GetHitDice(oPC) - nCR) >= (7 + nCR))
            { nCharXP = 0; }

            int nCurLvl = GetHitDice(oPC);
            string sID  = GetName(oPC) + GetPCPlayerName(oPC);
            int nExpPen = GetLocalInt(oMod, "REZPEN" + sID);
            int nNxtLvl = ((((nCurLvl + 1) * nCurLvl) / 2 * 1000) - 1);

            // Adjust experience by ECL if using the CRR subrace system.
            if (bSubraces)
            { nCharXP = crr_SubraceHCR_XPbyECL(oPC, nCharXP); }

            int nXP = GetXP(oPC);
            if (!bLvlTrain)
            {
                if (nCharXP > 0)
                { GiveXPToCreature(oPC, nCharXP); }
                else
                {
                    if (nPartyMembers == 1)
                    { SendMessageToPC(oPC, "You learn nothing from this kill, you are too far advanced in level"); }
                    else
                    { SendMessageToPC(oPC, "You learn nothing from this kill, your party is too far advanced in level"); }
                }
            }
            else if (nExpPen)
            {
                if (nCharXP > nExpPen)
                {
                    SendMessageToPC(oPC, "You have paid off your exp penalty.");
                    DeleteLocalInt(oMod, "REZPEN" + sID);
                }
                else
                {
                    nExpPen = (nExpPen - nCharXP);
                    SendMessageToPC(oPC, "Remaining exp penalty is: " + IntToString(nExpPen));
                    SetLocalInt(oMod, "REZPEN" + sID, nExpPen);
                }
            }
            else if ((nXP + nCharXP) > nNxtLvl)
            {
                if (nNxtLvl <= GetXP(oPC))
                { SendMessageToPC(oPC, "You learn nothing from this kill, perhaps you should seek out training."); }
                else
                {
                SetXP(oPC, nNxtLvl);
                SendMessageToPC(oPC, "You learn little from this kill, perhaps you should seek out training.");
                }
            }
            else
            {
                if (nCharXP > 0)
                { GiveXPToCreature(oPC, nCharXP); }
                else
                {
                    if (nPartyMembers == 1)
                    { SendMessageToPC(oPC, "You learn nothing from this kill, you are too far advanced in level"); }
                    else
                    { SendMessageToPC(oPC, "You learn nothing from this kill, your party is too far advanced in level"); }
                }
            }
        }
        oPC = GetNextFactionMember(oKiller);
    }
}

