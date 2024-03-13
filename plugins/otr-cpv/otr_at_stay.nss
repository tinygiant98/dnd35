/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_at_follow
//
//  Desc:  Commands the ox to stop following the PC
//
//  Author: David Bobeck 16Sep03
//
/////////////////////////////////////////////////////////
#include "otr_persist_inc"

void main()
{
  string sOxId = GetLocalString(OBJECT_SELF, "OtrOxId");
  OtrSetPersistentInt(GetModule(), sOxId + "_Following", FALSE);
  OtrSetPersistentLocation(GetModule(), sOxId + "_Location", GetLocation(OBJECT_SELF));
}
