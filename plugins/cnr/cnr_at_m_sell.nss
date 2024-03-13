/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_at_m_sell
//
//  Desc:  Changes to the merchant's sell menu page
//
//  Author: David Bobeck 17Dec02
//
/////////////////////////////////////////////////////////
//#include "cnr_merch_utils"
#include "cpv_vendor_utils"

void main()
{
  object oPC = GetPCSpeaker();
  SetLocalString(oPC, "sCnrMenuType", "SELL");
  SetLocalString(oPC, "sCnrCurrentMenu", "SELL"+GetTag(OBJECT_SELF));
  SetLocalInt(oPC, "nCnrMenuPage", 0);

  CmdInitializeDeferredMerchantData(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "cnr_c_merchant2", TRUE));
}
