// 5.3 changed public cd key to player name
#include "hc_inc_helper"

void main()
{
    SendMessageToPC(OBJECT_SELF,"That player is banned till server restart.");
    SendMessageToAllDMs(GetName(OBJECT_SELF)+" just banned "+GetName(oMyTarget));
    SetPersistentInt(oMod,"BANNED"+GetPCPlayerName(oMyTarget),1);
    BootPC(oMyTarget);
}
