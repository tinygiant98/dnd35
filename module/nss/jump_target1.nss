void main()
{
object oPC = GetLastUsedBy();
string sTarget = GetLocalString(OBJECT_SELF, "Target");
string sSpeak = GetLocalString(OBJECT_SELF, "Speak");
object oTarget = GetObjectByTag(sTarget);
if(GetIsInCombat(oPC))
{
SendMessageToPC(oPC, sSpeak);
}
else
{
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToObject(oTarget));
}
}
