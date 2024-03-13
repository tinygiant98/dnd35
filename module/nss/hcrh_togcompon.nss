#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "MATERCOMP"))
    {
        SetLocalInt(oMod,"MATERCOMP",0);
        SendMessageToPC(OBJECT_SELF,"MATERCOMP system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"STORESYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"MATERCOMP system is now on.");
    }
}
