//hcr3

void main()
{
object oMod = GetModule();
object oPortal = GetObjectByTag("HC_DMRES");
DestroyObject(oPortal);
SetLocalInt(oMod, "RESSPORT", FALSE);
}
