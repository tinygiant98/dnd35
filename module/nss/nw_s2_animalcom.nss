// HCR v3.2.0 - Re-Added fix by Jamos to use PHB caster level rule.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S2_AnimalCom
//::////////////////////////////////////////////////////////////////////////////
/*
   This spell summons a Ranger's or Druid's Animal Companion.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 27, 2001
//::////////////////////////////////////////////////////////////////////////////
void HCR_RemoveAnimalCompanion(object oAC)
{
  AssignCommand(oAC, ClearAllActions(TRUE));
  DestroyObject(oAC);
  string sMsg = "The animal wanders off. It is too powerful for";
  sMsg += " you to keep it's loyalty for a long period of time.";
  SendMessageToPC(OBJECT_SELF, sMsg);
}
//::////////////////////////////////////////////////////////////////////////////
void HCR_CheckCompanionStrength()
{
  object oAC = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION);
  if (GetIsObjectValid(oAC))
    {
     int nMCL;
     int nAHD = GetHitDice(oAC);
     int nDCL = GetLevelByClass(CLASS_TYPE_DRUID);
     int nRCL = (GetLevelByClass(CLASS_TYPE_RANGER)/2);
     if (nRCL > nDCL)
       { nMCL = nRCL; }
     else
       { nMCL = nDCL; }

     if ((nAHD > (nMCL+4)) || (nAHD > (nMCL*2)))
       { HCR_RemoveAnimalCompanion(oAC); }
     else if (nAHD > nMCL)
       {
        if (nMCL == 1 && (nAHD-nMCL == 1)) { return; }

        float fDelay = IntToFloat(240-((nAHD-nMCL)*60));
        DelayCommand(fDelay, HCR_RemoveAnimalCompanion(oAC));
       }
    }
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  SummonAnimalCompanion();
  if (GetLocalInt(GetModule(), "REALFAM") == TRUE)
    { HCR_CheckCompanionStrength(); }
}
//::////////////////////////////////////////////////////////////////////////////
