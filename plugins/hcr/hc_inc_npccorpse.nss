//  ----------------------------------------------------------------------------
//  hc_inc_npccorpse
//  ----------------------------------------------------------------------------
/*
    Library contain functions relating to the HCR NPC Corpse system.

    This system used the body of the NPC in conjunction with an invisible object
    to give the appearance of an interactive and revivable NPC corpse.  It also
    provide various options to control what items will drop, the manner in which
    they will drop and how clean up will be handled.


    What Items Will Drop
    --------------------

    - for Custom Creatures:
      a. items flagged as droppable will drop unless they are "no-drop" items

    - for Standard BioWare Creatures:
      a. items flagged as droppable will drop unless they are "no-drop" items
      b. items not flagged as droppable may drop if:
         1. *_DROP_IF_BIOWARE is set to TRUE
         2. *_SKIP_PLOT is set to FALSE or they are not flagged as plot
         3. *_SKIP_STOLEN is set to FALSE or they are not flagged as stolen
         4. they are not creature items
         5. they are not "no-drop"


    How Items Will Drop
    -------------------

    - droppable "visible" items are those that effect appearance on dynamic
      models, namely those in the *_CHEST, *_HEAD, *_LEFTHAND and *_RIGHTHAND
      inventory slots. They drop according to the appropriate *_DROP_MODE_FOR_*
      setting. Note if using *_DROP_MODE_NONE will prevent otherwise droppable
      items from dropping.

    - all other droppable items will be moved to the corpse


    How Clean Up Is Handled
    -----------------------

    - clean up can be set to occur on a timed basis, when the corpse is empty, a
      combination of these or not at all. Using *_CLEANUP_MODE_NEVER is only
      recommended if an area cleaner is also being used.

    - the default mode for the module can be overriden for individual creatures.
      This is achieved by setting a local int on the creature using the name
      assigned to the HC_VAR_NPCCORPSE_CLEANUP constant and one of the values
      assigned to the HC_NPCCORPSE_CLEANUP_MODE_* constants.


    Hints and Tips
    --------------

    - if using AI that enables NPCs revivals consider using *_DROP_MODE_NONE or
      *_DROP_MODE_COPY as these will avoid leaving the NPC without arms/armor.

    - avoid using *_DROP_MODE_DROP with *_CLEANUP_MODE_EMPTY as this requires
      ALL dropped items to be picked up BEFORE OnClose can activate clean up.

    - to avoid important items being destroyed as a result of *_TIMED or *_COMBO
      clean up modes use the creature override to impose the *_EMPTY mode.

*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 26 July 2004 - Sunjammer
    - rewritten

    Credits:
    - Keron Blackfeld
    - Ragnar69
    - Lorinton
    - Jamos
*/
//  ----------------------------------------------------------------------------
#include "hc_inc_transfer"


//  ----------------------------------------------------------------------------
//  CONSTANTS: CONFIGURATION
//  ----------------------------------------------------------------------------

// Sets an override for standard Bioware creatures (NW_*) to enable them to drop
// items not flagged as droppable (such as weapons).  Creature items and no-drop
// items will still not drop.
const int HC_NPCCORPSE_DROP_IF_BIOWARE      = FALSE;

// Sets limitations on the above override.
//  *_BW_PLOT:   items will not drop if they are flagged as plot
//  *_BW_STOLEN: items will not drop if they are flagged as stolen
const int HC_NPCCORPSE_SKIP_IF_BW_PLOT     = FALSE;
const int HC_NPCCORPSE_SKIP_IF_BW_STOLEN   = FALSE;

// Modes available controlling how an NPC's "visible" items are handled.
//  *_NONE: item remains on NPC even if droppable
//  *_MOVE: item removed from NPC, appears in corpse
//  *_COPY: item remains on NPC, a copy appears in corpse
//  *_DROP: item removed from NPC, a copy appears on ground nearby (hands only)
const int HC_NPCCORPSE_DROP_MODE_NONE   = 1;
const int HC_NPCCORPSE_DROP_MODE_MOVE   = 2;
const int HC_NPCCORPSE_DROP_MODE_COPY   = 3;
const int HC_NPCCORPSE_DROP_MODE_DROP   = 4;

// Sets the mode controlling how an NPC's "visible" items are handled. Use a
// HC_NPCCORPSE_DROP_MODE_* constant from the list above for each *_MODE_*.
const int HC_NPCCORPSE_DROP_MODE_FOR_CHEST  = HC_NPCCORPSE_DROP_MODE_COPY;
const int HC_NPCCORPSE_DROP_MODE_FOR_HANDS  = HC_NPCCORPSE_DROP_MODE_COPY;
const int HC_NPCCORPSE_DROP_MODE_FOR_HEAD   = HC_NPCCORPSE_DROP_MODE_COPY;

// Modes available for the controling the clean up process.
//  *_NEVER: clean up is never initiated
//  *_EMPTY: clean up is initiated when corpse is emptied (checked OnClose)
//  *_TIMED: clean up is intiated after HC_NPCCORPSE_CLEANUP_DELAY minutes
//  *_COMBO: clean up is intiated after the earlier of EMPTY or TIMED
const int HC_NPCCORPSE_CLEANUP_MODE_NEVER   = 1;
const int HC_NPCCORPSE_CLEANUP_MODE_EMPTY   = 2;
const int HC_NPCCORPSE_CLEANUP_MODE_TIMED   = 3;
const int HC_NPCCORPSE_CLEANUP_MODE_COMBO   = 4;

// Sets the mode and time (in minutes) controling the clean up process. Use a
// HC_NPCCORPSE_CLEANUP_MODE_* constant from the list above for *_MODE.
const int HC_NPCCORPSE_CLEANUP_MODE     = 3;
const int HC_NPCCORPSE_CLEANUP_DELAY    = 5;

// Controls if a blood pool should form under the NPC.
const int HC_NPCCORPSE_USE_BLOOD            = TRUE;

// Sets an override for animals to enable them to persist until skinned.  This
// is mainly for use with EMPTY or COMBO modes for cleanup.  Cleanup is handled
// in the appropriate OnActivateItem script.
const int HC_NPCCORPSE_USE_SKINNING         = TRUE;


//  ----------------------------------------------------------------------------
//  CONSTANTS: SYSTEM
//  ----------------------------------------------------------------------------

// blueprints for the placeable elements
const string HC_RES_NPCCORPSE_CORPSE        = "invis_corpse_obj";
const string HC_RES_NPCCORPSE_BLOOD         = "plc_bloodstain";

// tags for the placeable elements
const string HC_TAG_NPCCORPSE_CORPSE        = "HC_NPCCorpse_Corpse";

// name of variables to register elements with corpse
const string HC_VAR_NPCCORPSE_BLOOD         = "HC_NPCCorpse_Blood";
const string HC_VAR_NPCCORPSE_BODY          = "HC_NPCCorpse_Body";

// name of variables for various system flags
//  *_CHECKED:  identifies checked items to prevents duplication on transfer
//  *_CLEANUP:  creature override for clean up mode
//  *_COPIED:   identifies coppied items for clean up on distrubed
//  *_DROPPED:  identifies dropped items (e.g. weapons) for clean up
//  *_PRESERVE: prevents deletion of coprse elements (on body, dual purpose)
//  *_PREVENT:  prevents creation of corpse elements (on body)
const string HC_VAR_NPCCORPSE_CHECKED       = HC_VAR_TRANSFER_CHECKED;
const string HC_VAR_NPCCORPSE_CLEANUP       = "HC_NPCCorpse_CleanUp";
const string HC_VAR_NPCCORPSE_COPIED        = "HC_NPCCorpse_Copied";
const string HC_VAR_NPCCORPSE_DROPPED       = "HC_NPCCorpse_Dropped";
const string HC_VAR_NPCCORPSE_PRESERVE      = "HC_NPCCorpse_Preserve";
const string HC_VAR_NPCCORPSE_PREVENT       = "HC_NPCCorpse_Prevent";
//const string HC_VAR_NPCCORPSE_PRESERVE      = "Dead";           // legacy
//const string HC_VAR_NPCCORPSE_PREVENT       = "NORMALCORPSE";   // legacy


//  ----------------------------------------------------------------------------
//  PROTOTYPES
//  ----------------------------------------------------------------------------

// Creates the corpse components for the NPC, drops items as appropriate and
// handles initial clean up/scheduling.
//  - oBody:        a dead NPC/creature
void HC_NPCCorpse_CreateCorpse(object oBody);

// Destroys the corpse components.  Will not destroy the NPC if it has been
// revived between corpse creation and clean up.
//  - oCorpse:      a invisible corpse object
void HC_NPCCorpse_CleanUp(object oCorpse);

// Returns the clean up mode associated with the NPC.
//  - oBody:        a dead NPC/creature
int HC_NPCCoprse_GetCleanUpMode(object oBody);

// Returns the drop mode for the "visible" item in nSlot.
//  - nSlot:        one of the visible INVENTORY_SLOT_* constants
int HC_NPCCorpse_GetDropMode(int nSlot);

// Returns TRUE if oCreature can bleed.
int HC_NPCCorpse_GetIsBleeder(object oCreature);

// Returns TRUE if oItem is "droppable" according to system settings.
int HC_NPCCorpse_GetIsDroppable(object oItem);

// Returns TRUE if oCorpse is empty AND there are no associated dropped items
// remaining on the ground.
//  - oCorpse:      an invisible corpse object
int HC_NPCCorpse_GetIsEmpty(object oCorpse);

// Returns TRUE if any of the *_DROP_MODE_FOR_* settings are *_DROP_MODE_COPY.
int HC_NPCCorpse_GetIsUsingCopyMode();

// Generates a location beneath the NPC's body.
//  - oBody:        a dead NPC/creature
location HC_NPCCorpse_GetLocationForCorpse(object oBody);

// Generates a location appropriate for an item that has dropped to the ground
// from an NPC's hand.
//  - oBody:        a dead NPC/creature
//  - nSlot:        one of the INVENTORY_SLOT_*HAND constants
location HC_NPCCorpse_GetLocationForDropped(object oBody, int nSlot);

// Destroys any associated dropped items remaining on the ground.
//  - oCorpse:      an invisible corpse object
//  - nSlot:        one of the visible INVENTORY_SLOT_* constants
void HC_NPCCorpse_DestroyDropped(object oCorpse, int nSlot);

// Destroys all items that remain equiped on oBody.
void HC_NPCCorpse_DestroyEquipment(object oBody);

// Destroys all items in oContainers inventory.
void HC_NPCCorpse_DestroyInventory(object oContainer);

// Transfers all "droppable" equipped items oBody to oCorpse except "visible"
// items, namely those in the *_CHEST, *_HEAD, *_LEFTHAND and *_RIGHTHAND
// inventory slots.
//  - oBody:        a dead NPC/creature
//  - oCorpse:      an invisible corpse object
void HC_NPCCorpse_DropEquipment(object oBody, object oCorpse);

// Transfers all "droppable" inventory items from oBody to oCorpse.
//  - oBody:        a dead NPC/creature
//  - oCorpse:      an invisible corpse object
void HC_NPCCorpse_DropInventory(object oBody, object oCorpse);

// Transfers or drops all "visible", "droppable" equipted items form oBody to
// oCorpse.  In other words those items in the *_CHEST, *_HEAD, *_LEFTHAND and
// *_RIGHTHAND inventory slots.
//  - oBody:        a dead NPC/creature
//  - oCorpse:      an invisible corpse object
//  - nSlot:        one of the visible INVENTORY_SLOT_* constants
void HC_NPCCorpse_DropVisible(object oBody, object oCorpse, int nSlot);


//  ----------------------------------------------------------------------------
//  FUNCTIONS
//  ----------------------------------------------------------------------------

void HC_NPCCorpse_CreateCorpse(object oBody)
{
    // pre-emptive abort: the body has a normal corpse override flag or or has
    // an ATS, a CNR or a legacy no-corpse tag
    string sTag = GetTag(oBody);
    if(GetLocalInt(oBody, HC_VAR_NPCCORPSE_PREVENT)
    || HC_GetIsInString(sTag, "NC_")
    || HC_GetIsInString(sTag, "ATS_")
    || HC_GetIsInString(sTag, "cnra"))
    {
        return;
    }

    // -------------------------------------------------------------------------
    // Part 1: Create the Components
    // -------------------------------------------------------------------------

    // prevent the body from decaying
    AssignCommand(oBody, SetIsDestroyable(FALSE));

    // create the lootable container
    location lCorpse = HC_NPCCorpse_GetLocationForCorpse(oBody);
    object oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, HC_RES_NPCCORPSE_CORPSE, lCorpse, FALSE, HC_TAG_NPCCORPSE_CORPSE);

    // register the body with the corpse
    SetLocalObject(oCorpse, HC_VAR_NPCCORPSE_BODY, oBody);

    // create a blood stain for effect if required/appropriate
    if(HC_NPCCORPSE_USE_BLOOD && HC_NPCCorpse_GetIsBleeder(oBody))
    {
        // create the blood and register it with the corpse
        object oBlood = CreateObject(OBJECT_TYPE_PLACEABLE, HC_RES_NPCCORPSE_BLOOD, GetLocation(oBody));
        SetLocalObject(oCorpse, HC_VAR_NPCCORPSE_BLOOD, oBlood);
    }

    // -------------------------------------------------------------------------
    // Part 2: Drop or Transfer Items
    // -------------------------------------------------------------------------

    // drop the gold
    HC_Transfer_MoveGold(oBody, oCorpse);

    // drop visible items, i.e. those affecting appearance on dynamic models
    HC_NPCCorpse_DropVisible(oBody, oCorpse, INVENTORY_SLOT_HEAD);
    HC_NPCCorpse_DropVisible(oBody, oCorpse, INVENTORY_SLOT_CHEST);
    HC_NPCCorpse_DropVisible(oBody, oCorpse, INVENTORY_SLOT_LEFTHAND);
    HC_NPCCorpse_DropVisible(oBody, oCorpse, INVENTORY_SLOT_RIGHTHAND);

    // drop residual equipment
    HC_NPCCorpse_DropEquipment(oBody, oCorpse);

    // drop all other items
    HC_NPCCorpse_DropInventory(oBody, oCorpse);

    // -------------------------------------------------------------------------
    // Part 3: Arrange Clean Up
    // -------------------------------------------------------------------------

    int nMode = HC_NPCCoprse_GetCleanUpMode(oBody);

    // NOTE: given the duality of applciation all three of these must be checked

    if(nMode == HC_NPCCORPSE_CLEANUP_MODE_COMBO
    || nMode == HC_NPCCORPSE_CLEANUP_MODE_EMPTY)
    {
        // clean up if empty, otherwise clean up via OnClose
        if(HC_NPCCorpse_GetIsEmpty(oCorpse))
        {
            HC_NPCCorpse_CleanUp(oCorpse);
        }
    }

    if(nMode == HC_NPCCORPSE_CLEANUP_MODE_COMBO
    || nMode == HC_NPCCORPSE_CLEANUP_MODE_TIMED)
    {
        // schedule clean up after delay (converted to seconds)
        float fDelay = IntToFloat(HC_NPCCORPSE_CLEANUP_DELAY * 60);
        DelayCommand(fDelay, HC_NPCCorpse_CleanUp(oCorpse));
    }

    if(nMode == HC_NPCCORPSE_CLEANUP_MODE_NEVER
    || nMode == HC_NPCCORPSE_CLEANUP_MODE_TIMED)
    {
        // prevent premature clean up via OnClose
        SetLocalInt(oBody, HC_VAR_NPCCORPSE_PRESERVE, TRUE);
    }
}


void HC_NPCCorpse_CleanUp(object oCorpse)
{
    // get the elements registered with the corpse
    object oBody = GetLocalObject(oCorpse, HC_VAR_NPCCORPSE_BODY);
    object oBlood = GetLocalObject(oCorpse, HC_VAR_NPCCORPSE_BLOOD);

    // clean up blood
    DestroyObject(oBlood);

    // destroy items to prevent "remains", clean up corpse
    HC_NPCCorpse_DestroyInventory(oCorpse);
    DestroyObject(oCorpse);

    // destroy items dropped and not yet picked up (hands only)
    if(HC_NPCCORPSE_DROP_MODE_FOR_HANDS == HC_NPCCORPSE_DROP_MODE_DROP)
    {
        HC_NPCCorpse_DestroyDropped(oCorpse, INVENTORY_SLOT_LEFTHAND);
        HC_NPCCorpse_DestroyDropped(oCorpse, INVENTORY_SLOT_RIGHTHAND);
    }

    // ONLY clean up Body and retained weapons IF STILL DEAD
    if(GetIsDead(oBody))
    {
        // destroy items to prevent "remains"
        HC_NPCCorpse_DestroyEquipment(oBody);
        HC_NPCCorpse_DestroyInventory(oBody);

        // clean up body: no need to use DestroyObject as SetIsDestroyable will
        // cause it to fade after a short delay
        AssignCommand(oBody, SetIsDestroyable(TRUE));
    }
}


int HC_NPCCoprse_GetCleanUpMode(object oBody)
{
    // assume default mode will apply
    int nRet = HC_NPCCORPSE_CLEANUP_MODE;

    // override if it is an animal and using skinning so it can be skinned
    if(HC_NPCCORPSE_USE_SKINNING
    && GetRacialType(oBody) == RACIAL_TYPE_ANIMAL)
    {
        nRet = HC_NPCCORPSE_CLEANUP_MODE_NEVER;
    }

    // override if body is flagged or tagged to leave a permanent corpse
    if(GetLocalInt(oBody, HC_VAR_NPCCORPSE_PRESERVE)
    || HC_GetIsInString(GetTag(oBody), HC_VAR_NPCCORPSE_PRESERVE))
    {
        nRet = HC_NPCCORPSE_CLEANUP_MODE_NEVER;
    }

    // check body for creature override
    int nOverride = GetLocalInt(oBody, HC_VAR_NPCCORPSE_CLEANUP);
    if(nOverride) return nOverride;

    // return mode
    return nRet;
}


int HC_NPCCorpse_GetDropMode(int nSlot)
{
    int nRet;

    // parse the inventory slot for the corresponding mode
    switch(nSlot)
    {
        case INVENTORY_SLOT_CHEST:
            nRet = HC_NPCCORPSE_DROP_MODE_FOR_CHEST;
            break;

        case INVENTORY_SLOT_HEAD:
            nRet = HC_NPCCORPSE_DROP_MODE_FOR_HEAD;
            break;

        case INVENTORY_SLOT_LEFTHAND:
        case INVENTORY_SLOT_RIGHTHAND:
            nRet = HC_NPCCORPSE_DROP_MODE_FOR_HANDS;
            break;
    }

    // return mode
    return nRet;
}


int HC_NPCCorpse_GetIsBleeder(object oCreature)
{
    int nRace = GetRacialType(oCreature);

    // constructs, elementals, oozes and the undead don't bleed
    if(nRace == RACIAL_TYPE_CONSTRUCT
    || nRace == RACIAL_TYPE_ELEMENTAL
    || nRace == RACIAL_TYPE_OOZE
    || nRace == RACIAL_TYPE_UNDEAD)
    {
        // creature doesn't bleed
        return FALSE;
    }

    // creature bleeds
    return TRUE;
}


int HC_NPCCorpse_GetIsDroppable(object oItem)
{
    string sTag;

    if(GetDroppableFlag(oItem) == FALSE)
    {
        // if not droppable check override ...
        if(HC_NPCCORPSE_DROP_IF_BIOWARE)
        {
            // ... and check it is a Bioware creature
            sTag = GetTag(GetItemPossessor(oItem));
            if(HC_GetIsInString(sTag, "nw_")
            || HC_GetIsInString(sTag, "x0_")
            || HC_GetIsInString(sTag, "x2_"))
            {
                // skipping plot items?
                if(HC_NPCCORPSE_SKIP_IF_BW_PLOT && GetPlotFlag(oItem))
                {
                    return FALSE;
                }

                // skipping stolen items?
                if(HC_NPCCORPSE_SKIP_IF_BW_STOLEN && GetStolenFlag(oItem))
                {
                    return FALSE;
                }

                // always skip creature/henchmen weapons
                // NOTE: not relevant to custom creature as creator has ability
                // to choose if such items are droppable
                sTag = GetTag(oItem);
                if(HC_GetIsInString(sTag, "_it_cre")
                || HC_GetIsInString(sTag, "_hen_")
                || HC_GetIsInString(sTag, "_wdrow")
                || HC_GetIsInString(sTag, "_wduer")
                || HC_GetIsInString(sTag, "_it_rakstaff")
                || HC_GetIsInString(sTag, "_manti_spikes")
                || HC_GetIsInString(sTag, "_it_frzdrowbld"))
                {
                    return FALSE;
                }
            }
        }
        else
        {
            // not droppable and override doesn't apply
            return FALSE;
        }
    }

    // always skip no-drop items
    if(HC_GetIsItemNoDrop(oItem))
    {
        return FALSE;
    }

    // passed all checks
    return TRUE;
}


int HC_NPCCorpse_GetIsEmpty(object oCorpse)
{
    // any items in corpse?
    if(GetIsObjectValid(GetFirstItemInInventory(oCorpse)))
    {
        return FALSE;
    }

    // if using DROP mode, any items on ground?
    int nMode = HC_NPCCorpse_GetDropMode(INVENTORY_SLOT_LEFTHAND);

    if(nMode == HC_NPCCORPSE_DROP_MODE_DROP)
    {
        string sItem;
        object oItem, oOwner;

         // if object from LEFT hand is valid it must have a possessor
        sItem = HC_VAR_NPCCORPSE_DROPPED + IntToString(INVENTORY_SLOT_LEFTHAND);
        oItem = GetLocalObject(oCorpse, sItem);

        if(GetIsObjectValid(oItem))
        {
            if(GetIsObjectValid(GetItemPossessor(oItem)) == FALSE)
            {
                return FALSE;
            }
        }

        // if object from RIGHT hand is valid it must have a possessor
        sItem = HC_VAR_NPCCORPSE_DROPPED + IntToString(INVENTORY_SLOT_RIGHTHAND);
        oItem = GetLocalObject(oCorpse, sItem);

        if(GetIsObjectValid(oItem))
        {
            if(GetIsObjectValid(GetItemPossessor(oItem)) == FALSE)
            {
                return FALSE;
            }
        }
    }

    // no items found
    return TRUE;
}


int HC_NPCCorpse_GetIsUsingCopyMode()
{
    // check all modes and return TRUE if any are *_COPY
    if(HC_NPCCORPSE_DROP_MODE_FOR_CHEST == HC_NPCCORPSE_DROP_MODE_COPY
    || HC_NPCCORPSE_DROP_MODE_FOR_HANDS == HC_NPCCORPSE_DROP_MODE_COPY
    || HC_NPCCORPSE_DROP_MODE_FOR_HEAD == HC_NPCCORPSE_DROP_MODE_COPY)
    {
        return TRUE;
    }
    return FALSE;
}


location HC_NPCCorpse_GetLocationForCorpse(object oBody)
{
    vector vBody = GetPosition(oBody);

    // get co-ordingates of a point just below vBody
    float fZ = vBody.z - 0.1;

    // return the location
    return Location(GetArea(oBody), Vector(vBody.x, vBody.y, fZ), 0.0);
}


location HC_NPCCorpse_GetLocationForDropped(object oBody, int nSlot)
{
    vector vBody = GetPosition(oBody);

    // get the offsets appropriate to the hand the item is falling from
    float fFacing = (nSlot == INVENTORY_SLOT_LEFTHAND) ? 45.0f : -45.0f;
    float fWeapon = (nSlot == INVENTORY_SLOT_LEFTHAND) ? -20.0f : 20.0f;

    // add a random element to facings and direction, values are arbitray
    fFacing += GetFacing(oBody) + IntToFloat(d20());
    fWeapon += GetFacing(oBody) - IntToFloat(d20(2));
    float fDistance = 0.5f + (IntToFloat(d10())/10);

    // get co-ordinates of a point fDistance meters away at fFacing degrees
    float fX = vBody.x + cos(fFacing) * fDistance;
    float fY = vBody.y + sin(fFacing) * fDistance;

    // return the location
    return Location(GetArea(oBody), Vector(fX, fY, vBody.z), fWeapon);
}


void HC_NPCCorpse_DropEquipment(object oBody, object oCorpse)
{
    location lCorpse = GetLocation(oCorpse);

    int n;
    for(n = 0; n < HC_NUM_PC_INVENTORY_SLOTS; n++)
    {
        object oItem = GetItemInSlot(n, oBody);

        // if valid and droppable and as yet unchecked
        if(GetIsObjectValid(oItem)
        && HC_NPCCorpse_GetIsDroppable(oItem)
        && GetLocalInt(oItem, HC_VAR_NPCCORPSE_CHECKED) == FALSE)
        {
            // copy item to corpse, destroy original
            CopyObject(oItem, lCorpse, oCorpse);
            DestroyObject(oItem);
        }
    }
}


void HC_NPCCorpse_DropVisible(object oBody, object oCorpse, int nSlot)
{
    object oCopy;
    object oItem = GetItemInSlot(nSlot, oBody);

    // pre-emptive aborts: object is not valid or is not droppable
    if(GetIsObjectValid(oItem) == FALSE
    || HC_NPCCorpse_GetIsDroppable(oItem) == FALSE)
    {
        return;
    }

    // flag as checked to avoid duplication
    SetLocalInt(oItem, HC_VAR_NPCCORPSE_CHECKED, TRUE);

    // parse drop mode
    int nMode = HC_NPCCorpse_GetDropMode(nSlot);
    if(nMode == HC_NPCCORPSE_DROP_MODE_MOVE)
    {
        // copy item to corpse, destroy original
        oCopy = CopyObject(oItem, GetLocation(oCorpse), oCorpse);
        DestroyObject(oItem);
    }
    else if(nMode == HC_NPCCORPSE_DROP_MODE_COPY)
    {
        // copy item to corpse, register as copy, keep original
        oCopy = CopyObject(oItem, GetLocation(oCorpse), oCorpse);
        SetLocalInt(oCopy, HC_VAR_NPCCORPSE_COPIED, nSlot);
    }
    else if(nMode == HC_NPCCORPSE_DROP_MODE_DROP)
    {
        // copy item to ground, register with corpse, destroy original
        oCopy = CopyObject(oItem, HC_NPCCorpse_GetLocationForDropped(oBody, nSlot));
        SetLocalObject(oCorpse, HC_VAR_NPCCORPSE_DROPPED + IntToString(nSlot), oCopy);
        DestroyObject(oItem);
    }
}


void HC_NPCCorpse_DropInventory(object oBody, object oCorpse)
{
    location lCorpse = GetLocation(oCorpse);

    // check each item
    object oItem = GetFirstItemInInventory(oBody);
    while(GetIsObjectValid(oItem))
    {
        // if droppable and as yet unchecked ...
        if(HC_NPCCorpse_GetIsDroppable(oItem)
        && GetLocalInt(oItem, HC_VAR_NPCCORPSE_CHECKED) == FALSE)
        {
            // copy item to corpse, destroy original
            CopyObject(oItem, lCorpse, oCorpse);
            DestroyObject(oItem);
        }

        oItem = GetNextItemInInventory(oBody);
    }
}


void HC_NPCCorpse_DestroyDropped(object oCorpse, int nSlot)
{
    // get item and owner (local object released when corpse destroyed)
    object oItem = GetLocalObject(oCorpse, HC_VAR_NPCCORPSE_DROPPED + IntToString(nSlot));
    object oOwner = GetItemPossessor(oItem);

    // if valid or held by someone valid
    if(GetIsObjectValid(oOwner) == FALSE)
    {
        DestroyObject(oItem);
    }
}


void HC_NPCCorpse_DestroyEquipment(object oBody)
{
    int n;
    for(n = 0; n < HC_NUM_PC_INVENTORY_SLOTS; n++)
    {
        // destroy any items left on the body
        object oItem = GetItemInSlot(n, oBody);
        if(GetIsObjectValid(oItem))
        {
            DestroyObject(oItem);
        }
    }
}


void HC_NPCCorpse_DestroyInventory(object oContainer)
{
    // destroy each item in turn
    object oItem = GetFirstItemInInventory(oContainer);
    while(GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oContainer);
    }
}

//void main(){}

