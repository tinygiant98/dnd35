/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_device_ou
//
//  Desc:  This OnUsed handler is meant to fix a Bioware
//         bug that sometimes prevents placeables from
//         getting OnOpen or OnClose events. This OnUsed
//         handler in coordination with the OnDisturbed
//         ("cnr_device_od") handler work around the bug.
//
//  Author: David Bobeck 06Apr03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
#include "util_i_debug"

/////////////////////////////////////////////////////////
void TestIfRecipesHaveBeenCollected(object oUser)
{
  Debug(HexColorString("    TestIfRecipesHaveBeenCollected", COLOR_ORANGE));
  Debug("      object_self = " + GetTag(OBJECT_SELF));

  int nStackCount = CnrGetStackCount(oUser);
  Debug("      nStackCount = " + IntToString(nStackCount));
  if (nStackCount > 0)
  {
    AssignCommand(OBJECT_SELF, TestIfRecipesHaveBeenCollected(oUser));
  }
  else
  {
    Debug("      ...all prerequisites met, starting conversation");
    Debug("      ...nCnrMenuPage = " + IntToString(GetLocalInt(oUser, "nCnrMenuPage")));
    Debug("      ...sCnrCurrentMenu = " + GetLocalString(oUser, "sCnrCurrentMenu"));
    BeginConversation("", oUser);
    //ActionStartConversation(oUser, "", TRUE, FALSE);
  }
}

/////////////////////////////////////////////////////////
void TestIfRecipesHaveBeenInitialized(object oUser)
{
  Debug(HexColorString("  TestIsRecipesHaveBeenInitialized", COLOR_ORANGE));

  int nStackCount = CnrGetStackCount(oUser);
  Debug("    nStackCount = " + IntToString(nStackCount));
  if (nStackCount > 0)
  {
    AssignCommand(OBJECT_SELF, TestIfRecipesHaveBeenInitialized(oUser));

  }
  else
  {
    // Note: A placeable will receive events in the following order...
    // OnOpen, OnUsed, OnDisturbed, OnClose, OnUsed.
    if (GetLocalInt(OBJECT_SELF, "bCnrDisturbed") != TRUE)
    {
      Notice("    Contents have not been disturbed; skipping");
      Debug("    ^^^^^^^^^^^ This is dumb");
      // Skip if the contents have not been altered.
      return;
    }

    SetLocalInt(OBJECT_SELF, "bCnrDisturbed", FALSE);

    // If the Bioware bug is in effect, simulate the closing
    if (GetIsOpen(OBJECT_SELF))
    {
      AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    }

    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    if (oItem == OBJECT_INVALID)
    {
      // Skip if empty.
      return;
    }

    Debug("    ...tools found = " + IntToString(CnrRecipeDeviceToolsArePresent(oUser, OBJECT_SELF)));

    if (CnrRecipeDeviceToolsArePresent(oUser, OBJECT_SELF))
    {
      SetLocalInt(oUser, "nCnrMenuPage", 0);
      SetLocalString(oUser , "sCnrCurrentMenu", GetTag(OBJECT_SELF));

      Debug("    ...collecting recipes");

      // this call is asynchronous - it uses stack helpers to avoid TMI
      CnrCollectDeviceRecipes(oUser, OBJECT_SELF, TRUE);

      //ActionStartConversation(oUser, "", TRUE);

      // wait until collection is done before starting the conversation
      AssignCommand(OBJECT_SELF, TestIfRecipesHaveBeenCollected(oUser));
    }
  }
}

/////////////////////////////////////////////////////////
void main()
{

  object oUser = GetLastUsedBy();
 
  Debug(HexColorString("cnr_device_ou", COLOR_ORANGE));
  Debug("  oUser = " + GetName(oUser));
 
  if (!GetIsPC(oUser))
  {
    return;
  }

  Debug("  ...initializing device recipes");
  // this call is asynchronous - it uses stack helpers to avoid TMI
  CnrInitializeDeviceRecipes(oUser, OBJECT_SELF);

  // wait until initialization is done before continuing
  AssignCommand(OBJECT_SELF, TestIfRecipesHaveBeenInitialized(oUser));
}
