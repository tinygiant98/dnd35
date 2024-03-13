/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_paid_yes
//
//  Desc:  Determines the response of the trader upon
//         acquire attempt
//
//  Author: David Bobeck 18Sep03
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  return (GetLocalInt(oPC, "OtrSuccessfulAcquire") == TRUE);
}

