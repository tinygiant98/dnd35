// hcr3 7/25/2003
// put in heartbeat of dropped items placeable.
// shortened delay on destroy.
// sr 5.5
// added delay to destroying bag.
// sr5.3
// check player state and not remove bag if one of those exists.
//hc_db_close
#include "hc_inc"

void DestroyBag(object oDC, object oOwner)
{
    if(GetIsObjectValid(GetFirstItemInInventory(oDC))==FALSE  &&
       GPS(oOwner) != PWS_PLAYER_STATE_DEAD
       && GPS(oOwner) != PWS_PLAYER_STATE_DYING
       && GPS(oOwner) != PWS_PLAYER_STATE_STABLE
       && GPS(oOwner) != PWS_PLAYER_STATE_STABLEHEAL)
       {
          DeleteLocalObject(oOwner, "DROPBAG");
          DestroyObject(oDC, 1.0);
       }
}


void main()
{
    object oDC=OBJECT_SELF;
    object oOwner=GetLocalObject(oDC,"Owner");
    object oArea=GetArea(oOwner);
// If im empty and owner is not dying, destroy me.
    DelayCommand(5.0, DestroyBag(oDC, oOwner));
}
