//:://///////////////////////////////////////////////////
//:: Name Check for Death Corpse
//:: FileName hc_healer_op
//:://///////////////////////////////////////////////////
/*
   Check if player is carrying a player death corpse.
   If so speak a one liner.
*/
//:://///////////////////////////////////////////////////
//:: Created By: Sir Elric
//:: Created On: 2003
//:: Revised On: 26th January, 2006
//:://///////////////////////////////////////////////////

// Make the caller face oTarget
void SetFacingObject(object oTarget);
void SetFacingObject(object oTarget)
{
   vector vFace = GetPosition(oTarget);
   SetFacingPoint(vFace);
}

void main()
{
   object oPerceived = GetLastPerceived();
   if(GetIsInCombat(OBJECT_SELF) || IsInConversation(OBJECT_SELF)) return;
   if(!GetIsDMPossessed(oPerceived) || GetIsDM(oPerceived) && GetIsPC(oPerceived) && GetLastPerceptionSeen())
   {
       if(GetIsObjectValid(GetItemPossessedBy(oPerceived, "PlayerCorpse")))
       {
           SetFacingObject(oPerceived);
           ClearAllActions();
           ActionSpeakString("Another fallen soul...");
       }
    }
}
