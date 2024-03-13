////////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_module_ocl
//
//  Desc:  This script must be run by the module's
//         OnClientLeave event handler. It's used to
//         remove a players ox.
//
//  Author: David Bobeck 16Sep03, Morgan Quickthrust Mar04
//
////////////////////////////////////////////////////////////
#include "otr_route_utils"

void main()
{
   object oPC = GetExitingObject();
   OtrUnSpawnPlayersOx(oPC);
}

