// sr5
//hc_dc_heartbeat
//Archaegeo June 27, 2002
// Called by the Death Corpse itself.
// Deletes the corpse if empty and gives items back if player is alive.

#include "hc_inc"

void main()
{
    object oDC=OBJECT_SELF;
    object oOwner=GetLocalObject(oDC,"Owner");
    object oArea=GetArea(oOwner);
// If im empty, destroy me.
    if(GetIsObjectValid(GetFirstItemInInventory(oDC))==FALSE)
       DestroyObject(oDC);

}
