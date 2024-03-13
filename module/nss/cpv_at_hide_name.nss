/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_at_hide_name
//
//  Desc:  The vendor's greeting will not show the
//         employer's name.
//
//  Author: David Bobeck 14Nov03
//
/////////////////////////////////////////////////////////
#include "cpv_persist_inc"
void main()
{
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvShowName", FALSE);
}
