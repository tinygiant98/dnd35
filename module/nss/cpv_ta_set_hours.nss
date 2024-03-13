/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_set_hours
//
//  Desc:  Condition check
//
//  Author: David Bobeck 10Aug03
//
/////////////////////////////////////////////////////////
#include "cpv_persist_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nWagePerDay = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvWage");
  SetCustomToken(27030, IntToString(nWagePerDay));

  int nDaysAdjusted = GetLocalInt(OBJECT_SELF, "CpvDaysAdjusted");
  SetCustomToken(27040, IntToString(nDaysAdjusted));
  
  float fSecsOnContract = HoursToSeconds(nDaysAdjusted * 24);
  float fMinsOnContract = fSecsOnContract/60.0;
  float fHoursOnContract = fMinsOnContract/60.0;
  float fDaysOnContract = fHoursOnContract/24.0;
  string sTimeInRealLifeDays = FloatToString(fDaysOnContract);
  
  // truncate to 2 decimal places
  sTimeInRealLifeDays = GetStringLeft(sTimeInRealLifeDays, GetStringLength(sTimeInRealLifeDays)-7);
  
  // remove padding on left
  while (GetStringLeft(sTimeInRealLifeDays, 1) == " ")
  {
    sTimeInRealLifeDays = GetStringRight(sTimeInRealLifeDays, GetStringLength(sTimeInRealLifeDays)-1);
  }

  SetCustomToken(27041, sTimeInRealLifeDays);

  SetCustomToken(28000, "(You have " + IntToString(GetGold(oPC)) + "gps)");

  return TRUE;
}
