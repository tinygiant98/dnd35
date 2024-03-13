#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "RESTCONV"))
    {
        SetLocalInt(oMod,"RESTCONV",0);
        SendMessageToPC(OBJECT_SELF,"RESTCONV system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"RESTCONV",1);
        SendMessageToPC(OBJECT_SELF,"RESTCONV system is now on.");
    }
}
