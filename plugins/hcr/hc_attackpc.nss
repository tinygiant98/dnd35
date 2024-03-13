//sr6.1
// fixed code where it wasnt attacking.
// sr6.0
// changed npc code.
// 5.5
// new code to help ai when a player is ressed or gets back up from dying that creatures around
// him reattack him.

void main()
{
 object oPC = OBJECT_SELF;
 object oNPC = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, 1,
               CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, CREATURE_TYPE_IS_ALIVE, TRUE);
 if (GetIsObjectValid(oNPC) && !GetIsInCombat(oNPC))
    ExecuteScript("hc_startcombat", oNPC);
}
