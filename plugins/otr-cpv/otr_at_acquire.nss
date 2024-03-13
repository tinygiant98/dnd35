/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_at_acquire
//
//  Desc:  Procure an ox for a route.
//
//  Author: David Bobeck 13Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"

void main()
{
  //OtrAcquireOxForRoute();
  object oModule = GetModule();
  object oPC = GetPCSpeaker();
  if (oPC == OBJECT_INVALID) return;

  int nRefIndex = GetLocalInt(oPC, "OtrSelectedTradeRoute");

  string sKeyToRoute = OtrGetKeyToRoute(nRefIndex);
  if (sKeyToRoute == "ROUTE_INVALID")
  {
    return;
  }

  // Check that the PC has enough gold before continuing
  SetLocalInt(oPC, "OtrSuccessfulAcquire", FALSE);
  int nGold = GetGold(oPC);
  int nCost = GetLocalInt(oModule, sKeyToRoute + "_Cost");
  if (nCost > nGold)
  {
    return;
  }

  SetLocalInt(oPC, "OtrSuccessfulAcquire", TRUE);
  TakeGoldFromCreature(nCost, oPC, TRUE);

  location locOxSpawn = GetLocation(OBJECT_SELF);
  object oWP = GetNearestObjectByTag("OTR_OX_SPAWN");
  if (oWP != OBJECT_INVALID)
  {
    locOxSpawn = GetLocation(oWP);
  }

  // attempt to assign an un-used nearby ox
  object oOx = GetFirstObjectInShape(SHAPE_SPHERE, 4.0, locOxSpawn, TRUE);

  int bFound = FALSE;
  while ((oOx != OBJECT_INVALID) && !bFound)
  {
    string sTag = GetTag(oOx);
    if (sTag == "otrTradeRouteOx")
    {
      string sOxId = GetLocalString(oOx, "OtrOxId");
      if (sOxId == "")
      {
        bFound = TRUE;
      }
      else
      {
        int bOxIsInUse = OtrGetPersistentInt(oModule, sOxId + "_IsInUse");
        if (!bOxIsInUse)
        {
          bFound = TRUE;
        }
      }
    }

    if (!bFound)
    {
      oOx = GetNextObjectInShape(SHAPE_SPHERE, 4.0, locOxSpawn, TRUE);
    }
  }

  if (bFound == FALSE)
  {
    oOx = CreateObject(OBJECT_TYPE_CREATURE, "otrTradeRouteOx", locOxSpawn, FALSE);
  }

  // init some persistent data
  OtrMakeOxPersistent(oOx, oPC, sKeyToRoute);

  // remove items required by route here

  int nBatchCount = 1; //OtrCheckComponentAvailability(oPC, sKeyToRoute);
  int nDelCount = 0;

  // Destroy the items required by the packing list
  int nItemCount = GetLocalInt(oModule, sKeyToRoute + "_ItemCount");
  int nItemIndex;
  for (nItemIndex=1; nItemIndex<=nItemCount; nItemIndex++)
  {
    string sItemTag = GetLocalString(oModule, sKeyToRoute + "_Tag_" + IntToString(nItemIndex));
    int nItemQty = GetLocalInt(oModule, sKeyToRoute + "_Qty_" + IntToString(nItemIndex));

    // Search the PC's inventory for this type of item
    // and destroy the qty needed for the route.
    nDelCount = nItemQty * nBatchCount;

    // We've now determined how many items to destroy, so destroy them.
    if (nDelCount > 0)
    {
      object oItem = GetFirstItemInInventory(oPC);
      while ((oItem != OBJECT_INVALID) && (nDelCount > 0))
      {
        if (GetTag(oItem) == sItemTag)
        {
          int nStackSize = GetNumStackedItems(oItem);
          if (nStackSize <= nDelCount)
          {
            DestroyObject(oItem);
            nDelCount -= nStackSize;
          }
          else
          {
            // split the stack
            DestroyObject(oItem);
            // DestroyObject is deferred, and create must be deferred also to keep order
            AssignCommand(oPC, OtrCreateItemOnObject(sItemTag, oPC, nStackSize-nDelCount));
            nDelCount = 0;
          }
        }
        oItem = GetNextItemInInventory(oPC);
      }
    }
  }
}
