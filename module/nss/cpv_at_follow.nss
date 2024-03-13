#include "cpv_persist_inc"
#include "cmd_language_inc"

void CpvCheckIfAtDestination(object oPC)
{
  int bFollowEmployer = CpvGetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvFollowing");
  if (bFollowEmployer)
  {
    DelayCommand(2.0, AssignCommand(OBJECT_SELF, ActionMoveToObject(oPC, TRUE, 2.0f)));
    DelayCommand(2.1, AssignCommand(OBJECT_SELF, CpvCheckIfAtDestination(oPC)));
  }
}

void main()
{
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvShopIsOpen", FALSE);
  CpvSetPersistentInt(GetModule(), GetTag(OBJECT_SELF) + "_CpvFollowing", TRUE);

  object oPC = GetPCSpeaker();
  DelayCommand(0.5, AssignCommand(OBJECT_SELF, ActionSpeakString(CPV_TEXT_I_WILL_FOLLOW)));
  DelayCommand(0.6, AssignCommand(OBJECT_SELF, ActionMoveToObject(oPC, TRUE, 2.0f)));
  DelayCommand(0.7, AssignCommand(OBJECT_SELF, CpvCheckIfAtDestination(oPC)));
}
