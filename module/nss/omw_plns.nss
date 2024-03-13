/*
Party Loot Notification System 1.04
by OldManWhistler

It started off as a combo of loot notification systems by InterSlayer
and Johnny Mutton but then grew into its own beast.

Find the latest version of this script at:
http:nwvault.ign.com/Files/scripts/data/1059455704861.shtml

My Portfolio:
http:nwvault.ign.com/portfolios/data/1054937958.shtml


****************************************************************************
FEATURES
****************************************************************************

- 2 script, 3 items
- Does not display notification for DMs, NPCs or DM controlled NPCs.
- Does not display notification when PC is logging into the module.
- Does not display notification for dead players.
- Does not display notification for destroyed items (ie: used potions, scrolls)
- Displays identified items by name (configurable) and unidentified items generically.
- Displays (magical) items (configurable)
- Displays armor type.
- Displays stack size.
- Displays identified name in DM/log.
- Displays GP value in DM/log.
- Displays plot flag in DM/log.
- Display can be toggled off on a per user basis.
- Can be configured to only display to party members who can see the looter.
- Differentiates between stores, players, and containers. (configurable)
- Uses LogMessage so it can be easily reconfigured to change how output
  messages are displayed.


****************************************************************************
NOTES
****************************************************************************

The notification on/off toggles only turns off *NOTIFICATION* for that player.
Messages will still be sent to the rest of the party/DMs/etc. The toggle
allows DMs/players to "opt-out" of the loot notification if they are not interested
in those messages. It does NOT prevent the messages from being sent.

It will only display the message for sold items if the store does not already
have an infinite amount of that item. When the stores have an infinite amount
of that item, the "sold" item is automatically destroyed.

This script does not support PickPocket in any way, shape or form. If you
want to configure the script so that loot notification is only sent for
party members who can see each other, then change the PLNS_GOT_ITEM and
PLNS_LOST_ITEM globals to LOG_PARTY_PERC_SERVER instead of LOG_PARTY_SERVER.
This will allow stealthed characters to "take" items without notifying the party.

This script does not display notification for gold pieces (since gold does
not fire the OnAcquiredItem / OnUnacquiredItem scripts).

The loot notification toggle items are in Custom5 in the item palette.


****************************************************************************
SAMPLE LOGS
****************************************************************************

[Tue Jul 29 00:57:59] Mord Arna has sold Necklace of Prayer Beads (magical) to Boy. /Necklace of Prayer Beads/14032gp/
[Tue Jul 29 00:58:06] Mord Arna has sold Lesser Spell Breach (magical) to Boy. /Lesser Spell Breach/1008gp/
[Tue Jul 29 00:58:09] Mord Arna has sold Potion of Clarity (9) (magical) to Boy. /Potion of Clarity/1080gp/
[Tue Jul 29 00:58:14] Mord Arna has sold Potion of Bull's Strength (3) (magical) to Boy. /Potion of Bull's Strength/360gp/
[Tue Jul 29 00:58:16] Mord Arna has sold Potion of Cat's Grace (5) (magical) to Boy. /Potion of Cat's Grace/600gp/
[Tue Jul 29 00:58:26] Mord Arna has bought Potion of Cat's Grace (5) (magical) from Boy. /Potion of Cat's Grace/600gp/
[Tue Jul 29 00:58:32] Mord Arna has bought Potion of Barkskin (magical) from Boy. /Potion of Barkskin/80gp/
[Tue Jul 29 00:58:35] Mord Arna has bought Potion of Antidote (magical) from Boy. /Potion of Antidote/300gp/
[Tue Jul 29 00:58:42] Mord Arna has just lost Remove Curse (magical). /Remove Curse/540gp/
[Tue Jul 29 00:58:50] Mord Arna has just lost Resurrection (2) (magical). /Resurrection/6554gp/
[Tue Jul 29 00:59:27] Mord Arna has taken Gold Ring out of Chest. /Gold Ring/499gp/
[Tue Jul 29 00:59:31] Mord Arna has taken The Leadership of Neverwinter out of Chest. /The Leadership of Neverwinter/7gp/
[Tue Jul 29 00:59:42] Mord Arna has taken Acid Fog (3) (magical) out of Chest. /Acid Fog/7131gp/
[Tue Jul 29 00:59:52] Mord Arna has put Healer's Kit +1 (3) in Chest. /Healer's Kit +1/153gp/
[Tue Jul 29 00:59:55] Mord Arna has put Healer's Kit +1 (2) in Chest. /Healer's Kit +1/102gp/
[Tue Jul 29 01:00:05] Mord Arna has put Healer's Kit +1 (9) in Chest. /Healer's Kit +1/459gp/
[Tue Jul 29 01:00:08] Mord Arna has taken Healer's Kit +1 (2) out of Chest. /Healer's Kit +1/102gp/
[Tue Jul 29 01:00:09] Mord Arna has taken Healer's Kit +1 (3) out of Chest. /Healer's Kit +1/153gp/
[Tue Jul 29 01:00:11] Mord Arna has taken Healer's Kit +1 (9) out of Chest. /Healer's Kit +1/459gp/
[Tue Jul 29 01:00:22] Mord Arna has taken Potion of Cure Critical Wounds (magical) out of Crate. /Potion of Cure Critical Wounds/280gp/


****************************************************************************
INSTALLATION
****************************************************************************

// omw_plns_X_XX.erf contains the base scripts and the items.
// plns_acttag_X_XX.erf is only needed if you use an activate item system
// where you execute the item's tag as a script
// (ie: you use X0_ONITEMACTV as your OnActivateItem script).

// #1: Modify OnAcquiredItem module event script (create if it does not exist).
// Add the following line to somewhere at the top of the script
#include "omw_plns"
// Add the following line to somewhere in the void main function.
RunLootNotificationOnAcquire();

// #2: Modify OnUnAcquiredItem module event script (create if it does not exist).
// Add the following line to somewhere at the top of the script
#include "omw_plns"
// Add the following line to somewhere in the void main function.
RunLootNotificationOnUnAcquire();

// #3: Modify OnClientEnter module event script (create if it does not exist).
// Add the following line to somewhere at the top of the script
#include "omw_plns"
// Add the following line to somewhere in the void main function.
DelayCommand(6.0, PLNSLoadNotificationOnClientEnter(GetEnteringObject()));

// #4: Modify OnActivateItem module event script. You can skip this step if you use an activate item script
// that executes a script with the same name as the item tag and you have imported plns_acttag_X_XX.erf
// Add the following line to somewhere at the top of the script
#include "omw_plns"
// Add the following line to somewhere in the void main function.
    if (PLNSToggleLootNotificationOnActivateItem(GetItemActivator(), GetItemActivated())) return;


****************************************************************************
CHANGELOG
****************************************************************************
1.00 -> 1.01
- Added toggle for showing who/what the item was given to/taken from.
- Added toggle for showing identified item names or generic item names.
- Added toggle for showing the "magical" flag.
- Fixed a bug with items pickedup/dropped to the ground not showing properly.

1.01 -> 1.02
- Updated to LogMessage 1.05
- Took the "ground" stuff out completely because it is often misleading.
- Changed the code to search for store name to look for nearest creature or
object instead of just the nearest creature. If you are getting misleading
messages, then you should check that the nearest object to the store is
the object that acts as the store front.
- Added an additional notification log for plot items.
- Added an item that can toggle notification on/off on a per player/DM basis.

1.02 -> 1.03
- Fixed a bug in the install instructions.
- Removed the message on the DM Channel when a player changed their loot notification.
- If you are already happily using 1.02 there is no need to upgrade to 1.03.

1.03 -> 1.04
- Added more clarification about the "notification toggle" in the documentation.
- Added more clarification about "Recompiling the module" when you modify the omw_plns script.
- Changed the "running PLNS" message so it displays whenever notification is toggled.
- Added a 0.25 sec delay before the loot notification runs, this is to prevent notification for destroyed objects under laggy conditions.
- Added support scripts for people who use an OnActiveItem system that executes the item tag as a script name.
- Updated to LogMessage 1.06
- This new version of LogMessage lets you send the notification message to
  everyone in the party EXCEPT the player who just looted the item. To use this
  new feature change your PLNS_GOT_ITEM and PLNS_LOST_ITEM configuration variables
  to use LOG_PARTY_ONLY or LOG_PARTY_PERC_ONLY instead of LOG_PARTY_20.
  ie:
     int PLNS_GOT_ITEM  = LOG_PARTY_ONLY | LOG_DM_40 | LOG_TIME_SERVER_LOG;
     int PLNS_LOST_ITEM = LOG_PARTY_ONLY | LOG_DM_40 | LOG_TIME_SERVER_LOG;
*/

// ****************************************************************************
// INCLUDES
// ****************************************************************************
#include "logmessage"

// ****************************************************************************
// CONFIGURATION - Rebuild your module after modifying this section.
// ****************************************************************************
// Always recompile your module after modifying omw_plns because it is an include file.
// #1: Select "Build" from the toolset menu and then choose "Build Module".
// #2: Click the "Advanced Controls" box to bring up the advanced options.
// #3: Make sure that the only boxes that are selected are "Compile" and "Scripts".
// #4: Click the "Build" button.
// #5: Remember to always make sure you are using the options you want to use when running "Build Module"!

// If true, it will try to determine if the item was bought/sold to a store,
// taken/put into a container, or given/taken from another player.
const int PLNS_SHOW_SOURCE_DESTINATION = TRUE;

// If true, identified items will show the items name instead of a generic
// name. Note: unidentified items will always show the generic name.
const int PLNS_NAME_IDED_ITEM = TRUE;

// If true, the keyword (magical) will be shown for magical items.
const int PLNS_MAGICAL = TRUE;

// Redefine these variables to change how loot notification is displayed.
// Open the LogMessage script to see the various different possible values
// for the LOG_* constants. By using LogMessage you have easy and complete
// control for how messages are displayed to the end users
int PLNS_GOT_ITEM  = LOG_PARTY_20 | LOG_DM_40 | LOG_TIME_SERVER_LOG;
int PLNS_LOST_ITEM = LOG_PARTY_20 | LOG_DM_40 | LOG_TIME_SERVER_LOG;
int PLNS_PLOT_ITEM  = LOG_DM_40 | LOG_TIME_SERVER_LOG;
int PLNS_DEBUG_INFO = LOG_DISABLED;

// ****************************************************************************
// CONSTANTS - Do not modify.
// ****************************************************************************
const string PLNS_TOGGLE_ITEM = "plns_toggle";
const string PLNS_NOTIFICATION_STATE = "PLNSNotificationState";
string PLNS_VERSION = "Party Loot Notification System 1.04 (with "+LOG_MESSAGE_VERSION+")";

// ****************************************************************************
// DECLARATIONS
// ****************************************************************************

// This function should be run in your module OnAcquire event.
void RunLootNotificationOnAcquire();
// This function should be run in your module OnUnAcquire event.
void RunLootNotificationOnUnAcquire();
// This function should be run in your module OnClientEnter event with a 6.0 second delay.
void PLNSLoadNotificationOnClientEnter(object oPC);
// This function should be run in your module OnActivateItem event.
int PLNSToggleLootNotificationOnActivateItem (object oPC, object oItem);
// This function returns TRUE if loot notification should be run.
int PLNSCheckRunLootNotification(object oItem, object oPC);
// This is the main function that sends out the message.
void PLNSLootNotification(object oItem, object oPC, int iLogType, string sAction, string sDest, int iStack);
// Returns a generic item description.
string PLNSGetItemDescription(object oItem);
// Returns TRUE if oHolder is in a valid area.
int PLNSGetIsInValidArea(object oHolder);
// Returns TRUE if oItem has any magic properties in the list.
int PLNSGetHasMagicProperty(object oItem);

// ****************************************************************************
// FUNCTIONS
// ****************************************************************************

int PLNSCheckRunLootNotification(object oItem, object oPC)
{
    if(
        (oItem == OBJECT_INVALID) || // don't run on invalid items
        (oPC == OBJECT_INVALID) || // don't run on invalid possessors
        (GetIsDead(oPC)) || // don't run on dead PCs
        (!GetIsPC(oPC)) || // don't run on NPCs
        (GetIsDM(oPC)) || // don't run on DMs
        (GetIsDM(GetMaster(oPC))) || // don't run on DMs possessing creatures
        (PLNSGetIsInValidArea(oPC) == FALSE) // don't run on invalid areas (ie: player logs in)
      )
      return FALSE;
    else
        return TRUE;
}

// This function should only be used in your module OnItemAcquired script.
void RunLootNotificationOnAcquire()
{
    object oItem = GetModuleItemAcquired();
    object oPC = GetItemPossessor(oItem);

    // Should we run loot notification?
    if (!PLNSCheckRunLootNotification(oItem, oPC)) return;

    // Info for Acquired items.
    object oPossessor = GetModuleItemAcquiredFrom();
    int oPossessorType = GetObjectType(oPossessor);
    string sAction = " picked up ";
    string sDestSource = ".";

    if (PLNS_SHOW_SOURCE_DESTINATION)
    {
        // Sold the item.
        if (oPossessorType == OBJECT_TYPE_STORE)
        {
            sAction = " bought ";
            sDestSource = " from "+GetName(GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE, oPossessor))+".";
        }
        // Gave the item to a creature.
        if (
            (oPossessorType == OBJECT_TYPE_CREATURE) &&
            (!GetIsDM(oPossessor)) &
            (!GetIsDM(GetMaster(oPossessor)))
            )
        {
            sAction = " taken ";
            sDestSource = " from "+GetName(oPossessor)+".";
        }
        // Put the item in a placeable.
        if (oPossessorType == OBJECT_TYPE_PLACEABLE)
        {
            sAction = " taken ";
            sDestSource = " out of "+GetName(oPossessor)+".";
        }
        // Dropped the item.
        if (!GetIsObjectValid(oPossessor))
        {
            sAction = " picked up ";
        }
    }
    DelayCommand(0.25, PLNSLootNotification(oItem, oPC, PLNS_GOT_ITEM, sAction, sDestSource, GetModuleItemAcquiredStackSize()));
    return;
}

// This function should only be used in your module OnItemUnAcquired script.
void RunLootNotificationOnUnAcquire()
{
    object oItem = GetModuleItemLost();
    object oPC = GetModuleItemLostBy();

    // Should we run loot notification?
    if (!PLNSCheckRunLootNotification(oItem, oPC)) return;

    // Info for UnAcquired items.
    object oPossessor = GetItemPossessor(oItem);
    int oPossessorType = GetObjectType(oPossessor);
    string sAction = " just lost ";
    string sDestSource = ".";

    if (PLNS_SHOW_SOURCE_DESTINATION)
    {
        // Sold the item.
        if (oPossessorType == OBJECT_TYPE_STORE)
        {
            sAction = " sold ";
            sDestSource = " to "+GetName(GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE, oPossessor))+".";
        }
        // Gave the item to a creature.
        if (
            (oPossessorType == OBJECT_TYPE_CREATURE) &&
            (!GetIsDM(oPossessor)) &
            (!GetIsDM(GetMaster(oPossessor)))
            )
        {
            sAction = " given ";
            sDestSource = " to "+GetName(oPossessor)+".";
        }
        // Put the item in a placeable.
        if (oPossessorType == OBJECT_TYPE_PLACEABLE)
        {
            sAction = " put ";
            sDestSource = " in "+GetName(oPossessor)+".";
        }
        // Dropped the item.
        if (!GetIsObjectValid(oPossessor))
        {
            sAction = " dropped ";
        }
    }
    DelayCommand(0.25, PLNSLootNotification(oItem, oPC, PLNS_LOST_ITEM, sAction, sDestSource, GetItemStackSize(oItem)));
    return;
}

// This function displays the loot notification message.
void PLNSLootNotification(object oItem, object oPC, int iLogType, string sAction, string sDest, int iStack)
{
    // filter out items that are lost because they are destroyed.
    if(!GetIsObjectValid(oItem)) return;

    string sName = GetName(oItem);
    string iTag = GetTag(oItem);
    string pcName = GetName(oPC);
    string sItemName = GetName (oItem);
    string sStack = "";
    // If its a stacked item, add the stack size to the name
    if (iStack > 1) sStack = " (" + IntToString(iStack) + ")";
    // Add checks here for items you don't want to run notification on.

    // Don't tag the HCR death amulet or the death gold bag.
    if ((iTag == "deathamulet") || (iTag == "bagofgold"))
        return;

    // Don't tag ATS items.
    if((GetSubString(iTag,0,3) == "ats") || (GetSubString(iTag,0,3) == "ATS"))
        return;


    // Find out if the item is magical.
    string magic = "";
    if(PLNSGetHasMagicProperty(oItem)) magic = " (magical)";

    // Additional info that will be displayed on the DM channel and in the log file.
    string sPlot = "/";
    if (GetPlotFlag(oItem)) sPlot = " PLOT";
    int iGP = (GetGoldPieceValue(oItem) / GetItemStackSize(oItem)) * iStack;
    string sGP = "/"+IntToString(iGP)+"gp";

    // Handle identified items.
    if(PLNS_NAME_IDED_ITEM && GetIdentified(oItem))
    {
        LogMessage (iLogType, oPC, pcName+" has"+sAction+sName+sStack+magic+sDest, "/"+GetName(oItem)+sGP+sPlot, PLNS_NOTIFICATION_STATE, 0);
        if (GetPlotFlag(oItem)) LogMessage (PLNS_PLOT_ITEM, oPC, "[PLOT] "+pcName+" has"+sAction+sName+sStack+magic+sDest, "/"+GetName(oItem)+sGP+sPlot, PLNS_NOTIFICATION_STATE, 2);
    }
    else
    {
        // Handle unidentified items.
        sName = PLNSGetItemDescription(oItem);

        if(sName == "")
        {
            LogMessage (LOG_DM_ALL | LOG_TIME_SERVER_LOG, oPC, "ERROR: Loot Notification(omw_plns): GetItemDescription returned nothing for ItemType: "+IntToString(GetBaseItemType(oItem))+" and name: "+GetName(oItem));
            return;
        }
        LogMessage (iLogType, oPC, pcName+" has"+sAction+sName+sStack+magic+sDest, "/"+GetName(oItem)+sGP+sPlot, PLNS_NOTIFICATION_STATE, 0);
        if (GetPlotFlag(oItem)) LogMessage (PLNS_PLOT_ITEM, oPC, "[PLOT] "+pcName+" has"+sAction+sName+sStack+magic+sDest, "/"+GetName(oItem)+sGP+sPlot, PLNS_NOTIFICATION_STATE, 2);
    }
    return;
}

string PLNSGetItemDescription(object oItem)
{
    // Replaced InterSlayers original loot table with Johnny Mutton's loot table

    int iType = GetBaseItemType(oItem);

    switch (iType)
    {
        case BASE_ITEM_AMULET:
            return "Amulet";
        // Armor is a special case because there are different types
        case BASE_ITEM_ARMOR:
            // From GetArmorType by Eyrdan
            switch (GetGoldPieceValue(oItem)) {
                case    1: return("Clothing");
                case    5: return("Padded Armor");
                case   10: return("Leather Armor");
                case   15: return("Studded Leather Armor");
                case  100: return("Scalemail Armor/Chain Shirt"); // Chain Shirt/Scale Mail
                case  150: return("Chainmail Armor/Breastplate"); // Chainmail/Breastplate
                case  200: return("Splintmail Armor/Banded Mail"); // Splint Mail/Banded Mail
                case  600: return("Half-plate Armor"); // Half-Plate
                case 1500: return("Full Plate Armor"); // Full Plate
                default  : return("Suit of Armor");
            }
            return "Suit of Armor";
        case BASE_ITEM_ARROW:
            return "Stack of Arrows";
        case BASE_ITEM_BASTARDSWORD:
            return "Bastard Sword";
        case BASE_ITEM_BATTLEAXE:
            return "Battle Axe";
        case BASE_ITEM_BELT:
            return "Belt";
        case BASE_ITEM_BOLT:
            return "Stack of Bolts";
        case BASE_ITEM_BOOK:
            return "Book";
        case BASE_ITEM_BOOTS:
            return "Pair of Boots";
        case BASE_ITEM_BRACER:
            return "Bracer";
        case BASE_ITEM_BULLET:
            return "Bag of Bullets";
        case BASE_ITEM_CBLUDGWEAPON:
            return "Bludgeoning Weapon";
        case BASE_ITEM_CLOAK:
            return "Cloak";
        case BASE_ITEM_CLUB:
            return "Club";
        case BASE_ITEM_CPIERCWEAPON:
            return "Piecing Weapon";
        case BASE_ITEM_CREATUREITEM:
            return "Creature Item";
        case BASE_ITEM_CSLASHWEAPON:
            return "Slashing Weapon";
        case BASE_ITEM_CSLSHPRCWEAP:
            return "Unknown";
        case BASE_ITEM_DAGGER:
            return "Dagger";
        case BASE_ITEM_DART:
            return "Set of Darts";
        case BASE_ITEM_DIREMACE:
            return "Dire Mace";
        case BASE_ITEM_DOUBLEAXE:
            return "Double Axe";
        case BASE_ITEM_GEM:
            return "Gem";
        case BASE_ITEM_GLOVES:
            return "Gloves";
        case BASE_ITEM_GOLD:
            return "Gold";
        case BASE_ITEM_GREATAXE:
            return "Great Axe";
        case BASE_ITEM_GREATSWORD:
            return "Greatsword";
        case BASE_ITEM_HALBERD:
            return "Halberd";
        case BASE_ITEM_HANDAXE:
            return "Hand Axe";
        case BASE_ITEM_HEALERSKIT:
            return "Healers Kit";
        case BASE_ITEM_HEAVYCROSSBOW:
            return "Heavy Crossbow";
        case BASE_ITEM_HEAVYFLAIL:
            return "Heavy Flail";
        case BASE_ITEM_HELMET:
            return "Helmet";
        case BASE_ITEM_INVALID:
            return "Invalid Item";
        case BASE_ITEM_KAMA:
            return "Kama";
        case BASE_ITEM_KATANA:
            return "Katana";
        case BASE_ITEM_KEY:
            return "Key";
        case BASE_ITEM_KUKRI:
            return "Kukri";
        case BASE_ITEM_LARGEBOX:
            return "Large Box";
        case BASE_ITEM_LARGESHIELD:
            return "Large Shield";
        case BASE_ITEM_LIGHTCROSSBOW:
            return "Light Crossbow";
        case BASE_ITEM_LIGHTFLAIL:
            return "Light Flail";
        case BASE_ITEM_LIGHTHAMMER:
            return "Light Hammer";
        case BASE_ITEM_LIGHTMACE:
            return "Light Mace";
        case BASE_ITEM_LONGBOW:
            return "Longbow";
        case BASE_ITEM_LONGSWORD:
            return "Longsword";
        case BASE_ITEM_MAGICROD:
            return "Magic Rod";
        case BASE_ITEM_MAGICSTAFF:
            return "Magic Staff";
        case BASE_ITEM_MAGICWAND:
            return "Magic Wand";
        case BASE_ITEM_MISCLARGE:
            return "Large Item";
        case BASE_ITEM_MISCMEDIUM:
            return "Medium Item";
        case BASE_ITEM_MISCSMALL:
            return "Small Item";
        case BASE_ITEM_MISCTHIN:
            return "Thin Item";
        case BASE_ITEM_MORNINGSTAR:
            return "Morning Star";
        case BASE_ITEM_POTIONS:
            return "Potion";
        case BASE_ITEM_QUARTERSTAFF:
            return "Quarterstaff";
        case BASE_ITEM_RAPIER:
            return "Rapier";
        case BASE_ITEM_RING:
            return "Ring";
        case BASE_ITEM_SCIMITAR:
            return "Scimitar";
        case BASE_ITEM_SCROLL:
            return "Magic Scroll";
        case BASE_ITEM_SCYTHE:
            return "Scythe";
        case BASE_ITEM_SHORTBOW:
            return "Shortbow";
        case BASE_ITEM_SHORTSPEAR:
            return "Shortspear";
        case BASE_ITEM_SHORTSWORD:
            return "Shortsword";
        case BASE_ITEM_SHURIKEN:
            return "Shuriken";
        case BASE_ITEM_SICKLE:
            return "Sickle";
        case BASE_ITEM_SLING:
            return "Sling";
        case BASE_ITEM_SMALLSHIELD:
            return "Small Shield";
        case BASE_ITEM_SPELLSCROLL:
            return "Spell";
        case BASE_ITEM_THIEVESTOOLS:
            return "Set of Thieve's Tools";
        case BASE_ITEM_THROWINGAXE:
            return "Throwing Axe";
        case BASE_ITEM_TORCH:
            return "Torch";
        case BASE_ITEM_TOWERSHIELD:
            return "Tower Shield";
        case BASE_ITEM_TRAPKIT:
            return "Trap Kit";
        case BASE_ITEM_TWOBLADEDSWORD:
            return "Two Bladed Sword";
        case BASE_ITEM_WARHAMMER:
            return "War Hammer";
        default:
            return "";
    }
    return "";
}

// This function returns true if oHolder is in a valid area.
int PLNSGetIsInValidArea(object oHolder)
{
    object oArea = GetArea(oHolder);
     if(GetIsObjectValid(oArea))
    {
        return TRUE;
    }
     return FALSE;
}

// This function returns true if oItem has any magical properties.
int PLNSGetHasMagicProperty (object oItem)
{
    // Note: This function purposefully does not cover negative item properties.
    if (PLNS_MAGICAL)
    {
    // If you feel your this code is taking too much time to execute then
    // cut things out.
    return GetItemHasItemProperty(oItem, ITEM_PROPERTY_ABILITY_BONUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_BONUS_FEAT) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_CAST_SPELL) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_REDUCTION) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_RESISTANCE) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DARKVISION) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_FREEDOM_OF_MOVEMENT) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_HASTE) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_HOLY_AVENGER) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMPROVED_EVASION) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_KEEN) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_MIND_BLANK) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_ON_HIT_PROPERTIES) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_POISON) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION_VAMPIRIC) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_SAVING_THROW_BONUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_SKILL_BONUS) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_SPELL_RESISTANCE) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_TRUE_SEEING) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_TURN_RESISTANCE) ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_UNLIMITED_AMMUNITION);
    } else {
        return FALSE;
    }
}

void PLNSLoadNotificationOnClientEnter(object oPC)
{
    // This function should be run in your OnClientEnter script with a slight
    // delay so that the player has acquired all of their items.

    object oItem = GetItemPossessedBy(oPC, PLNS_TOGGLE_ITEM+"0");
    if (GetIsObjectValid(oItem))
    {
        LogMessage(LOG_PC, oPC, GetName(oPC)+" has loot notification turned on.", "[PLNS] Loot notification set to state 0 for "+GetName(oPC)+" "+GetTag(oItem));
        SetLocalInt(oPC, PLNS_NOTIFICATION_STATE, 0);
        return;
    }
    oItem = GetItemPossessedBy(oPC, PLNS_TOGGLE_ITEM+"1");
    if (GetIsObjectValid(oItem))
    {
        LogMessage(LOG_PC, oPC, GetName(oPC)+" has loot notification turned off.", "[PLNS] Loot notification set to state 1 for "+GetName(oPC)+" "+GetTag(oItem));
        SetLocalInt(oPC, PLNS_NOTIFICATION_STATE, 1);
        return;
    }
    oItem = GetItemPossessedBy(oPC, PLNS_TOGGLE_ITEM+"2");
    if (GetIsObjectValid(oItem))
    {
        LogMessage(LOG_PC, oPC, GetName(oPC)+" has loot notification turned on for plot items only.", "[PLNS] Loot notification set to state 2 for "+GetName(oPC)+" "+GetTag(oItem));
        SetLocalInt(oPC, PLNS_NOTIFICATION_STATE, 2);
        return;
    }
    // The player doesn't have the item at all.
    oItem = CreateItemOnObject(PLNS_TOGGLE_ITEM+"0", oPC);
    LogMessage(LOG_PC, oPC, GetName(oPC)+" has loot notification turned on.", "[PLNS] Loot notification set to state 0 for "+GetName(oPC)+" "+GetTag(oItem));
    SetLocalInt(oPC, PLNS_NOTIFICATION_STATE, 0);
    return;
}


int PLNSToggleLootNotificationOnActivateItem (object oPC, object oItem)
{
    // Check to see if this is the correct item.
    if (GetStringLeft(GetTag(oItem), GetStringLength(PLNS_TOGGLE_ITEM)) != PLNS_TOGGLE_ITEM) return FALSE;
    int iState = StringToInt(GetStringRight(GetTag(oItem), 1));
    int iNextState;

    LogMessage(LOG_PC, oPC, "Running "+PLNS_VERSION);

    // Only three possible options for DMs, two possible options for players.
    if (GetIsDM(oPC) || GetIsDMPossessed(oPC))
    {
        iNextState = (iState + 1) % 3;
    }
    else iNextState = (iState + 1) % 2;

    // Create a new notification toggle and destroy the old one.
    object oNewItem = CreateItemOnObject(PLNS_TOGGLE_ITEM+IntToString(iNextState), oPC);
    SetPlotFlag(oItem, FALSE);
    DestroyObject(oItem);

    // Inform them about the notification switch
    switch (iNextState)
    {
        case 0:
            LogMessage(LOG_PC, oPC, GetName(oPC)+" has loot notification turned on.", "[PLNS] Loot notification set to state 0 for "+GetName(oPC)+" "+GetTag(oNewItem));
            SetLocalInt(oPC, PLNS_NOTIFICATION_STATE, 0);
            break;
        case 1:
            LogMessage(LOG_PC, oPC, GetName(oPC)+" has loot notification turned off.", "[PLNS] Loot notification set to state 1 for "+GetName(oPC)+" "+GetTag(oNewItem));
            SetLocalInt(oPC, PLNS_NOTIFICATION_STATE, 1);
            break;
        case 2:
            LogMessage(LOG_PC, oPC, GetName(oPC)+" has loot notification turned on for plot items only.", "[PLNS] Loot notification set to state 2 for "+GetName(oPC)+" "+GetTag(oNewItem));
            SetLocalInt(oPC, PLNS_NOTIFICATION_STATE, 2);
            break;
    }
    return TRUE;
}
