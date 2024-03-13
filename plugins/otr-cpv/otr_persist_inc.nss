/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_persist_inc
//
//  Desc:  These functions are collected together to
//         facilitate interfacing to a persistent database.
//
//  Author: David Bobeck 12Sep03
//
/////////////////////////////////////////////////////////
// #include "your_persistent_db_inc_here"
// Note: no include is required to use Bioware's database.
#include "aps_include"

/////////////////////////////////////////////////////////
void OtrSetPersistentInt(object oHost, string sVarName, int nValue)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for storing Integers in your Database

  // uncomment the following line for NO database support
  //SetLocalInt(oHost, sVarName, nValue);

  // uncomment the following line for Bioware database support
  SetCampaignInt("otr_misc", sVarName, nValue, oHost);

  // uncomment the following line for APS database support
  //SetPersistentInt(oHost, sVarName, nValue, 0, "otr_misc");
}

/////////////////////////////////////////////////////////
int OtrGetPersistentInt(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Integers from your Database

  // uncomment the following line for NO database support
  //return GetLocalInt(oHost, sVarName);

  // uncomment the following line for Bioware database support
  return GetCampaignInt("otr_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //return GetPersistentInt(oHost, sVarName, "otr_misc");
}

/////////////////////////////////////////////////////////
void OtrDeletePersistentInt(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Strings from your Database

  // uncomment the following line for Bioware database support
  SetCampaignInt("otr_misc", sVarName, 0, oHost);

  // uncomment the following line for APS database support
  //DeletePersistentVariable(oHost, sVarName, "otr_misc");
}

/////////////////////////////////////////////////////////
void OtrSetPersistentFloat(object oHost, string sVarName, float fValue)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for storing Floats in your Database

  // uncomment the following line for NO database support
  //SetLocalFloat(oHost, sVarName, fValue);

  // uncomment the following line for Bioware database support
  SetCampaignFloat("otr_misc", sVarName, fValue, oHost);

  // uncomment the following line for APS database support
  //SetPersistentFloat(oHost, sVarName, fValue, 0, "otr_misc");
}

/////////////////////////////////////////////////////////
float OtrGetPersistentFloat(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Floats from your Database

  // uncomment the following line for NO database support
  //return GetLocalFloat(oHost, sVarName);

  // uncomment the following line for Bioware database support
  return GetCampaignFloat("otr_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //return GetPersistentFloat(oHost, sVarName, "otr_misc");
}

/////////////////////////////////////////////////////////
void OtrDeletePersistentFloat(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Strings from your Database

  // uncomment the following line for Bioware database support
  SetCampaignInt("otr_misc", sVarName, 0, oHost);

  // uncomment the following line for APS database support
  //DeletePersistentVariable(oHost, sVarName, "otr_misc");
}

/////////////////////////////////////////////////////////
void OtrSetPersistentString(object oHost, string sVarName, string sValue)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for storing Strings in your Database

  // uncomment the following line for NO database support
  //SetLocalString(oHost, sVarName, sValue);

  // uncomment the following line for Bioware database support
  SetCampaignString("otr_misc", sVarName, sValue, oHost);

  // uncomment the following line for APS database support
  //SetPersistentString(oHost, sVarName, sValue, 0, "otr_misc");
}

/////////////////////////////////////////////////////////
string OtrGetPersistentString(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Strings from your Database

  // uncomment the following line for NO database support
  //return GetLocalString(oHost, sVarName);

  // uncomment the following line for Bioware database support
  return GetCampaignString("otr_misc", sVarName, oHost);

  // uncomment the following line for APS database support
  //return GetPersistentString(oHost, sVarName, "otr_misc");

}

/////////////////////////////////////////////////////////
void OtrDeletePersistentString(object oHost, string sVarName)
{
  // Change this function call to whatever function
  // should be called from the above include file
  // for retrieving Strings from your Database

  // uncomment the following line for Bioware database support
  SetCampaignString("otr_misc", sVarName, "", oHost);

  // uncomment the following line for APS database support
  //DeletePersistentVariable(oHost, sVarName, "otr_misc");
}

/////////////////////////////////////////////////////////
void OtrSetPersistentLocation(object oHost, string sVarName, location locValue)
{
  object oArea = GetAreaFromLocation(locValue);
  string sAreaTag = GetTag(oArea);

  // uncomment the following line for Bioware database support
  SetCampaignLocation("otr_misc", sVarName, locValue, oHost);
  SetCampaignString("otr_misc", sVarName+"_", sAreaTag, oHost);

  // uncomment the following line for APS database support
  //SetPersistentLocation(oHost, sVarName, locValue, 0, "otr_misc");
  //SetPersistentString(oHost, sVarName+"_", sAreaTag, 0, "otr_misc");
}

/////////////////////////////////////////////////////////
location OtrGetPersistentLocation(object oHost, string sVarName)
{
  // uncomment the following line for Bioware database support
  location locValue = GetCampaignLocation("otr_misc", sVarName, oHost);
  string sAreaTag = GetCampaignString("otr_misc", sVarName+"_", oHost);

  // uncomment the following line for APS database support
  //location locValue = GetPersistentLocation(oHost, sVarName, "otr_misc");
  //string sAreaTag = GetPersistentString(oHost, sVarName+"_", "otr_misc");

  object oArea = GetObjectByTag(sAreaTag);
  if (GetIsObjectValid(oArea))
  {
    vector vPosition = GetPositionFromLocation(locValue);
    float fFacing = GetFacingFromLocation(locValue);

    locValue = Location(oArea, vPosition, fFacing);
    return locValue;
  }
  else
  {
    return GetStartingLocation();
  }
}
