#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "PARTYREST"))
    {
        SetLocalInt(oMod,"PARTYREST",0);
        SendMessageToPC(OBJECT_SELF,"PARTYREST system is now turned entirely off.");
    }
    else
    {
        SetLocalInt(oMod,"PARTYREST",1);
        SendMessageToPC(OBJECT_SELF,"PARTYREST system is now turned on.");
    }
}
