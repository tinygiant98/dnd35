/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_persist_inc
//
//  Desc:  These functions are collected together to
//         facilitate interfacing to a persistent database.
//
//  Author: David Bobeck 18Aug03
//
/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
void CpvSetPersistentInt(object oHost, string sVarName, int nValue)
{
  SetCampaignInt("cpv_misc", sVarName, nValue, oHost);
}
 
/////////////////////////////////////////////////////////
int CpvGetPersistentInt(object oHost, string sVarName)
{
  return GetCampaignInt("cpv_misc", sVarName, oHost);
}
 
/////////////////////////////////////////////////////////
void CpvDeletePersistentInt(object oHost, string sVarName)
{
  SetCampaignInt("cpv_misc", sVarName, 0, oHost);
}
 
/////////////////////////////////////////////////////////
void CpvSetPersistentString(object oHost, string sVarName, string sValue)
{
  SetCampaignString("cpv_misc", sVarName, sValue, oHost);
}
 
/////////////////////////////////////////////////////////
string CpvGetPersistentString(object oHost, string sVarName)
{
  return GetCampaignString("cpv_misc", sVarName, oHost);
}

/////////////////////////////////////////////////////////
void CpvDeletePersistentString(object oHost, string sVarName)
{
  SetCampaignString("cpv_misc", sVarName, "", oHost);
}
 
/////////////////////////////////////////////////////////
void CpvSetPersistentLocation(object oHost, string sVarName, location locValue)
{
  object oArea = GetAreaFromLocation(locValue);
  string sAreaTag = GetTag(oArea);
  
  SetCampaignLocation("cpv_misc", sVarName, locValue, oHost);
  SetCampaignString("cpv_misc", sVarName+"_", sAreaTag, oHost);
}
 
/////////////////////////////////////////////////////////
location CpvGetPersistentLocation(object oHost, string sVarName)
{
  location locValue = GetCampaignLocation("cpv_misc", sVarName, oHost);
  string sAreaTag = GetCampaignString("cpv_misc", sVarName+"_", oHost);
  
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

