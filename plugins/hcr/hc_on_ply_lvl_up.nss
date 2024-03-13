// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Ply_Lvl_Up
//::////////////////////////////////////////////////////////////////////////////
/*

*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_On_Level"
#include "HC_Text_Lvl"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    if (!preEvent())
        return;

    object oPC  = GetPCLevellingUp();
    string sCDK = GetPCPlayerName(oPC);
    int nHD = GetHitDice(oPC);
    if (GetLocalInt(oMod, "LEVELTRAINER"))
    {
        if (!GetPersistentInt(oPC, "ALLOWLEVEL"))
        {
            // Did not pay for training.
            SendMessageToPC(oPC, GAINLEVEL);
            int nNewXP = (((nHD*(nHD-1))/2*1000)-1);
            SetXP(oPC, nNewXP);
        }
        else
        {
            DeletePersistentInt(oPC, "ALLOWLEVEL");
        }
    }

    postEvent();
}
//::////////////////////////////////////////////////////////////////////////////
