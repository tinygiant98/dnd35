/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  c
//
//  Desc:  Determines the response of the trader upon
//         drop off attempt
//
//  Author: David Bobeck 16Sep03
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  return (GetLocalInt(oPC, "OtrSuccessfulDropOff") == FALSE);
}

