/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_module_oce
//
//  Desc:  This script must be run by the module's
//         OnClientEnter event handler. It's used to
//         restore a player's ox.
//
//  Author: David Bobeck 14Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"

void main()
{
  object oPC = GetEnteringObject();
  if (GetIsPC(oPC))
  {
    OtrSpawnPlayersOx(oPC);
  }
}
