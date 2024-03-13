/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_config
//
//  Desc:  Checks if the vendor config options should
//         be displayed or not.
//
//  Author: David Bobeck 02Aug03
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sMenuType = GetLocalString(oPC, "sCnrMenuType");
  if (sMenuType == "CPV")
  {
    string sKeyToMenu = GetLocalString(oPC, "sCnrCurrentMenu");
    int nItemIndex = GetLocalInt(oPC, "CpvItemIndex");

    string sItemDesc = CnrMerchantGetCpvDesc(sKeyToMenu, nItemIndex);
    int nBuyPrice = CnrMerchantGetCpvBuyPrice(sKeyToMenu, nItemIndex);
    int nSellPrice = CnrMerchantGetCpvSellPrice(sKeyToMenu, nItemIndex);
    int nSetSize = CnrMerchantGetCpvSetSize(sKeyToMenu, nItemIndex);
    int nMaxQty = CnrMerchantGetCpvMaxQty(sKeyToMenu, nItemIndex);

    string sLtGreen = GetLocalString(GetModule(), "CmdColorLtGreen");
    string sText = sLtGreen + sItemDesc;
    
    if (nSetSize > 1)
    {
      sText += " (" + CMD_TEXT_SET_OF + " " + IntToString(nSetSize) + ")"; 
    }

    string sDkGreen = GetLocalString(GetModule(), "CmdColorDkGreen");
    string sDkYellow = GetLocalString(GetModule(), "CmdColorDkYellow");
    sText += sDkGreen + "\nBuy$ = " + sDkYellow + IntToString(nBuyPrice) + "gp";
    sText += sDkGreen + ", Sell$ = " + sDkYellow + IntToString(nSellPrice) + "gp";
    sText += sDkGreen + ", Max Qty = " + sDkYellow + IntToString(nMaxQty);
    SetCustomToken(27020, sText);

    return TRUE;
  }
  return FALSE;
}
