#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "UNIDONDROP"))
    {
        SetLocalInt(oMod,"UNIDONDROP",0);
        SendMessageToPC(OBJECT_SELF,"UNIDONDROP system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"STORESYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"UNIDONDROP system is now on.");
    }
}
