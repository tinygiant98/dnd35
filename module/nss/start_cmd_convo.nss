void main()
{
  object oPC = GetPCSpeaker();
  DelayCommand(0.1, ActionStartConversation(oPC, "cnr_c_merchant", TRUE));
}
