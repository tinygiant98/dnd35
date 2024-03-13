#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "DECONENTER"))
    {
        SetLocalInt(oMod,"DECONENTER",0);
        SendMessageToPC(OBJECT_SELF,"DECONENTER system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"DECONENTER",1);
        SendMessageToPC(OBJECT_SELF,"DECONENTER system is now on.");
    }
}
