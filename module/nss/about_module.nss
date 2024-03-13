// HCR v3.04 Final version
// 26th January, 2006
/*

HCR 3.04 -

    Added Dom Queron's custom healer - SE
    (Cost settings for Dom Queron's custom healer are found in gzinc_effecttool)
    Changed the start area to a temple.
    Added HCR NPC Healer.
    Moved the starting store to the temple, move this to a suitable area.

HCR v3.03.0b -

   Detailed comments and change log about the Hardcore Module overall.

   CHANGES:
   Includes all previous fixes posted for HCR 3.02.05
   Addition of toggleable loot notification
   Addition of toggleable gold encumberance
   Addition of toggleable PHB racial movement speeds
   Addition of taggleable PHB Armor Encumberance


HCR 3.2.0

   SEE NOTES IN APPROPRIATE SCRIPTS FOR MODIFICATIONS.
   FOR A LIST OF SCRIPTS THAT WAS ADDED/CHANGED, SEE THE "changed_files" SCRIPT.

   Fix - Epic level XP.
   Fix - Resting in Armor penalty.
   Fix - No-Drop Items now use "Cursed" check box.
   Fix - HOTU selectable player corpse bug.
   Fix - Gold duping.
   Fix - Spell hook implementation.
   Fix - SendHelp() lag bug.
   Fix - Added PrC's from HOTU.
   Fix - Paladin's Detect Evil OOC item.

HCR 3.1.0

   SEE NOTES IN APPROPRIATE SCRIPTS FOR MODIFICATIONS
   FOR LIST OF SCRIPTS THAT ADDED OR CHANGED SEE changed_files SCRIPT

   Fixed all temporary hitpoint spells to not allow you to be alive with negative hitpoints (BW Bug).
   fixed both starting stores.
   Changed wording in conversation hc_c_resplayer to correct grammer and spelling.
   took out spell tracking now just decrement all spells and feats on enter.
   deleted all st_ scripts.
   took out disable/recovery code. deleted hc_hb_deathcrps, hc_rdisabled, hc_heal, hc_inc_death, and hc_inc_heal.
   Added CRR code for subraces. (took out all sei_ and subraces scripts).
   Changed sound in Fugue to hell to remove screeching noise noticed by some.

HCR 3.0.0

   SEE NOTES IN APPROPRIATE SCRIPTS FOR MODIFICATIONS
   FOR LIST OF SCRIPTS THAT ADDED OR CHANGED SEE changed_files SCRIPT

   8/12/2003 - improved backup time for persist code. fixed various compatability issues with nwnx.
               delete. added oil flask to component merchant.

   8/3/2003 -  fixed party rest code and double corpses when lootsystem is off and logging out when
               dying after a server reset.

   7/27/2003 - Added persistence code. please overwrite old scripts with 7/27/2003 scripts.
               Added BagYard placeable suggest you put this somewhere close to the GraveYard.
               To use persistent code set PERSIST = 1 in hc_defaults.
               To use Autoloading of dropbag by owner turn AUTOTRANS = 1 in hc_defaults.
               fixed alot of nw_s0 spells to use scrolls and null magic overwrite all.

   7/26/2003 - changed hc_c_lprest conversation..please overwrite it.

   7/25/2003 - dropped items placable has changed take out hc_db_close out of heartbeat.

   7/19/2003 - ok to delete nw_i0_spells and nw_d1_templeheal

   Delete ext_i0_ai, i0_generic, jug_o0_spell, magic_i0_ident, paus_i0_array, tk_i0_itemsp scripts.
   Delete nw_i0_plot, nw_i0_generic, all nw_ch_ac scripts except for 1, 7.
   Delete all nw_c2_default scripts except for 7 and 9.
   Modified DeathCorpse to use copy of your dead self. delete old copy of deathcorpse if you want to.
   Death stripping is now done in the Fugue Enter event to alleviate dupping and lag problems with
   jump to location.
   Replaced old hcr objects in newbie mechants with xo ones (yes i know we did it first!).
   Added new Old Birdbath to Fugue Plane this object can only be used by a DM (yes i know it should be in a wand!)
   It allows DMs to create a temporary res portal or permanent if you dont switch it off.
   Most items and placeables have been updated i suggest you overwrite all on those objects.

HCR 2.0 SR 6.1

   SEE NOTES IN APPROPRIATE SCRIPTS FOR MODIFICATIONS
   FOR LIST OF SCRIPTS THAT ADDED OR CHANGED SEE changed_files SCRIPT

   Modified DeathCorpse to not use heartbeats. this should vastly improve
   performance please reimport DeathCorpse if you are upgrading.

HCR 2.0 SR 6.0

   SEE NOTES IN APPROPRIATE SCRIPTS FOR MODIFICATIONS
   FOR LIST OF SCRIPTS THAT ADDED OR CHANGED SEE changed_files SCRIPT

   Added 2 creatures fx_maker and fx_makernd
   Added 2 placeables  fxbox and target_fnf_fx
   Added 1 trigger fnf_fx_maker
   Added 1 waypoint easy_fx_waypoint
   This is part of the special effects addon that is part of hcr
   special thanks to ElvisMan2001 for creating this nice tool.

HCR 2.0 SR 5.5

   SEE NOTES IN APPROPRIATE SCRIPTS FOR MODIFICATIONS
   FOR LIST OF SCRIPTS THAT ADDED OR CHANGED SEE changed_files SCRIPT

HCR 2.0 SR 5.4

   NEW
   - Stackable potions are now available under the Misc. tab.
     They will work like hcr potions.
     Except for they will not be able to be used on a dying PC.
   - Added new scroll casting system. New scrolls are added in the custom
     scroll section. Scrolls now have spell failure chance and misfire chance
     based on caster level as per DMG. Also new scrolls are appropriate towards
     class level and priced as per DMG with additional cost per caster level over
     minimum. (see description fields on each scroll for pricing)
     Added new text script hc_text_ability.
   - Added DMFI support for DMFI dungeon master tool.
   - Added plot code for emote wands to make them not sellable.
   - Created a tinderbox item to be able to start camp fires.
   - Added newer Paus and Jugs code together for better caster AI.

   FIXED
   - Healer kit logic:
     changes name of object to healer's kit from medicine bag.
     fixed some incorrrect if logic.
     note healing kits do not remove disabled state just help stop bleeding
     or provide long term care.
     added disabled logic to heal kits.
   - Campfire logic: Fixed campfire distance to light.
   - Potion logic:  Added code to remove disabled state.
   - Skinning logic : Added code for npccorpses now this will only work with npc corpses turned on.
     When you skin a animal the invisible corpse goes away leaving a loot bag with any inventory
     of the animal plus a piece of raw meat for cooking.
   - Bleeding Code: changed some bleeding issues with self stabilizing.
   - Death Corpse: took out corpse sound as now sound is correct by default using loot bag 5.
     Took out code to destroy lootable corpse when empty because of new code for only having
     one xp message in nw_c2_default7. Note: corpse placeable has changed overwrite it.
   - Resting: Added party rest system. Added code to check to see if resting in armor is set
     on if not, do not display this option for party rest. To use party rest system
     set PARTYREST=1 in hc_defaults and use one party settings in your mod.
     Fixed rest message to state hour and minute format.
   - Fugue: added code to check to see if FugueRobe already exists and if it does dont strip.
     Added token system for fugue to get out easier.
   - Traps: Added code to allow npcs to disable hcr traps.
   - Tracking: Changed tracking to use racial type instead of exact type of creature.
   - Transfering: fixed code for transfering bug. Added support to keep items in boxes.
   - NPC respawn: added copy function to keep custom creature tag names. this allievates having to
     create custom pallette monstters for respawn. Make sure all monster tag names and waypoints are
     unique. (ie place a monster then change its tag to RESPAWN + unique name)
   - NPC corpses: Added code to copy objects instead of creating them to keep charges and custom tags.
     Now allow to skin any ANIMAL type creature. when skinned meat will appear in loot bag next to creature
     along with whatever that was in its inventory.
   - Fixed various death corpse bugs.
   - Fixed various dying system bugs.
   - Fixed various disabled bugs.
   - Fixed taking experience to always leave atleast one xp.
   - Added skinning message.
   - fixed nodrop items in boxes so they dont drop.
   - now send message when a familiar is killed.
   - All nw_s0 nw_s1 and nw_s2 spells fixed for scrolls.

HCR 2.0 SR 5.3

   NEW
   - Spell Tracking system that keeps track of spells casted and feats used when you log in and out.
   - Spell Addon is now part of base HCR, spells have been updated to match 1.27 and some have been fixed.
   - Added a hc allow rest enter script to allow unrestricted rest in a area also added a hc allow rest exit script to
     strip benificial spells when you leave that area so as to not have a mage buff everyone and chain rest.
   - Component system added as part of base HCR. A component recipie book and component newbie merchant is available.
   - NPC corpse added to base HCR. Read hc_npccorpse to learn how to use it.
   - Added HCR innrest scripts to integrate inns into hcr. Look at 5.3 inndemo for example.

   FIXED
   - Changed public cd key to player name to be more unique in all scripts that need them.
   - Various tracking and thieftool conversation improvements and ability to recover traps.
   - Major revisions on Death and Bleeding. Now you can ress a player who is dead and hasnt transferred to fugue yet.
   - Changed Ress Penalty for lvl 1 players to half of thier xp instead of a temporary con drain.
   - Fixed getting 2 messages when getting experience for kills. Now when using hcr experience the xp slider wont matter.
   - Added Fatigue to Barbarian Rage when it expires and your still in combat.
   - read individual 5.3 script notes for further details on fixes.

HCR 2.0 SR 5.2

   NEW
   - hc_on_play_rest - Added new rest conversation HC_C_REST to pop up after you hit the rest button.
     This will ask you if you want to take off heavy armor if you are wearing it, or if you want to
     rest, or cancel rest. Solves problems with players accidently hitting the rest hotkey and accidently
     sleeping in armor.
   - Added 2 new thieves tools in the newbie merchant2 inventory under the weapon tab. You must equip them to use them.
   - Added new scripts hc_cat_xxx hc_csc_xxx to flag traps for party members and other additional options for trap
     disarm conversation.
   - hc_takexp - New Script to take experience and level down properly. to use execute the script using the object
     your taking the experience from. Make sure to set local int TAKEXP to the experience you want to take.
   - hchtf_enterwater - Changed the enter water script to tell you if you can fill water in the spot when you enter a
     water fillable trigger area. Also rangers and druids will be able to see if the water is drinkable or not.
   - Added new code to create multiple loot bags if a player dies in another location and still hasnt got his stuff back.
     also when a loot bag is now opened by its owner items will automatically go into the owners inventory.
   - Added new variable to hc_defaults called SELFSTABLE. defaults to 1. if you set it to 0 then you will bleed
     until you die or someone heals you.
   - Added code to hidden trapdoors and walldoors to transport you and all your henchmen, familiars, etc. with you when
     you enter it.

   FIXED
   - hc_act_thieftool - Added code to handle new thieves tools which will work with HC traps and doors (dc+100)
     and normal BW traps and locked doors.
   - hc_inc_take_exp - Deleted script as no longer needed with 1.27.
   - hc_on_ply_dying - fixed bleeding to death if you are possessing familiers.
     It also implements new experience loss when your familiar dies if you have REALFAM on.
   - nw_ch_ac7 - code changed to use the new hc_takexp script.
   - hc_on_play_death - Changed to reset the time rested when you die. that way you can rest after you are ressed.
   - hc_on_cl_enter event - changed decrement talents on enter to only decrement after a certain time period is passed
     since the module was started. this allows players to join the game and still have thier spells if the game just
     started or if the player has joined the game for the first time.
   - hc_inc_rezpen - changed script to call new hc_take_level script to properly account for a bug in leveling down
     to level 1. now will boot player from game if last level gained was 1 and he loses a level.
   - changed resting without bedroll to RESTBREAK + 4 hours.

HCR 2.0 SR 5.1

   NEW
   - hc_inc_take_exp - This is the new script going into version sr5.1. Its used as a include file in several scripts.
     It takes the highest lvl from the player correctly and never makes the character bugged from going
     to lvl 0 by losing a lvl. If you include this script in your code then it has a function to call
     named TakeExp(object oPC, int nExpLoss);
   - Added new invisible object that will autoexport pcs every 10 minutes. just place the object in any area to use it.
     object is in custom pallette under misc. called  CharAutoSave.

   FIXED
   - hc_on_play_rest: Everytime you attempt to rest and have a const decrease your const goes down by one
     if your level is 1 or 1/1 or 1/1/1. Fixed to supernatural effect so it doesnt go away on rest...
     took out con decrease in rest code.
   - hc_on_ply_dying - fixed bleeding to death if you are possessing familiers.
     It also implements new experience loss when your familiar dies if you have REALFAM on.
   - nw_ch_ac7 - code changed to use the new takexp function.
   - hc_on_play_death - Changed to reset the time rested when you die. that way you can rest after you are ressed.
   - hc_on_cl_enter event - changed const decrease to supernatural so resting will not reset the decrease.
     Also changed hc_con_loss and hc_con_loss1 to do the same.
   - hc_on_fugue_enter - plot flag was getting set to 0 for npcs in fugue causing them to be able to be killed there.
     changed to not set plot flag off for npcs.
   - hc_defaults & hc_bleeding - added a new Variable called SELFSTABLE to hc_defaults.
     When on it works like always (default) when off you will no longer self stabilize.
     If set to 0 when your dying you will continue to bleed until dead or someone heals you.

HCR 2.0 SR 5.0

   NEW
   - When a players corpse is used on a cleric a conversation dialog comes up
     If the Cleric is Lvl 9 Raise Dead is Available, if the Cleric is lvl 13 Raise Dead
     and Ressurection is Available, if the Cleric is lvl 17 Raise Dead, Ressurection,
     and True Ressurection. Cost for spells are based on the cleric lvl. Cost will be
     sent to the player so a informed choice is possible.
   - Added support for Alomar's Addon Placeable Tracking System instead of the default
     Radar Tracking System. To use change PLACETRACK to 1 in the hc_defaults
     script and then install the addon. Leaving the variable DIRTRACK on is
     optional and will work with PLACETRACK if you have them both on.
   - Added new invisible placeable to auto export all chars. This defaults to every
     10 minutes. Can be changed to any minute variable. All thats needed is place
     the object anywhere in mod. Object is in the Custom pallette Misc. called CharAutosave.
   - Added new version of Cure Potions with smaller size and weight to more accuratly represent
     PHB values. If you want to use new Potions in your newbie merchant use NewbieMerchant2
     instead of the default Newbie Merhcant.

   FIXED
   - Various timing bugs with transfer of items.
   - All scripts will now compile with no errors.
   - Level Trainer fixed to fix owing money on lvling to next level.
   - Now when you lose a level do to ressing or raise dead you will never get set to level 0.
   - When eating food or drinking, a message will now be sent to PC.
   - Now you cant pour a potion down a non dying persons throat. Fixes problem with standing behind a
     fighter and giving him potions while hes fighting.
   - Familiers, Henchman, etc. now follow you through secret and trap doors.

   CHANGED
   - Changed Activated scripts to use the resref name as the script name instead of
     the tag name. When you create a special activatable object make its resref name
     the same as a script name. When the item is activated the script will be called.
   - When using potions on someone whos dying you must be withen 5 feet of the dying
     person. Also added delay in drinking potion to represent a full round action as per PHB.
   - Death and Dying. Now when you are dead or dying your unequipped items go to a drop
     bag. When you Die your equipped items also go in same bag. Your deathcorpse is created
     and 10 seconds later your tranfered to FUGUE Plane. When ressed your stuff stays
     where you died (unless someone takes it while your dead). This is to get rid of losing items and
     duplicate items on death and ress. Also more accurately represents the PHB.
   - Raise Dead spell now makes con loss on lvl 1 chars. a persistent int var. "CONPEN"+sID.
     this can be used to make con penalties perminent in persistent worlds. A lessor restore or
     restore will still remove this loss.
   - Now when entering a water trigger you will get a message saying you can fill your canteen.

HCR 2.0 SR 4
   a) Added code to fix bleeding problem where you stoped bleeding when you stabilized. you now bleed once and hour or go into
      recovery when you stabilize the first time.

   b) Fixed code to drop players bodies if they are being carried by a player and he quits
      the game. (now working for sure), also fixed problem with player when dead or dying not dropping player corspe(s).
      droped player corpses on quiting or dying/death will reapear where the corpse originally died.

   c) Added a 6 second delay when you die before you go to fugue. this will allow slow or big servers enough time to transfer objects to the players corpse on death.

   d) Moved the players dropped items on dying offset a bit from the body. this allows you to be able to loot the bag while they are dying and use items in it to help them if you want.

   e) Added new invisible placeable object Hidden_Trap_Trigger under custom misc template. Place this object every 10 or so feet of each other lining the outline of any Trap Triggers. This will alieviate the problem of traps not being detectable because the center of the trap is more than 10 feet from the searcher (getdistance is calculated from center of trigger not the edges). The hidden trigger will get the nearest trap and use it for detection. This also allieviates the problem with the Trap Disarmer not triggering the trap when he fails his disarm roll as they will now walk toward the trigger object, instead of randomly walking in a line off the map sometimes. To make sure that the trap will be triggered, please place the invisible trigger objects just inside the trap so if its triggered the triggerer will walk into the trap and set it off (ie he will walk toward the nearest invisible trigger object). IMPORTANT: The actual trigger trap tag has to start with "HCTP_" or the triggers will not work!
      I am going to include an example under the custom template for trap triggers.

   f) fixed bug with sei items being dropable.

HCR 2.0 SR 3
   See Readme.txt

HCR 2.0 SR 2
   FIXED
   - Some fixes for HCR compatility with 0100010 Cohort Add-on System
   - Added some compatibility between campfires and ATS Ambrosia Raw meat,
     so the meat can be cooked
   - Updated hc_mod_load and hc_usr_define to correct a bug where restarting
     the module would crash the server
   - Items flagged as "no drop" inside i_tagtests are not transfered to
     death corpses
   - Updated the behaviour of no-drop items: now if a no-drop item is inside
     a bag, and the player tries to trade/drop the bag, it will behave like a
     no-drop item. If the no-drop items are removed from the bag, the player
     can drop/trade the bag again.
   - Fixed problem where player lost items after death, in certain situations.
     Also, players cannot trade inside Fugue plane.
   - Small error with the HCR Wand and setting the PLAYERDM option
   - Fixed a potential conflict with familiars dying if there are two PCs with
     the same name.

HCR 2.0 SR 1
   FIXED
   - Bug where dying spamming the player with odd werebear error messages
   - PW XP system not giving correct XP and player losing levels
   - Subrace spell=like ability "no drop" item crashes seerver on a player
     to player transfer.
   - Divide by zero error.

HCR 2.0
   Well, all good things must come to an end.  With this version of HCR I am
   retiring from it as project manager. If you look below, Im going out with a
   bang. That being said, it has been a lot of fun folks. I am NOT done with NWN
   by a long shot, its just HCR has reached a good stopping point, at least for
   me. It is also to the popularity level where I get a lot of "hate" mail from
   folks who dont like one thing or the other, that was inevitable, but its not
   why I code. Coding is my hobby, I do it to relax, and to help others. That
   being said, lets get on to the changes to HCR Base 2.0.

   Due to the numerous changes, I recommend using the HCR Base ERF set to
   upgrade, there is a changed_files in this one, but you would be better
   going clean.

   NEW
   - Persistent World Exp System.  This system uses the Wizard exp table from
     1E ADnD as the new base table.  Due to this, it means players will need
     2500xp for level 2 (vice 1000) and 3,750,000xp for level 20 (vice 190,000).
     There are Class multiples for each class (defaulted to 1E ratios).  This
     system works WITH the Subrace xp system if you turn on the PW Exp system.
     So you will have class multiple, and a racial multiple for ECL races.  The
     system is auto-persistent, storing the exp in the normal BW exp counter
     as a ratio.  Using this system, you can set BASEXP very high (100-300) and
     players will get through levels 1-4 semi quick, and then slow way down.
     System from Archaegeo.
   - Caster AI system added.  This will make casters NPC/Monsters cast their
     spells in a smart manner.  For example, instead of casting ray of frost
     as a CR 15 Drow mage, the mage will cast Timestop, haste, greater stoneskin,
     circle of death, and then start attacking. (Thanks to Jugalator for the
     nastier casters)
   - DM's now receive a message if a PC dies more than 2x in 60 seconds, it
     normally means they are using the click like mad to avoid fugue bug.
   - Players are now set unplot every heartbeat to avoid having players run
     around invuln.  (if you need them to be invuln, you can comment out the
     code in hc_on_heartbeat)

   CHANGED
   - HCR Original subrace system is gone, now replaced by ALFA's Subrace system.
     This is an EXCELLENT system, with a TON of power for any subraces you care
     to create, even supports ECLs. Note, with this new system, due to ECL (
     Equivalent character level, ie a drow at 1 is the same as a human at 3) you
     must add all XP in your module via XP_RewardXP. NOTE: some subraces still get
     items under the SEI system, but they are not equipped, so you can turn ILR
     back on in your modules. (Many thanks to Shir'lee for putting out such a
     well made system)

HCR 1.8.7
   NEW
   - New System:  If you set GHOSTSYSTEM to 1.  Instead of lingering in Fugue,
     players will go to fugue, hang out there a moment, then be sent back to
     "haunt" their bodies as an invisible, invulnerable, cant move around,
     ghost.

   CHANGED
   - Added hc_version, all it is is a version number file.  hc_defaults will
     no longer be changed unless something important changes (this time being
     the last).

   FIXED
   - Problem with canteen refilling self if player wasnt thirsty.

HCR 1.8.6
   NOTE: hc_on_cl_enter was changed in this rev, if you are using ATS
         this will overwrite the ATS setup.  To resetup ATS, put
         # include "ats_inc_init"
         at the top of hc_on_cl_enter (without the space between # and include
         and put ATS_InitializePlayer(GetEnteringObject());  on line 249

   CHANGED
   - Corrected issue with a canteen being able to be filled form a water
     source trigger area with an invalid tag. Made canteen correct itself
     incase it ever gets assign an invalid water source tag descriptor.
     Made food and drink tag properties non case sensitive
   - The death corpse is invisible now when a player is dying.  It becomes
     visable when they are dead and gone.
   - Changed the default death script to support those who want to bypass the
     HCR method of animal corpse, and the NPCCorpse.  (transparent change)
     Now if you have uncommented the NW_FLAG_DEATH_EVENT in OnSpawn of your
     critter it will ignore the HCR corpses
   - When you use a PCT on a NPC cleric, it moves the existing DC to the user
     location, this should help prevent loss of items.
   - Changed it so that you only come back at 1hp after raise dead if the
     module is NOT using Rezpenalty (where you lose a level).  Will try to
     make both work later, but this fixes the problem with folks redying due
     to hp loss of the loss of level.

   FIXED
   - Problem with disabled state being applied, thanks 01.

HCR 1.8.5
   NEW
   - Added ability for DMs to ban players from in game, will last till
     server restart or permamently if using pwdb

   CHANGED
   - Ranger tracking changed to not track anything that has the Trackless
     step feat (FEAT_TRACKLESS_STEP).  (Also wont track anything with an
     int of NOTRACK, but using FEATs is better).

   REMOVED
   - KCS system removed from base, made into an add-on, some folks pointed
     out rightly that it belongs better there.
*/
void main(){}
