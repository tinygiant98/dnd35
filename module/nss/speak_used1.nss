void main()
{
string sSpeak = GetLocalString(OBJECT_SELF, "Speak");
AssignCommand(OBJECT_SELF, ActionSpeakString(sSpeak));
}
