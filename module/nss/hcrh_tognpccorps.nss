#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "NPCCORPSE"))
    {
        SetLocalInt(oMod,"NPCCORPSE",0);
        SendMessageToPC(OBJECT_SELF,"NPCCORPSE system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"STORESYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"NPCCORPSE system is now on.");
    }
}
