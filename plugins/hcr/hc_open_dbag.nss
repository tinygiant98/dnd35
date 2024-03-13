// HCR v3.2.0 - Added deletion of local variable to fix gold being given twice.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName: HC_Open_DBag
//::////////////////////////////////////////////////////////////////////////////
/*
   If the Hardcore Death system is in use, putting this script in the OnOpen
  event of the Dropped Bag object will cause the bag to identify its owner
  whenever it is opened. If you wish to have it also identify the person looting
  the bag, uncomment lines 26-28 and comment out line 25. You may change the
  text between the quotes of line 28 to say whatever you wish when someone loots
  a dropped bag.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Jamos
//:: Created On: Oct 21
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
#include "HC_Inc_Transfer"
#include "HC_Text_Health"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    object oCorpse = OBJECT_SELF;
    string sOwner = GetLocalString(oCorpse, "Name");
    string sFeedback = (BAGOF + sOwner);
    //object oLooter = GetLastOpenedBy();
    //string sLooter = GetName(oLooter);
    //string sFeedback = sLooter + " is looting the inventory of " + sOwner;

    SpeakString(sFeedback);

    object oOwner = GetLocalObject(oCorpse, "Owner");
    if (oOwner != GetLastOpenedBy())
        return;

    // Alternate transfer code.
    // Enable AUTOTRANS in hc_defaults to use this if you want to automatically
    // transfer all items to owner when he opens his drop bag.
    if (!GetLocalInt(oMod, "AUTOTRANS"))
        return;

    //int nAmtGold = GetLocalInt(oCorpse, "AmtGold");
    //DeleteLocalInt(oCorpse, "AmtGold");
    //AssignCommand(oCorpse, GiveGoldToCreature(oOwner, nAmtGold));
    hcTakeObjects(oCorpse, oOwner, 0);

    // Persistence code.
    //int nPersist = GetLocalInt(GetModule(), "PERSIST");
    //if (nPersist)
    //    ExecuteScript("hc_storedb", oOwner);
}
//::////////////////////////////////////////////////////////////////////////////
