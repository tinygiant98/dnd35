/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_route_utils
//
//  Desc:  This collection of functions manages the
//         trade routes for OTR.
//
//  Author: David Bobeck 12sep03
//
/////////////////////////////////////////////////////////

#include "otr_config_inc"
#include "otr_persist_inc"
#include "otr_language_inc"
#include "qcs_config_inc"

int OTR_SELECTIONS_PER_PAGE = 6;

/////////////////////////////////////////////////////////
void OtrGoHungry(object oOx)
{
  string sOxId = GetLocalString(oOx, "OtrOxId");
  int nHunger = OtrGetPersistentInt(GetModule(), sOxId + "_Hunger") - 1;
  if (nHunger < 0) nHunger = 0;
  OtrSetPersistentInt(GetModule(), sOxId + "_Hunger", nHunger);

  if (nHunger == 0)
  {
    AssignCommand(oOx, ClearAllActions());
    AssignCommand(oOx, ActionDoCommand(PlaySound("as_an_cow2")));
    OtrSetPersistentInt(GetModule(), sOxId + "_Following", FALSE);
    OtrSetPersistentLocation(GetModule(), sOxId + "_Location", GetLocation(oOx));
  }
}

/////////////////////////////////////////////////////////
void OtrEatOxFood(object oOx, object oItem)
{
  // We must check the item because other oxen may have
  // reached and eaten the feed first.
  if (GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);

    if (OTR_BOOL_OXEN_REQUIRE_FEEDINGS == TRUE)
    {
      string sOxId = GetLocalString(oOx, "OtrOxId");
      int nHunger = OtrGetPersistentInt(GetModule(), sOxId + "_Hunger");
      OtrSetPersistentInt(GetModule(), sOxId + "_Hunger", nHunger + 1);

      AssignCommand(oOx, ActionDoCommand(PlaySound("as_an_cow1")));
      DelayCommand(OTR_FLOAT_SECONDS_BETWEEN_OX_FEEDINGS, OtrGoHungry(oOx));
    }
  }
}

/////////////////////////////////////////////////////////
void OtrAddRouteToArea(string sAreaTag, int nModuleRouteIndex)
{
  object oArea = GetObjectByTag(sAreaTag);
  if (oArea != OBJECT_INVALID)
  {
    int nRouteCount = GetLocalInt(oArea, "OtrAreaRouteCount") + 1;
    SetLocalInt(oArea, "OtrAreaRouteCount", nRouteCount);

    string sKeyToRoute = "OtrTradeRoute_" + IntToString(nRouteCount);
    SetLocalInt(oArea, sKeyToRoute, nModuleRouteIndex);
  }
}

/////////////////////////////////////////////////////////
string OtrCreateRoute(string sStartAreaTag, string sDestAreaTag, int nCost)
{
  object oModule = GetModule();
  int nRouteCount = GetLocalInt(oModule, "OtrModuleRouteCount") + 1;
  SetLocalInt(oModule, "OtrModuleRouteCount", nRouteCount);

  string sKeyToRoute = "OtrTradeRoute_" + IntToString(nRouteCount);
  SetLocalString(oModule, sKeyToRoute + "_StartArea", sStartAreaTag);
  SetLocalString(oModule, sKeyToRoute + "_DestArea", sDestAreaTag);
  SetLocalInt(oModule, sKeyToRoute + "_Cost", nCost);

  OtrAddRouteToArea(sStartAreaTag, nRouteCount);

  return sKeyToRoute;
}

/////////////////////////////////////////////////////////
void OtrSetRoutePayoff(string sKeyToRoute, int nPayoffGold, int nPayoffXP)
{
  object oModule = GetModule();

  SetLocalInt(oModule, sKeyToRoute + "_PayoffGold", nPayoffGold);
  SetLocalInt(oModule, sKeyToRoute + "_PayoffXP", nPayoffXP);
}

/////////////////////////////////////////////////////////
void OtrAddRouteItem(string sKeyToRoute, string sItemTag, string sItemResRef, int nItemQty, string sDestMerchTag)
{
  object oModule = GetModule();

  int nItemCount = GetLocalInt(oModule, sKeyToRoute + "_ItemCount");
  nItemCount++;
  SetLocalInt(oModule, sKeyToRoute + "_ItemCount", nItemCount);

  SetLocalString(oModule, sKeyToRoute + "_Tag_" + IntToString(nItemCount), sItemTag);
  SetLocalString(oModule, sKeyToRoute + "_ResRef_" + IntToString(nItemCount), sItemResRef);
  SetLocalInt(oModule, sKeyToRoute + "_Qty_" + IntToString(nItemCount), nItemQty);
  SetLocalString(oModule, sKeyToRoute + "_DestMerchTag_" + IntToString(nItemCount), sDestMerchTag);
}

/////////////////////////////////////////////////////////
int OtrGetAreaRouteCount(string sAreaTag)
{
  object oArea = GetObjectByTag(sAreaTag);
  if (oArea != OBJECT_INVALID)
  {
    return GetLocalInt(oArea, "OtrAreaRouteCount");
  }
  return 0;
}

/////////////////////////////////////////////////////////
string OtrGetKeyToRoute(int nRouteIndex)
{
  string sKeyToRoute = "ROUTE_INVALID";

  // Check if nRouteIndex is valid
  int nRouteCount = GetLocalInt(GetModule(), "OtrModuleRouteCount");
  if ((nRouteIndex > 0) && (nRouteIndex <= nRouteCount))
  {
    sKeyToRoute = "OtrTradeRoute_" + IntToString(nRouteIndex);
  }

  return sKeyToRoute;
}

/////////////////////////////////////////////////////////
string OtrGetKeyToRouteInArea(object oArea, int nRouteIndex)
{
  string sKeyToRoute = "ROUTE_INVALID";

  // Check if nRouteIndex is valid
  int nRouteCount = GetLocalInt(oArea, "OtrAreaRouteCount");
  if ((nRouteIndex > 0) && (nRouteIndex <= nRouteCount))
  {
    int nRefIndex = GetLocalInt(oArea, "OtrTradeRoute_" + IntToString(nRouteIndex));
    sKeyToRoute = OtrGetKeyToRoute(nRefIndex);
  }

  return sKeyToRoute;
}

/////////////////////////////////////////////////////////
int OtrCheckComponentAvailability(object oPC, string sKeyToRoute)
{
  if (sKeyToRoute == "ROUTE_INVALID")
  {
    return 0;
  }

  object oModule = GetModule();

  int nTotalBatchCount = 99;  // something obsurd
  int nItemCount = GetLocalInt(oModule, sKeyToRoute + "_ItemCount");
  int nItemIndex;
  for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
  {
    string sItemTag = GetLocalString(oModule, sKeyToRoute + "_Tag_" + IntToString(nItemIndex));
    if (sItemTag != "")
    {
      // Search the PC's inventory for this type of item
      // and tally the count.
      int nItemCount = 0;

      object oItem = GetFirstItemInInventory(oPC);
      while (oItem != OBJECT_INVALID)
      {
        if (GetTag(oItem) == sItemTag)
        {
          nItemCount += GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
      }

      int nItemQty = GetLocalInt(oModule, sKeyToRoute + "_Qty_" + IntToString(nItemIndex));
      int nBatchCount = nItemCount / nItemQty;
      if (nBatchCount < nTotalBatchCount)
      {
        nTotalBatchCount = nBatchCount;
      }
    }

    // abort early if possible
    if (nTotalBatchCount == 0) return 0;
  }

  return nTotalBatchCount;
}

/////////////////////////////////////////////////////////
int OtrShowRouteAsGreen(int nMenuIndex)
{
  object oPC = GetPCSpeaker();
  int nMenuPage = GetLocalInt(oPC, "nOtrMenuPage");
  int nRouteIndex = (nMenuPage * OTR_SELECTIONS_PER_PAGE) + nMenuIndex;
  string sKeyToRoute = OtrGetKeyToRouteInArea(GetArea(oPC), nRouteIndex);
  if (sKeyToRoute == "ROUTE_INVALID")
  {
    return FALSE;
  }

  int nBatchCount = OtrCheckComponentAvailability(oPC, sKeyToRoute);
  if (nBatchCount > 0)
  {
    return TRUE;
  }

  return FALSE;
}

/////////////////////////////////////////////////////////
int OtrShowRouteAsRed(int nMenuIndex)
{
  object oPC = GetPCSpeaker();
  int nMenuPage = GetLocalInt(oPC, "nOtrMenuPage");
  int nRouteIndex = (nMenuPage * OTR_SELECTIONS_PER_PAGE) + nMenuIndex;
  string sKeyToRoute = OtrGetKeyToRouteInArea(GetArea(oPC), nRouteIndex);
  if (sKeyToRoute == "ROUTE_INVALID")
  {
    return FALSE;
  }

  int nBatchCount = OtrCheckComponentAvailability(oPC, sKeyToRoute);
  if (nBatchCount == 0)
  {
    return TRUE;
  }

  return FALSE;
}

/////////////////////////////////////////////////////////
void OtrShowRouteMenu(int nMenuPage)
{
  object oModule = GetModule();
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC, "nOtrMenuPage", nMenuPage);

  int nRouteCount = GetLocalInt(GetArea(oPC), "OtrAreaRouteCount");

  int nFirst = (nMenuPage * OTR_SELECTIONS_PER_PAGE) + 1;
  int nLast = (nMenuPage * OTR_SELECTIONS_PER_PAGE) + OTR_SELECTIONS_PER_PAGE;
  if (nLast >= nRouteCount)
  {
    nLast = nRouteCount;
  }

  int n;
  for (n=nFirst; n<=nLast; n++)
  {
    string sTitle = OTR_TEXT_UNRECOGNIZED_AREA_TAG;

    // the route's destination area titles must be ref'd from the module
    string sKeyToRoute = OtrGetKeyToRouteInArea(GetArea(oPC), n);
    string sDestAreaTag = GetLocalString(oModule, sKeyToRoute + "_DestArea");
    int nCost = GetLocalInt(oModule, sKeyToRoute + "_Cost");
    int nPayoffGold = GetLocalInt(oModule, sKeyToRoute + "_PayoffGold");
    object oDestArea = GetObjectByTag(sDestAreaTag);
    if (oDestArea != OBJECT_INVALID)
    {
      sTitle = GetName(oDestArea) + OTR_TEXT_COST_EQUALS + IntToString(nCost) + OTR_TEXT_PAYOFF_EQUALS + IntToString(nPayoffGold) + OTR_TEXT_GPS;
    }

    SetLocalString(oPC, "sOtrTokenText" + IntToString(22001+(n-nFirst)), sTitle);
    // Note: the custom token will be set in either "otr_ta_grn" or "otr_ta_red"
  }

  SetLocalInt(oPC, "nOtrRedOffset", 1);
  SetLocalInt(oPC, "nOtrGrnOffset", 1);
}

/////////////////////////////////////////////////////////
void OtrCreateItemOnObject(string sItemTag, object oTarget, int nQty)
{
  CreateItemOnObject(sItemTag, oTarget, nQty);
}

/////////////////////////////////////////////////////////
string OtrGetEmptyOxId()
{
  object oModule = GetModule();
  string sOxId;

  int nOxCount = OtrGetPersistentInt(oModule, "OtrOxCount");

  int nOxIndex;
  for (nOxIndex=1; nOxIndex<=nOxCount; nOxIndex++)
  {
    sOxId = "OtrOx_" + IntToString(nOxIndex);
    int bOxIsInUse = OtrGetPersistentInt(oModule, sOxId + "_IsInUse");
    if (!bOxIsInUse)
    {
      OtrSetPersistentInt(oModule, sOxId + "_IsInUse", TRUE);
      return sOxId;
    }
  }

  // None empty, so add a new one
  nOxCount++;
  OtrSetPersistentInt(oModule, "OtrOxCount", nOxCount);
  sOxId = "OtrOx_" + IntToString(nOxCount);
  OtrSetPersistentInt(oModule, sOxId + "_IsInUse", TRUE);
  return sOxId;
}

/////////////////////////////////////////////////////////
void OtrMakeOxPersistent(object oOx, object oPC, string sKeyToRoute)
{
  object oModule = GetModule();

  string sOxId = OtrGetEmptyOxId();
  SetLocalString(oOx, "OtrOxId", sOxId);

  location locOx = GetLocation(oOx);
  string sPcKey = GetPCPublicCDKey(oPC);
  string sPcName = GetName(oPC);
  string sOwnerKey = sPcKey + "_" + sPcName;

  OtrSetPersistentLocation(oModule, sOxId + "_Location", locOx);
  OtrSetPersistentString(oModule, sOxId + "_OwnerKey", sOwnerKey);
  OtrSetPersistentString(oModule, sOxId + "_KeyToRoute", sKeyToRoute);
  OtrSetPersistentInt(oModule, sOxId + "_Following", FALSE);
  OtrSetPersistentInt(oModule, sOxId + "_Hunger", 1);
  SetLocalString(oPC, sOxId + "_LocalOwnerKey", sOwnerKey);
  if (OTR_BOOL_OXEN_REQUIRE_FEEDINGS == TRUE)
  {
    AssignCommand(oOx, DelayCommand(OTR_FLOAT_SECONDS_BETWEEN_OX_FEEDINGS, OtrGoHungry(oOx)));
  }

}

/////////////////////////////////////////////////////////
void OtrSpawnPlayersOx(object oPC)
{
  object oModule = GetModule();
  string sPcKey = GetPCPublicCDKey(oPC);
  string sPcName = GetName(oPC);
  string sKey = sPcKey + "_" + sPcName;

  string sOxId;

  int nOxCount = OtrGetPersistentInt(oModule, "OtrOxCount");

  int nOxIndex;
  for (nOxIndex=1; nOxIndex<=nOxCount; nOxIndex++)
  {
    sOxId = "OtrOx_" + IntToString(nOxIndex);
    int bOxIsInUse = OtrGetPersistentInt(oModule, sOxId + "_IsInUse");
    if (bOxIsInUse)
    {
      string sOwnerKey = OtrGetPersistentString(oModule, sOxId + "_OwnerKey");
      if (sOwnerKey == sKey)
      {
        int bFollowing = OtrGetPersistentInt(oModule, sOxId + "_Following");
        location locOx = OtrGetPersistentLocation(oModule, sOxId + "_Location");
        object oOx = CreateObject(OBJECT_TYPE_CREATURE, "otrTradeRouteOx", locOx, FALSE);
        SetLocalString(oOx, "OtrOxId", sOxId);

        // Add Oxen to PC Party - Change made to force Oxen to follow PC through non-standard Area Transitions
        if (OTR_OXEN_JOIN_PARTY)
        {
           AddHenchman(oPC, oOx);
        }

        if (bFollowing)
        {
          ExecuteScript("otr_at_follow", oOx);
        }

        int nHunger = OtrGetPersistentInt(oModule, sOxId + "_Hunger");
        if ((nHunger > 1) && (OTR_BOOL_OXEN_REQUIRE_FEEDINGS == TRUE))
        {
          AssignCommand(oOx, DelayCommand(OTR_FLOAT_SECONDS_BETWEEN_OX_FEEDINGS, OtrGoHungry(oOx)));
        }
      }
    }
  }
}

/////////////////////////////////////////////////////////
void OtrUnSpawnPlayersOx(object oPC)
{
  object oModule = GetModule();

  string sOxId;

  int nOxCount = OtrGetPersistentInt(oModule, "OtrOxCount");

  int nOxIndex;
  for (nOxIndex=1; nOxIndex<=nOxCount; nOxIndex++)
  {
    sOxId = "OtrOx_" + IntToString(nOxIndex);
    string sKey = GetLocalString(oPC, sOxId + "_LocalOwnerKey");
    int bOxIsInUse = OtrGetPersistentInt(oModule, sOxId + "_IsInUse");
    if (bOxIsInUse)
    {
      string sOwnerKey = OtrGetPersistentString(oModule, sOxId + "_OwnerKey");
      if (sOwnerKey == sKey)
      {
        int bFollowing = OtrGetPersistentInt(oModule, sOxId + "_Following");
        location locOx = OtrGetPersistentLocation(oModule, sOxId + "_Location");
        object oArea = GetAreaFromLocation(locOx);
        object oOx = GetFirstObjectInArea(oArea);
        int bFound = FALSE;
        while ((oOx != OBJECT_INVALID) && !bFound)
        {
          if (GetLocalString(oOx, "OtrOxId") == sOxId)
          {
            location locOxenLast = GetLocation(oOx);
            OtrSetPersistentLocation(oModule, sOxId + "_Location", locOxenLast);
            if (OTR_OXEN_JOIN_PARTY)
            {
               RemoveHenchman(oPC, oOx);
            }
            DestroyObject(oOx);
            bFound = TRUE;
          }

          oOx = GetNextObjectInArea(oArea);
        }
      }
    }
  }
}

/////////////////////////////////////////////////////////
string OtrBuildPackingListString(object oPC, string sKeyToRoute)
{
  object oModule = GetModule();

  string sRoute = OTR_TEXT_INVALID_ROUTE;
  string sDestAreaTag = GetLocalString(oModule, sKeyToRoute + "_DestArea");
  int nCost = GetLocalInt(oModule, sKeyToRoute + "_Cost");
  int nPayoffGold = GetLocalInt(oModule, sKeyToRoute + "_PayoffGold");
  object oDestArea = GetObjectByTag(sDestAreaTag);
  if (oDestArea != OBJECT_INVALID)
  {
    sRoute = GetName(oDestArea) + OTR_TEXT_COST_EQUALS + IntToString(nCost) + OTR_TEXT_PAYOFF_EQUALS + IntToString(nPayoffGold) + OTR_TEXT_GPS;
  }
  sRoute = sRoute + "\n\n";
  sRoute = sRoute + OTR_TEXT_COMPONENTS_AVAILABLE_REQUIRED + "\n";
  sRoute = sRoute + "---------------------------\n\n";
  int nItemCount = GetLocalInt(oModule, sKeyToRoute + "_ItemCount");
  int nItemIndex;
  for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
  {
    string sItemTag = GetLocalString(oModule, sKeyToRoute + "_Tag_" + IntToString(nItemIndex));
    int nItemQty = GetLocalInt(oModule, sKeyToRoute + "_Qty_" + IntToString(nItemIndex));

    if (sItemTag != "")
    {
      // Search the PC's inventory for this type of item
      // and tally the count.
      int nItemCount = 0;
      object oItem = GetFirstItemInInventory(oPC);
      while (oItem != OBJECT_INVALID)
      {
        if (GetTag(oItem) == sItemTag)
        {
          nItemCount += GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
      }

      // If oPC already has an item of sItemTag type,
      // get its name for the packing list string.
      oItem = GetItemPossessedBy(oPC, sItemTag);
      if (oItem != OBJECT_INVALID)
      {
        sRoute = sRoute + IntToString(nItemCount) + OTR_TEXT_OF + IntToString(nItemQty) + "   " + GetName(oItem) + "\n";
      }
      else
      {
        // Create a temporary instance of this object so we can get its name.
        oItem = CreateObject(OBJECT_TYPE_ITEM, sItemTag, GetLocation(oPC), FALSE);
        if (oItem != OBJECT_INVALID)
        {
          sRoute = sRoute + "0" + OTR_TEXT_OF + IntToString(nItemQty) + "   " + GetName(oItem) + "\n";
          DestroyObject(oItem);
        }
      }
    }
    else
    {
      sRoute = sRoute + "?" + OTR_TEXT_OF + IntToString(nItemQty) + "   " + OTR_TEXT_INVALID_COMPONENT + "\n";
    }
  }

  return sRoute;
}

/////////////////////////////////////////////////////////
void OtrDoSelection(int nSelIndex)
{
  object oPC = GetPCSpeaker();
  if (oPC == OBJECT_INVALID) return;

  int nMenuPage = GetLocalInt(oPC, "nOtrMenuPage");
  int nRouteIndex = (nMenuPage * OTR_SELECTIONS_PER_PAGE) + nSelIndex;
  int nRefIndex = GetLocalInt(GetArea(oPC), "OtrTradeRoute_" + IntToString(nRouteIndex));
  SetLocalInt(oPC, "OtrSelectedTradeRoute", nRefIndex);

  string sKeyToRoute = OtrGetKeyToRoute(nRefIndex);
  string sRoute = OtrBuildPackingListString(oPC, sKeyToRoute);
  SetLocalString(oPC, "sOtrTokenText22000", sRoute);
  // Note: the custom token will be set in "otr_ta_tok_22000".
}

/////////////////////////////////////////////////////////
void OtrClearPlayersOx(object oPC)
{
  object oModule = GetModule();

  string sPcKey = GetPCPublicCDKey(oPC);
  string sPcName = GetName(oPC);
  string sKey = sPcKey + "_" + sPcName;

  string sOxId;

  int nOxCount = OtrGetPersistentInt(oModule, "OtrOxCount");

  int nOxIndex;
  for (nOxIndex=1; nOxIndex<=nOxCount; nOxIndex++)
  {
    sOxId = "OtrOx_" + IntToString(nOxIndex);
    int bOxIsInUse = OtrGetPersistentInt(oModule, sOxId + "_IsInUse");
    if (bOxIsInUse)
    {
      string sOwnerKey = OtrGetPersistentString(oModule, sOxId + "_OwnerKey");
      if (sOwnerKey == sKey)
      {
        int nIndex = 0;
        object oOx = GetObjectByTag("otrTradeRouteOx", nIndex);
        while (oOx != OBJECT_INVALID)
        {
          if (GetLocalString(oOx, "OtrOxId") == sOxId)
          {
             if (OTR_OXEN_JOIN_PARTY)
             {
                RemoveHenchman(oPC, oOx);
             }
             OtrSetPersistentInt(oModule, sOxId + "_Following", FALSE);
             OtrSetPersistentInt(oModule, sOxId + "_IsInUse", FALSE);
          }

          nIndex = nIndex + 1;
          oOx = GetObjectByTag("otrTradeRouteOx", nIndex);
        }
      }
    }
  }
}
/////////////////////////////////////////////////////////
void OtrUseDestMerch(string sKeyToRoute, string sUseDestMerch)
{
  object oModule = GetModule();

  SetLocalString(oModule, sKeyToRoute + "_UseDestMerch", sUseDestMerch);
}


