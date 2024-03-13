// HCR Healer OnSpawn - SE
#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"

void main()
{
    // ***** Spawn-In Conditions ***** //
    // * This will cause an NPC to use common animations it possesses,
    // * and use social ones to any other nearby friendly NPCs.
    SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    // ***** DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) ***** //
    SetListeningPatterns();
    WalkWayPoints();

    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //
    SetLocalLocation(OBJECT_SELF,"spawn",GetLocation(OBJECT_SELF));//HCR - SE
    //NPC Healer
    SignalEvent(OBJECT_SELF,EventUserDefined(5000));
}
