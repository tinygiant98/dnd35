// hcr3.1
// 9/3/2003 fix for empty bags.
// fix for dbag count.
// hcr3 persistence 8/12/2003
// using module tag now for bag data if you change the tag of your module
// you will have to change the names of the files and variables.
// also im not removing the tables every time this speeds up backups.
// changed to 5 bags per player to speed up backup for campaign vars.
// this script is for hcr specific persistence code.

#include "i_tagtests"

void HCStoreDB(string sID)
{
   object oMod = GetModule();
   int nInst;
   int iCount;
   int nGold = 0;
   object oItem;
   object oDB;
   string sBlank;
   location lBag = GetLocation(GetObjectByTag("HC_CORPSELOC"));
   object oTemp = CreateObject(OBJECT_TYPE_PLACEABLE, "bagyard", lBag, FALSE, sID);
   string sNID = GetTag(oTemp);
   DestroyObject(oTemp);
   nInst = 0;
   string sCount;
   string sMTag = GetTag(GetModule());
   // hcr3 8/12/2003 default is 5 bags per player.
   // lag seems too great with more than that.
   while (nInst <= 4)
   {
    string sInst = IntToString(nInst);
    // hcr3.1 9/3/2003
    DestroyCampaignDatabase("HCRDBAG" + GetName(oMod) + sNID + sInst);
    oDB = GetObjectByTag("DropBag" + sNID, nInst);
    // 7/28/2003
    nGold = 0;
    iCount = 0;
    location lLoc = GetLocation(oDB);
    SetCampaignLocation("HCRDBAG" + sMTag + sNID + sInst, "LOCATION", lLoc);
    oItem = GetFirstItemInInventory(oDB);
    while (GetIsObjectValid(oItem))
    {
        // hcr3.1 fix to remove dupes from containers.
        if (GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX)
        {
           object oInv = GetFirstItemInInventory(oItem);
           while (GetIsObjectValid(oInv))
           {
              SetLocalInt(oInv, "BackedUP", TRUE);
              oInv = GetNextItemInInventory(oItem);
           }
        }
        oItem = GetNextItemInInventory(oDB);
    }
    oItem = GetFirstItemInInventory(oDB);
    while (GetIsObjectValid(oItem))
    {
       if (!GetIsNoDrop(oItem) && GetTag(oItem) != "bagofgold" && !GetLocalInt(oItem, "BackedUP"))
       {
         iCount++;
         sCount = IntToString(iCount);
         StoreCampaignObject( "HCRDBAG" + sMTag + sNID + sInst , "Item"+ sCount, oItem);
       }
       else if (GetTag(oItem) == "bagofgold")
         nGold = GetLocalInt(oItem,"AmtGold") + nGold;
       oItem = GetNextItemInInventory(oDB);
    }
    // hcr3.1 fix to remove dupes from containers.
    int nCount;
    for (nCount = 0; nCount++; nCount <= iCount)
    {
       DeleteLocalInt(oItem, "BackedUP");
    }
    SetCampaignInt("HCRDBAG"+ sMTag + sNID + sInst, "DBGOLD" , nGold);
    SetCampaignInt("HCRDBAG"+ sMTag + sNID + sInst, "ITMCOUNT" , iCount);
    nInst++;
   }

}

void HCLoadDB(string sID, object oPlayer)
{
   location lBlank;
   object oMod = GetModule();
   object oYard = GetObjectByTag("HC_CORPSELOC");
   location lBag = GetLocation(oYard);
   object oTemp = CreateObject(OBJECT_TYPE_PLACEABLE, "bagyard", lBag, FALSE, sID);
   string sNID = GetTag(oTemp);
   DestroyObject(oTemp);
   string sBlank;
   if (sBlank == sID)
       return;
   int nInst = 0;
   string sMTag = GetTag(GetModule());
   while (nInst <= 4)
   {
     string sInst = IntToString(nInst);
     float fInst = IntToFloat(nInst)+0.25;
     int iCount = 1;
     // use last location if not valid use bagyard.
     location lLoc = GetCampaignLocation("HCRDBAG" + sMTag + sNID + sInst, "LOCATION");
     if (!GetIsObjectValid(GetAreaFromLocation(lLoc)))
     {
         lLoc = GetLocation(GetObjectByTag("BagYard"));
         object oArea = GetArea(GetObjectByTag("BagYard"));
         lLoc = Location(oArea, GetPositionFromLocation(lLoc)+ Vector( fInst, fInst, 0.0), 0.0);
     }
     object oDropBag = CreateObject(OBJECT_TYPE_PLACEABLE, "DyingCorpse", lLoc, FALSE, "DropBag" + sID);
     SetLocalObject(oMod,"DropBag"+sID, oDropBag);
     SetLocalObject(oDropBag,"Owner",oPlayer);
     SetLocalString(oDropBag,"Name",GetName(oPlayer));
     SetLocalString(oDropBag, "Pkey", sID);
     SetLocalString(oDropBag, "NID", sNID);
     int nItems = GetCampaignInt("HCRDBAG"+ sMTag + sNID + sInst, "ITMCOUNT");
     string sCount;
     while (iCount <= nItems)
     {
       sCount = IntToString(iCount);
       RetrieveCampaignObject( "HCRDBAG" + sMTag + sNID + sInst , "Item" + sCount, lBag, oDropBag);
       iCount++;
     }
     int nGold = GetCampaignInt( "HCRDBAG"+ sMTag + sNID + sInst, "DBGOLD");
     if (nGold > 0)
     {
         object oBag=CreateItemOnObject("bagofgold",oDropBag);
         SetLocalInt(oBag,"AmtGold",nGold);
         SetLocalInt(oDropBag, "AmtGold", nGold);
     }
     SetLocalObject(oPlayer, "DROPBAG", oDropBag);
     // hcr3.1 9/3/2003 fix to destroy empty bags.
     if (GetFirstItemInInventory(oDropBag) == OBJECT_INVALID)
         DestroyObject(oDropBag);
     nInst++;
   }

}


