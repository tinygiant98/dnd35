// HCR v3.2.0 - Re-Added REALFAM code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S2_Familiar
//::////////////////////////////////////////////////////////////////////////////
/*
   This spell summons an Arcane caster's Familiar.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 27, 2001
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Inc"
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  object oMod = GetModule();
  if (GetLocalInt(oMod, "REALFAM"))
    {
     if (GetIsPC(OBJECT_SELF) &&
        !GetIsDM(OBJECT_SELF) &&
        !GetIsDMPossessed(OBJECT_SELF))
       {
        string sID = GetPlayerID(OBJECT_SELF);
        if (GetLocalInt(oMod, "FAMDIED" + sID))
          {
           if (GetGold(OBJECT_SELF) < 100)
             {
              string sMsg = "You need 100 gp's to pay for the materials.";
              SendMessageToPC(OBJECT_SELF, sMsg);
              return;
             }
           TakeGoldFromCreature(100, OBJECT_SELF, TRUE);
           DeleteLocalInt(oMod, "FAMDIED" + sID);
          }
       }
    }
  SummonFamiliar();
}
//::////////////////////////////////////////////////////////////////////////////
