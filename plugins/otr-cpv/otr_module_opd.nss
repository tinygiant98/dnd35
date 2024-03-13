/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_module_opd
//
//  Desc:  This script must be run by the module's
//         OnPlayerDeath event handler. It's used to
//         clear a player's ox.
//
//  Author: David Bobeck 14Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"

void main()
{
  object oPC = GetLastPlayerDied();
  if (GetIsPC(oPC))
  {
    OtrClearPlayersOx(oPC);
  }
}
