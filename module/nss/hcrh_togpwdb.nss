#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "PWDBSAVE"))
    {
        SetLocalInt(oMod,"PWDBSAVE",0);
        SendMessageToPC(OBJECT_SELF,"PWDBSAVE system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"PWDBSAVE",1);
        SendMessageToPC(OBJECT_SELF,"PWDBSAVE system is now on.");
    }
}
