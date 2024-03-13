/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_at_next
//
//  Desc:  Changes to the next route menu page
//
//  Author: David Bobeck 13Sep03
//
/////////////////////////////////////////////////////////
void main()
{
  object oPC = GetPCSpeaker();
  int nMenuPage = GetLocalInt(oPC, "nOtrMenuPage") + 1;
  SetLocalInt(oPC, "nOtrMenuPage", nMenuPage);
  // the convo script will call "otr_ta_top" next
}
