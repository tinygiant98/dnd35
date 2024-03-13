/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cpv_ta_adj_inv
//
//  Desc:  Condition check
//
//  Author: David Bobeck 09Aug03
//
/////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sMenuType = GetLocalString(oPC, "sCnrMenuType");
  if (sMenuType == "CPV")
  {
    string sKeyToCurrentMenu = GetLocalString(oPC, "sCnrCurrentMenu");

    int nSubMenuCount = GetLocalInt(GetModule(), sKeyToCurrentMenu + "_SubMenuCount");
    if (nSubMenuCount > 0)
    {
      // items don't display when there are sub menus
      return FALSE;
    }
    
    return TRUE;
  }
  
  return FALSE;
}
