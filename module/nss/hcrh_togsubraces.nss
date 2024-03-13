#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "SUBRACES"))
    {
        SetLocalInt(oMod,"SUBRACES",0);
        SendMessageToPC(OBJECT_SELF,"SUBRACES system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"SUBRACES",1);
        SendMessageToPC(OBJECT_SELF,"SUBRACES system is now on.");
    }
}
