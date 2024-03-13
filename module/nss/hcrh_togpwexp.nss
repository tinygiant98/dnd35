#include "hc_inc_helper"

void main()
{

    if(GetLocalInt(oMod, "PWEXP"))
    {
        SetLocalInt(oMod,"PWEXP",0);
        SendMessageToPC(OBJECT_SELF,"PWEXP system is now turned off.");
    }
    else
    {
        SetLocalInt(oMod,"PWEXP",1);
        SendMessageToPC(OBJECT_SELF,"PWEXP system is now turned on.");
        if(!GetLocalInt(oMod, "HCREXP"))
         {
            SetLocalInt(oMod,"HCREXP",1);
            SendMessageToPC(OBJECT_SELF,"HCREXP system is now turned on.");
         }
    }
}
