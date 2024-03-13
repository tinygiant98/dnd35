//  ----------------------------------------------------------------------------
//  hc_close_npccorp
//  ----------------------------------------------------------------------------
/*
    OnClose event script for an invisible NPC Corpse placeable to initiate the
    clean up function once the corpse is empty.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 26 July 2004 - Sunjammer
    - rewritten

    Credits:
    - Keron Blackfeld
    - Ragnar69
*/
//  ----------------------------------------------------------------------------
#include "hc_inc_npccorpse"

void main()
{
    object oCorpse = OBJECT_SELF;
    object oBody = GetLocalObject(oCorpse, HC_VAR_NPCCORPSE_BODY);

    // pre-emptive abort if body is to be preserved
    if(GetLocalInt(oBody, HC_VAR_NPCCORPSE_PRESERVE))
        return;

    // if empty then initiate clean-up
    if(HC_NPCCorpse_GetIsEmpty(oCorpse))
        HC_NPCCorpse_CleanUp(oCorpse);
}

