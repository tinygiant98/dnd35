// hcr3
// deathcorpse placeable
// sr6.1
// streamlined code.
// sr5
//hc_dc_close
// Called by the Death Corpse itself.
// Deletes the corpse if emptied.
#include "hc_inc_dcorpse"
#include "hc_inc"


void main()
{
    object oDC=OBJECT_SELF;
    object oMod=GetModule();
    object oPlayerCorpse = GetLocalObject(oDC,"PlayerCorpse");
// If im empty, destroy me.
    if(GetIsObjectValid(GetFirstItemInInventory(oDC))==FALSE)
    {
       // copy to fugue for later retrieval.
       CopyToFugue(OBJECT_SELF);
       DelayCommand(0.5, DestroyObject(oDC));
    }
}
