// hcr3

void main()
{
object oMod = GetModule();
object oPortal = GetObjectByTag("HC_DMRAISE");
DestroyObject(oPortal);
SetLocalInt(oMod, "RAISEPORT", FALSE);
}
