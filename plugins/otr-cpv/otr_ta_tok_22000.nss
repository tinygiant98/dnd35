/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_tok_22000
//
//  Desc:  Updates the custom token 22000.
//
//  Author: David Bobeck 13Sep03
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sTokenText = GetLocalString(oPC, "sOtrTokenText22000");
  SetCustomToken(22000, sTokenText);
  DeleteLocalString(oPC, "sOtrTokenText22000");
  return TRUE;
}
