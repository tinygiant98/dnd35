/*  DOA Gold Encumbrance System 1.0
    Den, Project Lead at Carpe Terra (http://carpeterra.com)
    Modified by CFX for HCR v3.03b*/

//HCR Addition
#include "hc_inc"

void main() {
    object oPC = OBJECT_SELF;
    int iNewGold = GetGold(oPC);

    //Check for System turned on or not
    int nDoGoldSys = GetLocalInt(oMod,"GOLDENCUMBER");
    if(nDoGoldSys == 0) iNewGold = 0;

    if ((GetLocalInt(oPC, "doa_gold") / 500) != (iNewGold/500)) ExecuteScript("doa_goldencum", oPC);

    DelayCommand(15.0, AssignCommand(oPC, ExecuteScript("gbl_pc_heartbeat", oPC)));
}
