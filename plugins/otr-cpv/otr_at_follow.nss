/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_at_follow
//
//  Desc:  Commands the ox to follow the PC
//
//  Author: David Bobeck 16Sep03
//
/////////////////////////////////////////////////////////
#include "otr_persist_inc"
#include "qcs_config_inc"

void OtrCheckIfAtDestination(object oPC, string sOxId)
{
  int bFollowing = OtrGetPersistentInt(GetModule(), sOxId + "_Following");
  if (bFollowing)
  {
    AssignCommand(OBJECT_SELF, ActionMoveToObject(oPC, FALSE, 4.0f));
    DelayCommand(4.0, AssignCommand(OBJECT_SELF, OtrCheckIfAtDestination(oPC, sOxId)));
  }
}

void main()
{
  object oModule = GetModule();

  string sOxId = GetLocalString(OBJECT_SELF, "OtrOxId");
  OtrSetPersistentInt(oModule, sOxId + "_Following", TRUE);

  object oPC = GetPCSpeaker();
  // Add Oxen to PC Party - Change made to force Oxen to follow PC through non-standard Area Transitions
  if (OTR_OXEN_JOIN_PARTY)
  {
     AddHenchman(oPC, OBJECT_SELF);
  }
  // End Change

  DelayCommand(0.6, AssignCommand(OBJECT_SELF, ActionMoveToObject(oPC, FALSE, 4.0f)));
  DelayCommand(0.7, AssignCommand(OBJECT_SELF, OtrCheckIfAtDestination(oPC, sOxId)));
}
