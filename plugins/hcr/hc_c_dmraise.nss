// hcr3

void main()
{
object oMod = GetModule();
object oPortal = GetObjectByTag("HC_DMRAISE");
CreateObject(OBJECT_TYPE_PLACEABLE, "hc_dmraise", GetLocation(GetObjectByTag("WP_DMRAISE")));
SetLocalInt(oMod, "RAISEPORT", TRUE);
}
