// hcr3.1
// made delay 2 sec. on destroy.
// persistence code.
// shortened delay on destroy.
// sr 5.5
// added delay to destroying bag.
// sr5.3
// check player state and not remove bag if one of those exists.
//hc_db_close
#include "hc_inc"
// hcr3 7/27/2003
#include "hc_id"



void DestroyBag(object oDC, object oOwner)
{
    if(GetIsObjectValid(GetFirstItemInInventory(oDC)) == FALSE  &&
       GPS(oOwner) != PWS_PLAYER_STATE_DEAD
       && GPS(oOwner) != PWS_PLAYER_STATE_DYING
       && GPS(oOwner) != PWS_PLAYER_STATE_STABLE
       && GPS(oOwner) != PWS_PLAYER_STATE_STABLEHEAL)
       {
          DeleteLocalObject(oOwner, "DROPBAG");
          DelayCommand(2.0, DestroyObject(oDC, 0.0));
       }
}


void main()
{
   object oDC=OBJECT_SELF;
   object oOwner = GetLocalObject(oDC,"Owner");
   object oArea=GetArea(oOwner);
   // hcr3 7/27/2003
   // persistence code
   object oUser = GetLastClosedBy();
   int nPersist = GetLocalInt(GetModule(), "PERSIST");
   if (nPersist)
       ExecuteScript("hc_storedbp", oDC);
// If im empty and owner is not dying, destroy me.
   DelayCommand(0.1, DestroyBag(oDC, oOwner));
}



