//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  qcs_functions
//
//  Desc:  CMD & CPV Functions for OTR
//
//  Author: Morgan Quickthrust Mar04
//
/////////////////////////////////////////////////////////

#include "cmd_persist_inc"
#include "cpv_persist_inc"

/////////////////////////////////////////////////////////
void QcsAddDestCmdMerch(string sDestMerchTag, string sItemTag, string sItemResRef, int nItemQty)
{
  object oModule = GetModule();
  object oMerchant = GetObjectByTag(sDestMerchTag);

// Get Merchant Object if not spawned into world at this
  int nObjectFound = FALSE;
  if (oMerchant == OBJECT_INVALID)
  {
     nObjectFound = TRUE;
     object oWP = GetObjectByTag("QCS_CMD_SPAWN");
     if (oWP != OBJECT_INVALID)
     {
        location locDestMerchSpawn = GetLocation(oWP);
        oMerchant = CreateObject(OBJECT_TYPE_CREATURE, GetStringLowerCase(sDestMerchTag), locDestMerchSpawn, FALSE);
     }
  }

  if (oMerchant != OBJECT_INVALID)
  {
     int nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sItemResRef);
     int nMaxOnHandQty = GetLocalInt(oModule, sDestMerchTag + "_MaxOnHandQty_" + sItemTag);
     if ((nOnHandQty + nItemQty) > nMaxOnHandQty)
     {
        CmdSetPersistentInt(oMerchant, "OnHandQty_" + sItemResRef, nMaxOnHandQty);
     }
     else
     {
        int nSetOnHandQty = (nOnHandQty + nItemQty);
        CmdSetPersistentInt(oMerchant, "OnHandQty_" + sItemResRef, nSetOnHandQty);
     }
     if (nObjectFound)
     {
        DestroyObject(oMerchant);
     }
  }
}

/////////////////////////////////////////////////////////
void QcsSubDestCmdMerch(string sDestMerchTag, string sItemTag, string sItemResRef, int nItemQty)
{
  object oModule = GetModule();
  object oMerchant = GetObjectByTag(sDestMerchTag);

  // Get Merchant Object if not spawned into world at this
  int nObjectFound = FALSE;
  if (oMerchant == OBJECT_INVALID)
  {
     nObjectFound = TRUE;
     object oWP = GetObjectByTag("QCS_CMD_SPAWN");
     if (oWP != OBJECT_INVALID)
     {
        location locDestMerchSpawn = GetLocation(oWP);
        oMerchant = CreateObject(OBJECT_TYPE_CREATURE, GetStringLowerCase(sDestMerchTag), locDestMerchSpawn, FALSE);
     }
  }

  if (oMerchant != OBJECT_INVALID)
  {
     int nOnHandQty = CmdGetPersistentInt(oMerchant, "OnHandQty_" + sItemResRef);
     if ((nOnHandQty - nItemQty) <= 0)
        {
           CmdSetPersistentInt(oMerchant, "OnHandQty_" + sItemResRef, 0);
        }
        else
        {
           int nSetOnHandQty = (nOnHandQty + nItemQty);
           CmdSetPersistentInt(oMerchant, "OnHandQty_" + sItemResRef, nSetOnHandQty);
        }
     }
}

/////////////////////////////////////////////////////////
void QcsAddDestCpvMerch(string sDestMerchTag, string sItemTag, string sItemResRef, int nItemQty, int nChargeCpv)
{
  object oModule = GetModule();
  object oMerchant = GetObjectByTag(sDestMerchTag);

  // Get Merchant Object if not spawned into world at this
  int nObjectFound = FALSE;
  if (oMerchant == OBJECT_INVALID)
  {
     nObjectFound = TRUE;
     object oWP = GetObjectByTag("QCS_CMD_SPAWN");
     if (oWP != OBJECT_INVALID)
     {
        location locDestMerchSpawn = GetLocation(oWP);
        oMerchant = CreateObject(OBJECT_TYPE_CREATURE, GetStringLowerCase(sDestMerchTag), locDestMerchSpawn, FALSE);
     }
  }

  if (oMerchant != OBJECT_INVALID)
  {
     int nCpvOnHandGold = CmdGetPersistentInt(oModule, sDestMerchTag + "_CmdGold");
     int nSourceCount = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvCount");
     int nSourceIndex;
     for (nSourceIndex=1; nSourceIndex<=nSourceCount; nSourceIndex++)
     {
        string sCpvItemTag = CpvGetPersistentString(oModule, "CPV" + sDestMerchTag + "_CpvTag_" + IntToString(nSourceIndex));
        if (sItemTag == sCpvItemTag)
        {
           int nItemCost = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvBuyPrice_" + IntToString(nSourceIndex));
           int nCost = (nItemCost * nItemQty);
           int nSetCpvOnHandGold = (nCpvOnHandGold - nCost);
           if (nChargeCpv)
           {
              if (nCpvOnHandGold >= nCost)
              {
                 CmdSetPersistentInt(oModule, sDestMerchTag + "_CmdGold", nSetCpvOnHandGold);
              }
              else
              {
                 SpeakString("The merchant, " + sDestMerchTag + ", did not have enough gold to pay for this shipment.");
                 SpeakString("I will pay your promised fee and sell the items to another vendor who can pay their bills!");
                 return;
              }
           }
           int nOnHandQty = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvQty_" + IntToString(nSourceIndex));
           int nMaxOnHandQty = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvMaxQty_" + IntToString(nSourceIndex));
           if ((nOnHandQty + nItemQty) > nMaxOnHandQty)
           {
              CpvSetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvQty_" + IntToString(nSourceIndex), nMaxOnHandQty);
           }
           else
           {
              int nSetOnHandQty = (nOnHandQty + nItemQty);
              CpvSetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvQty_" + IntToString(nSourceIndex), nSetOnHandQty);
           }
        }
     }
  }
}

/////////////////////////////////////////////////////////
void QcsSubDestCpvMerch(string sDestMerchTag, string sItemTag, string sItemResRef, int nItemQty, int nChargeCpv)
{
  object oModule = GetModule();
  object oMerchant = GetObjectByTag(sDestMerchTag);

  // Get Merchant Object if not spawned into world at this
  int nObjectFound = FALSE;
  if (oMerchant == OBJECT_INVALID)
  {
     nObjectFound = TRUE;
     object oWP = GetObjectByTag("QCS_CMD_SPAWN");
     if (oWP != OBJECT_INVALID)
     {
        location locDestMerchSpawn = GetLocation(oWP);
        oMerchant = CreateObject(OBJECT_TYPE_CREATURE, GetStringLowerCase(sDestMerchTag), locDestMerchSpawn, FALSE);
     }
  }
     if (oMerchant != OBJECT_INVALID)
     {
     int nCpvOnHandGold = CmdGetPersistentInt(oModule, sDestMerchTag + "_CmdGold");
     int nSourceCount = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvCount");
     int nSourceIndex;
     for (nSourceIndex=1; nSourceIndex<=nSourceCount; nSourceIndex++)
        {
        string sCpvItemTag = CpvGetPersistentString(oModule, "CPV" + sDestMerchTag + "_CpvTag_" + IntToString(nSourceIndex));
        if (sItemTag == sCpvItemTag)
        {
           int nItemCost = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvBuyPrice_" + IntToString(nSourceIndex));
           int nCost = (nItemCost * nItemQty);
           int nSetCpvOnHandGold = (nCpvOnHandGold + nCost);
           if (nChargeCpv)
           {
              CmdSetPersistentInt(oModule, sDestMerchTag + "_CmdGold", nSetCpvOnHandGold);
           }
           int nOnHandQty = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvQty_" + IntToString(nSourceIndex));
           int nMaxOnHandQty = CpvGetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvMaxQty_" + IntToString(nSourceIndex));
           if ((nOnHandQty - nItemQty) <= 0)
           {
              CpvSetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvQty_" + IntToString(nSourceIndex), 0);
           }
           else
           {
              int nSetOnHandQty = (nOnHandQty + nItemQty);
              CpvSetPersistentInt(oModule, "CPV" + sDestMerchTag + "_CpvQty_" + IntToString(nSourceIndex), nSetOnHandQty);
           }
        }
     }
  }
}

