/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  qcs_config_inc
//
//  Desc:  Configuration Settings
//
//  Author: Morgan Quickthrust Mar04
//
/////////////////////////////////////////////////////////

//  Force the Oxen to join the Players Party/Faction.
//  Set to TRUE if you use non-Bioware Standard Area Transitions and have the
//  need for the Oxen to transition through them while following the Player.
int OTR_OXEN_JOIN_PARTY = TRUE;

//  Charge the CPV's setup as Destination Merchants in User_Route_Init for
//  receipt of goods. They are charged whatever they are setup to buy the
//  specified Items for by their owner. If Set to FALSE, CPV's are not Charged.
int OTR_CHARGE_CPV = TRUE;

//  Don't charge the CPV setup as Destination Merchants in User_Route_Init for
//  receipt of goods if it is the Owner of the CPV delivering the Merchandise.
//  The Player delivering the Ox will receive XP, but not Gold, for delivering
//  the Ox successfully, If Set to FALSE, CPV's will be Charged when the PC
//  delivering the Ox is the CPV's owner, but the Owner will receive the Gold
//  payed out for a successful delivery. This option is only in use when
//  OTR_CHARGE_CPV = TRUE.
int OTR_DONT_CHARGE_CPV_OWNER = TRUE;

