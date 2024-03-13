// hcr3

void main()
{
object oMod = GetModule();
object oPortal = GetObjectByTag("HC_DMTRES");
DestroyObject(oPortal);
SetLocalInt(oMod, "TRESSPORT", FALSE);
}
