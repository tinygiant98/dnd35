#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "HUNGERSYSTEM"))
    {
        SetLocalInt(oMod,"HUNGERSYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"HUNGERSYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"HUNGERSYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"HUNGERSYSTEM system is now on.");
    }
}
