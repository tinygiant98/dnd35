// 5.3 changed public cd key to player name
#include "hc_inc_helper"

void main()
{
    if(!GetLocalInt(oMod,"SINGLECHARACTER"))
    {
        SendMessageToPC(OBJECT_SELF,"This is not a single player server.");
        return;
    }
    DeletePersistentString(oMod,"SINGLECHARACTER"+GetPCPlayerName(oMyTarget));
    BootPC(oMyTarget);
    SendMessageToPC(OBJECT_SELF,"The player is reset.");
}
