//  ----------------------------------------------------------------------------
//  hc_npccorpse
//  ----------------------------------------------------------------------------
/*
    Called via ExecuteScript from nw_c2_default7.

    TODO: updated nw_c2_default7 to use include and a direct function call.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 26 July 2004 - Sunjammer
    - deprecated
*/
//  ----------------------------------------------------------------------------
#include "hc_inc_npccorpse"

void main()
{
    HC_NPCCorpse_CreateCorpse(OBJECT_SELF);
}

