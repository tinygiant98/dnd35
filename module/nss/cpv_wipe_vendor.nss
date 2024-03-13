#include "cpv_vendor_utils"
void main()
{
  object oPC = GetLastUsedBy();

  string sPcKey = GetPCPublicCDKey(oPC);
  string sPcName = GetName(oPC);
  string sPlayerKey = sPcKey + "_" + sPcName;

  CpvWipePlayerVendor(sPlayerKey);
}
