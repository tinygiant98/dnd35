/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_merch_init
//
//  Desc:  merchant initialization. This script should
//  executed from the module's OnModuleLoad handler. If
//  you are using CNR, this script is called from
//  "cnr_module_oml"
//
//  Author: David Bobeck 15Dec02
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void main()
{
  // The newline char for use in convo dialogs since
  // carriage returns produce ugly boxes.
  SetCustomToken(500, "\n");

  // Set up fancy colors for the convos
  object oLiteColors = CreateObject(OBJECT_TYPE_PLACEABLE, "cmdLiteColors", GetStartingLocation(), FALSE);
  string sLiteColors = GetName(oLiteColors);
  DestroyObject(oLiteColors);

  object oModule = GetModule();
  SetLocalString(oModule, "CmdColorWhite", GetSubString(sLiteColors, 0, 6));  //white
  SetLocalString(oModule, "CmdColorLtYellow", GetSubString(sLiteColors, 6, 6));  //lt yellow
  SetLocalString(oModule, "CmdColorLtMagenta", GetSubString(sLiteColors, 12, 6)); //lt magenta
  SetLocalString(oModule, "CmdColorLtCyan", GetSubString(sLiteColors, 18, 6)); //lt cyan
  SetLocalString(oModule, "CmdColorLtRed", GetSubString(sLiteColors, 24, 6)); //lt red
  SetLocalString(oModule, "CmdColorLtGreen", GetSubString(sLiteColors, 30, 6)); //lt green
  SetLocalString(oModule, "CmdColorLtBlue", GetSubString(sLiteColors, 36, 6)); //lt blue
  
  SetCustomToken(51001, GetSubString(sLiteColors, 0, 6));  //white
  SetCustomToken(51002, GetSubString(sLiteColors, 6, 6));  //lt yellow
  SetCustomToken(51003, GetSubString(sLiteColors, 12, 6)); //lt magenta
  SetCustomToken(51004, GetSubString(sLiteColors, 18, 6)); //lt cyan
  SetCustomToken(51005, GetSubString(sLiteColors, 24, 6)); //lt red
  SetCustomToken(51006, GetSubString(sLiteColors, 30, 6)); //lt green
  SetCustomToken(51007, GetSubString(sLiteColors, 36, 6)); //lt blue

  object oDarkColors = CreateObject(OBJECT_TYPE_PLACEABLE, "cmdDarkColors", GetStartingLocation(), FALSE);
  string sDarkColors = GetName(oDarkColors);
  DestroyObject(oDarkColors);

  SetLocalString(oModule, "CmdColorGray", GetSubString(sDarkColors, 0, 6));  //gray
  SetLocalString(oModule, "CmdColorDkYellow", GetSubString(sDarkColors, 6, 6));  //dk yellow
  SetLocalString(oModule, "CmdColorDkMagenta", GetSubString(sDarkColors, 12, 6)); //dk magenta
  SetLocalString(oModule, "CmdColorDkCyan", GetSubString(sDarkColors, 18, 6)); //dk cyan
  SetLocalString(oModule, "CmdColorDkRed", GetSubString(sDarkColors, 24, 6)); //dk red
  SetLocalString(oModule, "CmdColorDkGreen", GetSubString(sDarkColors, 30, 6)); //dk green
  SetLocalString(oModule, "CmdColorDkBlue", GetSubString(sDarkColors, 36, 6)); //dk blue

  SetCustomToken(51011, GetSubString(sDarkColors, 0, 6));  //gray
  SetCustomToken(51012, GetSubString(sDarkColors, 6, 6));  //dk yellow
  SetCustomToken(51013, GetSubString(sDarkColors, 12, 6)); //dk magenta
  SetCustomToken(51014, GetSubString(sDarkColors, 18, 6)); //dk cyan
  SetCustomToken(51015, GetSubString(sDarkColors, 24, 6)); //dk red
  SetCustomToken(51016, GetSubString(sDarkColors, 30, 6)); //dk green
  SetCustomToken(51017, GetSubString(sDarkColors, 36, 6)); //dk blue

  ///////////////////////////////////////////////
  // if cmd_misc table does not exist, create it
  ///////////////////////////////////////////////
  CmdSQLExecDirect("DESCRIBE cmd_misc");
  if (CmdSQLFetch() != CMD_SQL_SUCCESS)
  {
    /*
    // For Access
    CmdSQLExecDirect("CREATE TABLE cmd_misc (" +
                  "player text(64)," +
                  "tag text(64)," +
                  "name text(64)," +
                  "val memo," +
                  "expire text(4)," +
                  "last date)");
    */

    // for MySQL
    CmdSQLExecDirect("CREATE TABLE cmd_misc (" +
                  "`player` VARCHAR(64) default NULL," +
                  "`tag` VARCHAR(64) default NULL," +
                  "`name` VARCHAR(64) default NULL," +
                  "`val` TEXT," +
                  "`expire` SMALLINT UNSIGNED default NULL," +
                  "`last` TIMESTAMP(14) NOT NULL," +
                  "KEY idx (player,tag,name)" +
                  ")" );
  }

  /////////////////////////////////////////////////////////
  // DO NOT ADD YOUR CODE TO THIS FILE.....
  // Module builders: You should create and add your merchant lists
  // to the file "user_merch_init" so that future versions
  // of CMD or CNR don't over-write your work - Your call thou.
  /////////////////////////////////////////////////////////
  ExecuteScript("user_merch_init", OBJECT_SELF);

  /*
  /////////////////////////////////////////////////////////
  // This code provide as a sample. However, I encourage
  // you to use MerchantMaker to generate the code for you.
  /////////////////////////////////////////////////////////
  CnrMerchantEnablePersistentInventory("Dusty");
  CnrMerchantAddItem("Dusty", "Bless Potion", "NW_IT_MPOTION009", 30, 35, TRUE);
  CnrMerchantAddPersistentItem("Dusty", "Skeleton's Knuckle", "NW_IT_MSMLMISC13", 20, 20, 2, 5);
  CnrMerchantAddItem("Dusty", "Empty Bottle", "NW_IT_THNMISC001", 0, 1, TRUE);
  CnrMerchantAddItem("Dusty", "Wine", "NW_IT_MPOTION023", 5, 0, FALSE, 2);
  CnrMerchantAddPersistentItem("Dusty", "Silver Ring", "NW_HEN_GRI1QT", 0, 10, 2, 2);
  // AddItem2 is used here because the tag and resref have different spellings
  CnrMerchantAddItem2("Dusty", "Stinky Fish", "TestFishTag", "testfishresref", 1, 1, TRUE);

  CnrMerchantSetMerchantGreetingText("Sandy", "Sandy's custom greeting text!");
  CnrMerchantSetMerchantBuyText("Sandy", "Sandy's custom buy text!");
  CnrMerchantSetMerchantSellText("Sandy", "Sandy's custom sell text!");
  CnrMerchantAddItem("Sandy", "Bless Potion", "NW_IT_MPOTION009", 30, 35, TRUE);
  CnrMerchantAddItem("Sandy", "Skeleton's Knuckle", "NW_IT_MSMLMISC13", 20, 20, FALSE);
  CnrMerchantAddItem("Sandy", "Empty Bottle", "NW_IT_THNMISC001", 1, 0, TRUE);
  CnrMerchantAddItem("Sandy", "Wine", "NW_IT_MPOTION023", 0, 5, TRUE);
  CnrMerchantAddItem("Sandy", "Silver Ring", "NW_HEN_GRI1QT", 0, 10, FALSE);
  // AddItem2 is used here because the tag and resref have different spellings
  CnrMerchantAddItem2("Sandy", "Stinky Fish", "TestFishTag", "testfishresref", 1, 1, TRUE);
  */

  //CnrAddMerchant ("Dusty");
  //CnrAddMerchant ("Sandy");

  // this call is asynchronous - it uses AssignCommand to avoid TMI
  CmdLoadAllMerchantsFromScript();
}

