#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "DYINGSTRIP"))
    {
        SetLocalInt(oMod,"DYINGSTRIP",0);
        SendMessageToPC(OBJECT_SELF,"DYINGSTRIP system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"DYINGSTRIP",1);
        SendMessageToPC(OBJECT_SELF,"DYINGSTRIP system is now on.");
    }
}
