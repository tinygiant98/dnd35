#include "hc_inc_helper"

void main()
{
    if(GetLocalInt(oMod, "FATIGUESYSTEM"))
    {
        SetLocalInt(oMod,"FATIGUESYSTEM",0);
        SendMessageToPC(OBJECT_SELF,"FATIGUESYSTEM system is now off.");
    }
    else
    {
        SetLocalInt(oMod,"FATIGUESYSTEM",1);
        SendMessageToPC(OBJECT_SELF,"FATIGUESYSTEM system is now on.");
    }
}
