/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cmd_config_v47
//
//  Desc:  Configuration added for Version 4.7
//
//  Author: David Bobeck 12Jan04
//
/////////////////////////////////////////////////////////

// settings applicable to CPV merchants only
int CPV_BOOL_ALLOW_PLOT_ITEMS = FALSE;
int CPV_BOOL_CONSOLIDATE_VIRTUAL_INVENTORY = FALSE; // If TRUE, adds overhead

// This flag, if TRUE, will cause all persistent CMD merchant inventory
// items with an on-hand qty that is lower than the configured initial qty
// to be restored to the initial qty on module load.
int CMD_BOOL_RESTORE_LOW_INVENTORIES_ON_LOAD = TRUE;
