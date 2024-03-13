//hcr3
// DM conversation to allow a portal for ressing players who are dead.
// will have 3 ways to ress.
// this should probably be put into the hcr helper instead of a object.

void main()
{
object oPC = GetLastUsedBy();
if (GetIsDM(oPC))
{
  ActionStartConversation(oPC, "hc_c_dmres", TRUE, FALSE);
}
}
