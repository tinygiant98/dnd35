/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_cfg_ss
//
//  Desc:  Condition check
//
//  Author: David Bobeck 10Aug03
//
/////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sConfigType = GetLocalString(oPC, "CpvConfigType");
  if (sConfigType == "SET_SIZE") return FALSE;
  return TRUE;
}
