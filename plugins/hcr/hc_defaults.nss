//  ----------------------------------------------------------------------------
//  hc_defaults  26th January, 2006 - SE
//  ----------------------------------------------------------------------------
/*
    Settings file for HCR systems to allow systems and features to be configured
    to suit a module. Refer to the notes accompanying each setting for details
    on use and appropriate values.

    NOTE: If you change a value, you do NOT have to rebuild the module NOR
    recompile any other script.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.04
    - Added Dom Queron's custom healer - SE
      Cost settings for Dom Queron's custom healer are found in gzinc_effecttool

    HCR 3.03.0b
    - added wandering monster call info - SE
    - added REALFAM is the "value" of the xp penalty(200 by default) - SE
    - added Toggle for 1/2hp's for familiar if REALFAM is switched on (see REALFAMHP) - SE
    - added in toggle for party shift resting - SE
    - added in toggle for loot notification
    - added in toggle for gold encumberance
    - added in toggle for PHB racial movement speeds
    - added on toggle for PHB armor movement speeds

    HCR 3.02
    - added in new PrC's from HOTU.
    - added in new bleed check controls
*/
//  ----------------------------------------------------------------------------
#include "hc_inc"


// Set PERSIST = 1 to turn on storing of lootbags and playerstates.
// NOTE: Do not use with NWNX!
int PERSIST = 1;

// Set AUTOTRANS = 1 to turn on Auto transfering of loot items when lootbag
// is opened by owner.
int AUTOTRANS = 1;

// Set PWEXP to 1 to use the Persistent World Exp system. This was taken out in
// v3.1.0 - If you want to use PWEXP then use the "dnd_inc_exp" script.
int PWEXP = 1;

// If you want items to become unidentified when dropped on the ground you must
// set UNIDONDROP below to 1.
int UNIDONDROP = 1;

// If you want MATERCOMPs to be required then you must set MATERCOMP below to 1.
int MATERCOMP = 1;

// Set SINGLECHARACTER to 1 to restrict players to one character each, even if
// that character is dead. Leave at 0 to use unlimited number of characters per
// player.
int SINGLECHARACTER = 0;

// Set MULTICHAR to a number of characters allowed to play in the mod for a
// player, even if those characters are all dead. Singlecharacter above
// overrides this setting. Leave at 0 to use unlimited number of character per
// player.
int MULTICHAR = 0;

// Set this to anything you want show to all players when logging in.
// If you want no message shown, change to "NONE".
string LOGINMESSAGE = "Bienvenido, recuerda divertirte";

// Set to 0 to allow folks to come back to life after a server reset.
int DEATHOVERREBOOT = 0;

// If 0, will use normal summoning duration, if 1 will cause creature to last 1
// round (6 sec) per HitDice (level) of the summoner. You can set it to higher
// numbers to multiple rounds, ie 3 would be 18 seconds per level of summoner.
// By the book though its 1 round. set to 2 rounds by default due to delay in
// summoning.
int SUMMONTIME = 6;

// If set to 0, you get BW familiars that instant heal when you "feed" them.
// Otherwise the value of xp loss on death = 200 by default
// Change to suit your module
int REALFAM = 200;

    //If REALFAM above is set to any value other than 0 and REALFAMHP is set to 1 it will limit familiar to 1/2 hp of master per PHB.
    int REALFAMHP = 1;

// NPCCORPSE - If set to 1, you get NPC lootable corpses that do not fade right away.
//  see hc_npccorpse to change settings.
int NPCCORPSE = 1;

// Set to 1 to require players find a trainer to level up.
int LEVELTRAINER = 0;

// Set to the amount of gold per level that training costs.
int LEVELCOST = 100;

// Sets the level that players start at in your world.
int GIVELEVEL = 1;

// Set to a number of players you want to be online, then when you start your
// server, set the max number of players to a number higher than DMRESERVE and
// you will always be able to log on. This defaults to disabled.
int DMRESERVE = 0;

// Setting PKTRACKER enables automatic banning of a player by CDKEY when he
// exceeds the number of PK's of PKTRACKER.  Helps prevent griefers.  Defaults
// to 5 (means boots on number 6)
int PKTRACKER = 0;

// Set this to 0 if you dont want to know when one player kills another.
int TELLONPK = 1;

// Setting int WANDERSYSTEM = 1; turns on the wandering encounter system.
// At this time it is only called on player rest to see if an encounter occurs
// during their rest. A successful call to this script will cause a nearby
// hostile monster to come and attack.
// *Note* Only works with hostile creatures in the current area the player is
// resting in.
int WANDERSYSTEM = 1;

// Setting DEATHSYSTEM to 0 will allow respawn and quit and return to get around
// being dead or dying. (Removes death amulets) this overrides lootsystem and limbo.
int DEATHSYSTEM = 1;

// Setting BLEEDSYSTEM to 0 will remove the bleed to death system.
int BLEEDSYSTEM = 0;

    // controls the time between each bleed check a PC must makes each while in
    // the DYING state. Reducing the number will accelerate the possibility of
    // a PC bleeding to death. Default is 1 round.
    float HC_BLEED_DYING_DELAY  = RoundsToSeconds(1);

    // controls the time between each bleed check a PC must makes each while in
    // the STABLE state. Reducing the number will accelerate the possibility of
    // a PC bleeding to death or the rate at which they heal. Default is 1 hour.
    float HC_BLEED_STABLE_DELAY = HoursToSeconds(1);

    // the percentage chance of spontaneous self-stabalising.  Setting this to
    // 0 will prevent player's from spontaneously stabailing while dying forcing
    // them to bleed out or receive aid. Default is 10%.
    int HC_BLEED_STABLISE_CHANCE = 10;

    // the percentage chance of spontaneous self-recovery.  Setting this to 0
    // will prevent player's from spontaneously recovering while stable or in
    // recovery forcing to bleed out/heal naturally (respectively) or receive
    // aid. Default is 10%.
    int HC_BLEED_RECOVERY_CHANCE = 10;

// Setting LOOTSYSTEM to 0 will remove the ability to loot a pc corpse.
int LOOTSYSTEM = 0;

// Setting REZPENALTY to 0 will turn off the losing of 1/2 a level.
int REZPENALTY = 0;

// Setting LIMBO to 0 will stop moving players to Fugue on death.
int LIMBO = 1;

// Setting DYINGSTRIP to 0 will stop stripping players of inventory on dying
int DYINGSTRIP = 0;

// Setting INVSTRIP to 1 will strip players of inventory only.
// (LOOTSYSTEM needs to be set to 1)
int INVSTRIP = 0;

// Setting RESTSYSTEM to 0 will remove rest restrictions from play.
int RESTSYSTEM = 1;

// Setting RESTINSHIFTS to 1 will make parties have to rest in shifts
int RESTINSHIFTS = 0; //New 18th May, 2005 - SE

// Controls how long between rests if RESTSYSTEM is used.
int RESTBREAK = 16;

// Set to 0 to turn off the penalty for resting in armor > 5.
int RESTARMORPEN = 1;

// Setting this to 0 will allow full healing on each rest.
int LIMITEDRESTHEAL = 1;

// Set to 0 to turn off the functioning of bedrolls and the requirement to have
// them to rest.
int BEDROLLSYSTEM = 1;

// Setting this to 0 will turn off the conversation to have to rest.
int RESTCONV = 1;

// Setting this to 1 will turn on the party rest to advance time on rest. Will
// only work when RESTCONV is set to 1. Also only for use with one party setting
// in Mod.
int PARTYREST = 0;

// Set to 1 if you want to allow pcs to rest while under certain bad effects.
int BADREST = 0;

// Setting STORESYSTEM to 0 will stop the stripping of and equipping of new PCs.
int STORESYSTEM = 1;

// Setting FOODSYSTEM to 0 will turn off need for food to rest.
int FOODSYSTEM = 1;

// Setting BURNTORCH to 0 will restore torch durations to normal BW settings.
// Otherwise torches will last 1 hour per BURNTORCH) PER PHB pg 144.
int BURNTORCH = 1;

// Setting HUNGERSYSTEM to 0 will turn off the need for PCs to regularly consume
// food and water to avoid death by starvation or dehydration.
// Setting this to 1 will IGNORE the FOODSYSTEM flag, and it will use its
// own food system instead.
int HUNGERSYSTEM = 1;

// Setting FATIGUESYSTEM to 0 will turn of the ill effects recieve by a PC that
// goes a time without resting. Note that if this is 0 it will NOT stop fatigue
// penalties resulting from RESTARMORPEN = 1.
int FATIGUESYSTEM = 1;

// Setting HCREXP to 0 uses the normal BW experience system.
int HCREXP = 1;

// Set the base exp used for all creature kills, 300 is the DMG default per CR
// adjuseted to 10% default. Adjust as needed to match your campaign speed.
int BASEXP = 30;

// BONUSEXP is the factor applied to creature exp amounts to further tweak the
// advancement rate.
int BONUSXP = 5;

// DECONENTER set to 1 will decrement spells and feats known on enter to prevent
// players from quiting and rejoining the game just to get feats and spells
// back. Use 0 to turn off the feature.
int DECONENTER = 1;

// If DIRTRACK is set to 1 then the Direction Tracking system is used.
// Both Direction tracking and Placeable tracking can be used at the same time.
int DIRTRACK = 1;

// If PLACETRACK is set to 1 then the Addon Placeable Tracking system will be
// used. This can be combined with the Direction Tracking System.
int PLACETRACK = 0;

// SUBRACES must be set to 1 if you use the crr subrace addon. If you do not want subrace
// support or have your own system set to 0 to turn it off.
int SUBRACES = 0;

// GODSYSTEM must be set to 1 to allow a chance that gods will be able to ress a pc on death.
// pc must choose a god and mod designer needs to place the GodLoc waypoint to place the ress loc.
int GODSYSTEM = 1;

// GODCHANCE is the percent chance that a pc will be raised by their god if they have one.
// defaults to 5%(+1% per 4 levels of the character)
int GODCHANCE = 5;

// Loot notification. Setting this to 1 enables the party loot notification system
// default = 0; which is disabled
int LOOTNOTIFY = 0;

// Gold encumberance. Setting this to 1 enables gold encumberance. For every 500 gold
// a player obtains, they receive a bag in INV that weighs 5.5 pounds.
// default = 0; which is disabled.
int GOLDENCUMBER = 0;

// PHB Racial Movement. Setting this to 1 will set the movement speed of small creatures
// such as Dwarves, Halflings, etc, including creatures to movement speed 20 instead of
// the incorrect Bioware default of 30, which is tall races, like Elf's, Humans, etc
// default = 0; which is disabled
int RACIALMOVEMENT = 1;

// PHB Armor Movement. Setting this to 1 will enable Armor Encumberance movement speeds
// for PC's and creatures. All PC's and Creatures other than Dwarves receive a movement
// speed decrease in heavy armors.
// default = 0; which is disabled
int ARMORENCUMBER = 1;

// Set prestige classes to 0 to disable them. On by default. If you disable them
// you can enable them in your mod by just deleting the local int and setting a
// Persistent Int to TRUE (or database/campaign var). names are below.
// Persistent Int names: "ASSASIN"+sID, "ARCHER"+sID, "BLKGUARD"+sID,
// "CHAMPION"+sID, "DISCIPLE"+sID, "DEFENDER"+sID, "HARPER"_sID, "PALEMSTR"+sID,
// "SHADOW"+sID, "SHIFTER"+sID and "WEAPMSTR"+sID.
int ASSASIN  = 1;
int ARCHER   = 1;
int BLKGUARD = 1;
int CHAMPION = 1;
int DISCIPLE = 1;
int DEFENDER = 1;
int HARPER   = 1;
int PALEMSTR = 1;
int SHADOW   = 1;
int SHIFTER  = 1;
int WEAPMSTR = 1;

// HCRREAD must be set to 1 before any HCR variables will be set. It's just a
// small measure some folks have been asking for to make sure that DM's at least
// have opened this file once.
int HCRREAD = 1;

//  ----------------------------------------------------------------------------
//  MAIN
//  ----------------------------------------------------------------------------

void main()
{
  if (!HCRREAD) { return; }
  SetLocalInt(oMod, "PWEXP",PWEXP);
  SetLocalInt(oMod, "HCRREAD",HCRREAD);
  SetLocalInt(oMod, "MATERCOMP", MATERCOMP);
  SetLocalInt(oMod, "SINGLECHARACTER",SINGLECHARACTER);
  SetLocalInt(oMod, "DEATHOVERREBOOT", DEATHOVERREBOOT);
  SetLocalInt(oMod, "SUMMONTIME", SUMMONTIME);
  SetLocalInt(oMod, "REALFAM", REALFAM);
  if(REALFAM)
  {
    SetLocalInt(oMod, "REALFAMHP", REALFAMHP);//New 18th May, 2005 -SE
  }
  SetLocalInt(oMod, "RESTARMORPEN", RESTARMORPEN);
  SetLocalInt(oMod, "RESTSYSTEM", RESTSYSTEM);
  SetLocalInt(oMod, "RESTINSHIFTS", RESTINSHIFTS);//New 18th May, 2005 -SE
  SetLocalInt(oMod, "RESTBREAK", RESTBREAK);
  SetLocalInt(oMod, "RESTCONV", RESTCONV);
  SetLocalInt(oMod, "PARTYREST", PARTYREST);
  SetLocalInt(oMod, "LIMITEDRESTHEAL", LIMITEDRESTHEAL);
  SetLocalInt(oMod, "BEDROLLSYSTEM", BEDROLLSYSTEM);
  SetLocalInt(oMod, "BADREST", BADREST);
  SetLocalInt(oMod, "LEVELTRAINER", LEVELTRAINER);
  SetLocalInt(oMod, "LEVELCOST", LEVELCOST);
  SetLocalInt(oMod, "GIVELEVEL", GIVELEVEL);
  SetLocalInt(oMod, "DMRESERVE", DMRESERVE);
  SetLocalInt(oMod, "PKTRACKER", PKTRACKER);
  SetLocalInt(oMod, "TELLONPK", TELLONPK);
  SetLocalInt(oMod, "WANDERSYSTEM", WANDERSYSTEM);
  SetLocalInt(oMod, "DEATHSYSTEM", DEATHSYSTEM);
  SetLocalInt(oMod, "BLEEDSYSTEM", BLEEDSYSTEM);
  if(BLEEDSYSTEM)
  {
      SetLocalFloat(oMod, "HC_Bleed_DyingDelay", HC_BLEED_DYING_DELAY);
      SetLocalFloat(oMod, "HC_Bleed_StableDelay", HC_BLEED_STABLE_DELAY);
      SetLocalInt(oMod, "HC_Bleed_StabliseChance", HC_BLEED_STABLISE_CHANCE);
      SetLocalInt(oMod, "HC_Bleed_RecoveryChance", HC_BLEED_RECOVERY_CHANCE);
  }
  SetLocalInt(oMod, "LOOTSYSTEM", LOOTSYSTEM);
  SetLocalInt(oMod, "REZPENALTY", REZPENALTY);
  SetLocalInt(oMod, "LIMBO", LIMBO);
  SetLocalInt(oMod, "DYINGSTRIP", DYINGSTRIP);
  SetLocalInt(oMod, "INVSTRIP", INVSTRIP);
  SetLocalInt(oMod, "STORESYSTEM", STORESYSTEM);
  SetLocalInt(oMod, "FOODSYSTEM", FOODSYSTEM);
  SetLocalInt(oMod, "BURNTORCH", BURNTORCH);
  SetLocalInt(oMod, "HUNGERSYSTEM", HUNGERSYSTEM);
  SetLocalInt(oMod, "FATIGUESYSTEM", FATIGUESYSTEM);
  SetLocalInt(oMod, "HCREXP", HCREXP);
  SetLocalInt(oMod, "BASEXP", BASEXP);
  SetLocalInt(oMod, "BONUSXP", BONUSXP);
  SetLocalInt(oMod, "DECONENTER", DECONENTER);
  SetLocalInt(oMod, "DIRTRACK", DIRTRACK);
  SetLocalInt(oMod, "PLACETRACK", PLACETRACK);
  SetLocalInt(oMod, "SUBRACES", SUBRACES);
  SetLocalInt(oMod, "NPCCORPSE", NPCCORPSE);
  SetLocalInt(oMod, "MULTICHAR", MULTICHAR);
  SetLocalInt(oMod, "UNIDONDROP", UNIDONDROP);
  SetLocalInt(oMod, "ASSASIN",  ASSASIN);
  SetLocalInt(oMod, "ARCHER",   ARCHER);
  SetLocalInt(oMod, "BLKGUARD", BLKGUARD);
  SetLocalInt(oMod, "CHAMPION", CHAMPION);
  SetLocalInt(oMod, "DISCIPLE", DISCIPLE);
  SetLocalInt(oMod, "DEFENDER", DEFENDER);
  SetLocalInt(oMod, "HARPER",   HARPER);
  SetLocalInt(oMod, "PALEMSTR", PALEMSTR);
  SetLocalInt(oMod, "SHADOW",   SHADOW);
  SetLocalInt(oMod, "SHIFTER",  SHIFTER);
  SetLocalInt(oMod, "WEAPMSTR", WEAPMSTR);
  SetLocalInt(oMod, "GODSYSTEM", GODSYSTEM);
  SetLocalInt(oMod, "GODCHANCE", GODCHANCE);
  SetLocalInt(oMod, "PERSIST", PERSIST);
  SetLocalInt(oMod, "AUTOTRANS", AUTOTRANS);
  SetLocalInt(oMod, "LOOTNOTIFY", LOOTNOTIFY);
  SetLocalInt(oMod, "GOLDENCUMBER",GOLDENCUMBER);
  SetLocalInt(oMod, "RACIALMOVEMENT", RACIALMOVEMENT);
  SetLocalInt(oMod, "ARMORENCUMBER", ARMORENCUMBER);
  SetLocalString(oMod, "LOGINMESSAGE", LOGINMESSAGE);
}

