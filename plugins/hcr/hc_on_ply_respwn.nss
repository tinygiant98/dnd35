// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Ply_Respwn
//::////////////////////////////////////////////////////////////////////////////
/*
     This goes in OnPlayerRespawn in Module Properties Events. It checks to see
    if the player has a god, and if so whether or not he feels like listening to
    them. As is now, they can pray as often as they want, with a 3% chance. (May
    set time limit or bad effect for annoying your God later). To go to normal
    respawn just comment out the section as noted below.
*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_On_Respwn"
#include "HC_Inc_RemEff"
#include "HC_Inc_RezPen"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    if (!preEvent())
        return;

    location lLoc;
    object oRespawner = GetLastRespawnButtonPresser();
    string sID = (GetName(oRespawner) + GetPCPlayerName(oRespawner));

    // Bring the player back to life and remove any lingering effects.
    int nHeal = GetMaxHitPoints(oRespawner);
    effect eHeal = EffectHeal(nHeal);
    effect eRez  = EffectResurrection();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRez,  oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oRespawner);
    HCR_RemoveEffects(oRespawner);

    if (GetLocalInt(oMod, "LIMBO"))
    {
        lLoc = GetPersistentLocation(oMod, "DIED_HERE" + sID);
        AssignCommand(oRespawner, JumpToLocation(lLoc));
    }

    if (GetPersistentInt(oMod, "REZPEN" + sID))
    {
        DelayCommand(2.0, hcRezPenalty(oRespawner));
        DeletePersistentInt(oMod, "REZPEN" + sID);
    }

    // Clean up their player corpse token if one exists.
    if (GetLocalInt(oMod, "LOOTSYSTEM"))
    {
        object oPCT = GetLocalObject(oMod, "PlayerCorpse" + sID);
        if (GetIsObjectValid(oPCT))
            DestroyObject(oPCT);
    }



    // At this point they are respawned where they stand. If you want to move
    // them to safety, you should do so here.



    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
