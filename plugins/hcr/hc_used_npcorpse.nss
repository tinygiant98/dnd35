//  ----------------------------------------------------------------------------
//  hc_used_npccorpse
//  ----------------------------------------------------------------------------
/*
    OnUsed event script for an invis_corpse_obj placeable toc auses the PC
    opening the corpse to crouch down and visibly reach for the corpse.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 27 July 2004 - Sunjammer
    - updated

    Credits:
    - Keron Blackfeld
*/
//  ----------------------------------------------------------------------------

void main()
{
    object oPC = GetLastUsedBy();
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.0));
}

