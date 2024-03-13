// sr6.1
// this script will make a npc go into combat mode if the npc
// sees or hears the pc

#include "NW_I0_GENERIC"

void main()
{
object oNPC = OBJECT_SELF;
object oPC = GetNearestSeenOrHeardEnemy();
if (GetIsObjectValid(oPC))
   DetermineCombatRound();
}
