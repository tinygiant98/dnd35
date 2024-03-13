/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cmd_persist_inc
//
//  Desc:  These functions are collected together to
//         facilitate interfacing to a persistent database.
//
//  Author: David Bobeck 14Jun03
//
/////////////////////////////////////////////////////////

// #include "your_persistent_db_inc_here"
// Note: no include is required to use Bioware's database.
//#include "aps_include"
 
// CMD defined return codes for CmdSQLFetch()
int CMD_SQL_ERROR = 0;
int CMD_SQL_SUCCESS = 1;

/////////////////////////////////////////////////////////
void CmdSetPersistentInt(object oHost, string sVarName, int nValue)
{
  // Change this function call to whatever function 
  // should be called from the above include file
  // for storing Integers in your Database
  
  // uncomment the following line for Bioware database support
  SetCampaignInt("cmd_misc", sVarName, nValue, oHost);

  // uncomment the following line for APS database support
  //SetPersistentInt(oHost, sVarName, nValue, 0, "cmd_misc");
}
 
/////////////////////////////////////////////////////////
int CmdGetPersistentInt(object oHost, string sVarName)
{
  // Change this function call to whatever function 
  // should be called from the above include file
  // for retrieving Integers from your Database

  // uncomment the following line for Bioware database support
  return GetCampaignInt("cmd_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //return GetPersistentInt(oHost, sVarName, "cmd_misc");
}
 
/////////////////////////////////////////////////////////
void CmdSetPersistentString(object oHost, string sVarName, string sValue)
{
  // Change this function call to whatever function 
  // should be called from the above include file
  // for storing Strings in your Database   

  // uncomment the following line for Bioware database support
  SetCampaignString("cmd_misc", sVarName, sValue, oHost);

  // uncomment the following line for APS database support
  //SetPersistentString(oHost, sVarName, sValue, 0, "cmd_misc");
}
 
/////////////////////////////////////////////////////////
string CmdGetPersistentString(object oHost, string sVarName)
{
  // Change this function call to whatever function 
  // should be called from the above include file
  // for retrieving Strings from your Database   

  // uncomment the following line for Bioware database support
  return GetCampaignString("cmd_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //return GetPersistentString(oHost, sVarName, "cmd_misc");
}

/////////////////////////////////////////////////////////
void CmdSQLExecDirect(string sSQL)
{
  // If you're using APS, uncomment the following line
  //SQLExecDirect(sSQL);
}
 
/////////////////////////////////////////////////////////
int CmdSQLFetch()
{
  // If you're using APS, comment out the following line
  return CMD_SQL_ERROR;

  // If you're using APS, uncomment the following line
  //return SQLFetch();
}

/////////////////////////////////////////////////////////
string CmdSQLGetData(int iCol)
{
  // If you're using APS, comment out the following line
  return "";

  // If you're using APS, uncomment the following line
  //return SQLGetData(iCol);
}
