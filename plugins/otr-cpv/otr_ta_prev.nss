/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_ta_prev
//
//  Desc:  Should the "Prev" menu item be shown.
//
//  Author: David Bobeck 12Sep03
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  if (GetLocalInt(oPC, "nOtrMenuPage") > 0)
  {
    return TRUE;
  }
  return FALSE;
}
