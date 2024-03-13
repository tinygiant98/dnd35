// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_Fugue_Exit
//::////////////////////////////////////////////////////////////////////////////
/*

*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_DCorpse"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    object oPC = GetExitingObject();
    string sID = GetPlayerID(oPC);

    // If the object is a DM or not a PC, abort.
    if (!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
        return;

    // Clear Immortal and set the player state.
    SetImmortal(oPC, FALSE);
    SPS(oPC, PWS_PLAYER_STATE_ALIVE);

    // Remove the "copied" corpse.
    DelayCommand(0.5, DestroyCorpse(oPC));

    // Remove the PCT.
    object oPCorpse = GetLocalObject(oMod, "PlayerCorpse" + sID);
    DestroyObject(oPCorpse);

    // Remove the Death Corpse.
    object oDC = GetLocalObject(oMod, "DeathCorpse" + sID);
    DelayCommand(0.6, DestroyObject(oDC));
}
//::////////////////////////////////////////////////////////////////////////////
