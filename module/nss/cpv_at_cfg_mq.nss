/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_at_cfg_mq
//
//  Desc:  Condition check
//
//  Author: David Bobeck 17Aug03
//
/////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCSpeaker();
  SetLocalString(oPC, "CpvConfigType", "MAX_QTY");
}
