/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_oxen_od
//
//  Desc:  OnDeath handler for the trade route ox.
//
//  Author: David Bobeck 16Sep03
//
/////////////////////////////////////////////////////////
#include "otr_persist_inc"

void main()
{
  object oModule = GetModule();
  string sOxId = GetLocalString(OBJECT_SELF, "OtrOxId");
  OtrSetPersistentInt(oModule, sOxId + "_Following", FALSE);
  OtrSetPersistentInt(oModule, sOxId + "_IsInUse", FALSE);
}
