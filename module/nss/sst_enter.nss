/*
Statix's Smooth Transitions v1

This is set on a generic trigger to call the transition when the
character enters.
*/
void main()
{
object oPC = GetEnteringObject();
//If the player is using a placeable instead of entering use that
if (oPC == OBJECT_INVALID) oPC = GetLastUsedBy();

//Cancel the script if the script is already being run, otherwise note that it is being run
if (GetLocalInt(oPC,"Running") == TRUE) return;
SetLocalInt(oPC,"Running",TRUE);

//Cancel the script if it is not a pc
if (GetIsPC(oPC) == FALSE) return;

//Get the nearest waypoint to the trigger
object oFrom = GetNearestObject(OBJECT_TYPE_WAYPOINT,OBJECT_SELF);
//Get the target waypoint type
string sTarget; if (GetSubString(GetTag(oFrom),4,1) == "A") sTarget = "B"; else sTarget = "A";
//Get the next waypoint
object oTo = GetWaypointByTag("SST_" + sTarget + "_" + GetSubString(GetTag(oFrom),6,GetStringLength(GetTag(oFrom)) - 6));

                             //Perform Commands
//Requirements//
 /*Level*/ if (GetLocalInt(oFrom,"R:Level") != 0){ if (GetHitDice(oPC) < GetLocalInt(oFrom,"R:Level")) { SendMessageToPC(oPC,"You cannot go here because you do not meet the level requirement."); SetLocalInt(oPC,"Running",FALSE); return; } }
 /*Key*/ if (GetLocalString(oFrom,"R:Key") != ""){ if (GetItemPossessedBy(oPC,GetLocalString(oFrom,"R:Key")) == OBJECT_INVALID) { SendMessageToPC(oPC,"You need a proper key item to enter."); SetLocalInt(oPC,"Running",FALSE); return; } }
 /*Gold*/ if (GetLocalInt(oFrom,"R:Gold") != 0) { if (GetGold(oPC) < GetLocalInt(oFrom,"R:Gold")) { SendMessageToPC(oPC,"You cannot go here because you do not have enough gold."); SetLocalInt(oPC,"Running",FALSE); return; } }
 /*Quest Exact*/ if (GetLocalString(oFrom,"R:QuestE") != "") { if (GetLocalInt(oPC,"NW_JOURNAL_ENTRY" + GetSubString(GetLocalString(oFrom,"R:QuestE"),3,GetStringLength(GetLocalString(oFrom,"R:QuestE")) - 3)) != StringToInt(GetSubString(GetLocalString(oFrom,"R:QuestE"),0,2))) { SendMessageToPC(oPC,"You cannot go here because you do not meet the quest requirements."); SetLocalInt(oPC,"Running",FALSE); return; } }
 /*Quest or Greater*/ if (GetLocalString(oFrom,"R:QuestG") != "") { if (GetLocalInt(oPC,"NW_JOURNAL_ENTRY" + GetSubString(GetLocalString(oFrom,"R:QuestG"),3,GetStringLength(GetLocalString(oFrom,"R:QuestG")) - 3)) < StringToInt(GetSubString(GetLocalString(oFrom,"R:QuestG"),0,2))) { SendMessageToPC(oPC,"You cannot go here because you do not meet the quest requirements."); SetLocalInt(oPC,"Running",FALSE); return; } }
 /*Race*/ if (GetLocalString(oFrom,"R:Race") != "") { if (GetStringLowerCase(GetSubRace(oPC)) != GetStringLowerCase(GetLocalString(oFrom,"R:Race"))) { if (GetRacialType(oPC) == RACIAL_TYPE_HUMAN && GetStringLowerCase(GetLocalString(oFrom,"R:Race")) != "human" || GetRacialType(oPC) == RACIAL_TYPE_DWARF && GetStringLowerCase(GetLocalString(oFrom,"R:Race")) != "dwarf" || GetRacialType(oPC) == RACIAL_TYPE_ELF && GetStringLowerCase(GetLocalString(oFrom,"R:Race")) != "elf" || GetRacialType(oPC) == RACIAL_TYPE_HALFLING && GetStringLowerCase(GetLocalString(oFrom,"R:Race")) != "halfling" || GetRacialType(oPC) == RACIAL_TYPE_HALFORC && GetStringLowerCase(GetLocalString(oFrom,"R:Race")) != "half-orc" || GetRacialType(oPC) == RACIAL_TYPE_GNOME && GetStringLowerCase(GetLocalString(oFrom,"R:Race")) != "gnome" || GetRacialType(oPC) == RACIAL_TYPE_HALFELF && GetStringLowerCase(GetLocalString(oFrom,"R:Race")) != "half-elf") {SendMessageToPC(oPC,"You cannot go here because you do not meet the racial requirements."); SetLocalInt(oPC,"Running",FALSE); return; } } }
 /*Gender*/ if (GetLocalString(oFrom,"R:Gender") != "") { if (GetGender(oPC) == GENDER_MALE && GetStringLowerCase(GetLocalString(oFrom,"R:Gender")) != "male" || GetGender(oPC) == GENDER_FEMALE && GetStringLowerCase(GetLocalString(oFrom,"R:Gender")) != "female")  { SendMessageToPC(oPC,"You are the wrong gender to enter here."); SetLocalInt(oPC,"Running",FALSE); return; } }

//Actions//
 /*Remove key*/ if (GetLocalInt(oFrom,"RemoveKey") != 0 && GetLocalString(oFrom,"R:Key") != "") {DestroyObject(GetItemPossessedBy(oPC,GetLocalString(oFrom,"R:Key"))); }
 /*Remove gold*/ if (GetLocalInt(oFrom,"RemoveGold") != 0 && GetLocalInt(oFrom,"R:Gold") != 0) {TakeGoldFromCreature(GetLocalInt(oFrom,"R:Gold"),oPC,TRUE); }
 /*Message during transition*/ if (GetLocalString(oFrom,"Message") != "") {SendMessageToPC(oPC,GetLocalString(oFrom,"Message")); }
 /*Update quest*/ if (GetLocalString(oFrom,"Quest") != "") { AddJournalQuestEntry(GetSubString(GetLocalString(oFrom,"Quest"),3,GetStringLength(GetLocalString(oFrom,"Quest")) - 3),StringToInt(GetSubString(GetLocalString(oFrom,"Quest"),0,2)),oPC); }
 /*Reward xp*/ if (GetLocalInt(oFrom,"Experience") != 0) { GiveXPToCreature(oPC,GetLocalInt(oFrom,"Experience")); }
                             //End Commands

AssignCommand(oPC,ClearAllActions());
AssignCommand(oPC,JumpToObject(oTo));
AssignCommand(oPC,SetLocalInt(oPC,"Running",FALSE));
}
