/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_at_drop_off
//
//  Desc:  Player has chosen to drop off an ox.
//
//  Author: David Bobeck 13Sep03
//          Morgan Quickthrust Mar04
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"
#include "cmd_persist_inc"
#include "cpv_persist_inc"
#include "qcs_config_inc"
#include "qcs_functions"

void main()
{
  object oModule = GetModule();
  object oPC = GetPCSpeaker();

  location locDropOff = GetLocation(OBJECT_SELF);
  object oWP = GetNearestObjectByTag("OTR_OX_SPAWN");
  if (oWP != OBJECT_INVALID)
  {
    locDropOff = GetLocation(oWP);
  }

  SetLocalInt(oPC, "OtrSuccessfulDropOff", FALSE);

  object oOx = GetFirstObjectInShape(SHAPE_SPHERE, 4.0, locDropOff, TRUE);
  while (oOx != OBJECT_INVALID)
  {
    string sTag = GetTag(oOx);
    if (sTag == "otrTradeRouteOx")
    {
      string sOxId = GetLocalString(oOx, "OtrOxId");

      string sPcKey = GetPCPublicCDKey(oPC);
      string sPcName = GetName(oPC);
      string sKey = sPcKey + "_" + sPcName;

      string sOwnerKey = OtrGetPersistentString(oModule, sOxId + "_OwnerKey");
      if (sKey == sOwnerKey)
      {
        string sKeyToRoute = OtrGetPersistentString(oModule, sOxId + "_KeyToRoute");
        string sDestAreaTag = GetLocalString(oModule, sKeyToRoute + "_DestArea");

        if (GetTag(GetArea(oOx)) == sDestAreaTag)
        {
           // Change to Give Route Items to Destination Merchant if One is Setup
           // Change made by Morgan Quickthrust 3/04
           string sUseDestMerch = GetLocalString(oModule, sKeyToRoute + "_UseDestMerch");
           string sOtr_UseDestMerch = ("OTR_UseDestMerch");
           int nXPPaid = FALSE;
           if (sUseDestMerch == sOtr_UseDestMerch)
           {
              int nTotalItemCount = GetLocalInt(oModule, sKeyToRoute + "_ItemCount");
              int nItemCount;
              for (nItemCount=1; nItemCount<=nTotalItemCount; nItemCount++)
              {
                 string sDestMerchTag = GetLocalString(oModule, sKeyToRoute + "_DestMerchTag_" + IntToString(nItemCount));
                 int bEnablePersistentInventory = CmdGetPersistentInt(oModule, sDestMerchTag + "_IsPersistent");
                 if (bEnablePersistentInventory)
                 {
                    string sItemTag = GetLocalString(oModule, sKeyToRoute + "_Tag_" + IntToString(nItemCount));
                    string sItemResRef = GetLocalString(oModule, sKeyToRoute + "_ResRef_" + IntToString(nItemCount));
                    int nItemQty = GetLocalInt(oModule, sKeyToRoute + "_Qty_" + IntToString(nItemCount));
                    int bPlayerVendor = CpvGetPersistentInt(oModule, sDestMerchTag + "_CpvEnabled");
                    if (bPlayerVendor)
                    {
                       int nChargeCpv = FALSE;
                       if (OTR_CHARGE_CPV)
                       {
                          if (OTR_DONT_CHARGE_CPV_OWNER)
                          {
                             string sCpvOwnerKey = CpvGetPersistentString(oModule, sDestMerchTag + "_CpvEmployer");
                             if (sCpvOwnerKey == sOwnerKey)
                             {
                                // don't give GP if CPV is owned by Ox Owner and Owner is not charged for delivery
                                int nPayoffXP = GetLocalInt(oModule, sKeyToRoute + "_PayoffXP");
                                GiveXPToCreature(oPC, nPayoffXP);
                                nXPPaid = TRUE;
                             }
                             else
                             {
                                int nChargeCpv = TRUE;
                             }
                          }
                          else
                          {
                             int nChargeCpv = TRUE;
                          }
                       }
                       else
                       {
                          int nChargeCpv = TRUE;
                       }
                       QcsAddDestCpvMerch(sDestMerchTag, sItemTag, sItemResRef, nItemQty, nChargeCpv);
                    }
                    else
                    {
                       QcsAddDestCmdMerch(sDestMerchTag, sItemTag, sItemResRef, nItemQty);
                    }
                 }
              }
           }

           SetLocalInt(oPC, "OtrSuccessfulDropOff", TRUE);

           if (nXPPaid != TRUE)
           {
              // Award player normal payoff
              int nPayoffGold = GetLocalInt(oModule, sKeyToRoute + "_PayoffGold");
              int nPayoffXP = GetLocalInt(oModule, sKeyToRoute + "_PayoffXP");
              GiveGoldToCreature(oPC, nPayoffGold);
              GiveXPToCreature(oPC, nPayoffXP);
           }

           DeleteLocalString(oOx, "OtrOxId");
           OtrSetPersistentInt(oModule, sOxId + "_Following", FALSE);
           OtrSetPersistentInt(oModule, sOxId + "_IsInUse", FALSE);

           // Remove Oxen from Players Party - Change made to force Oxen to follow PC through non-standard Area Transitions
           // Change made by Morgan Quickthrust 3/04
           if (OTR_OXEN_JOIN_PARTY)
           {
              RemoveHenchman(oPC, oOx);
           }
           // End Change

           //DestroyObject(oOx);
         }
      }
    }
    oOx = GetNextObjectInShape(SHAPE_SPHERE, 4.0, locDropOff, TRUE);
  }
}
