// hcr3
// taken out godsystem now in deathscript.
// took out hello from conversation.
// sr5
#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_inc_transfer"
#include "hc_text_activate"

int TRUE_RESS=3;
int RESS=2;
int RAISE=1;
int NONE=0;

void main()
{
// If the item is a player corpse token, then see if they can get the poor
// slob resurrected.
    int casttype=NONE;
    object oUser=OBJECT_SELF;
    object oCleric=GetLocalObject(oUser,"CLERIC");
    object oRespawner=GetLocalObject(oUser,"DEADMAN");
    object oItem=GetLocalObject(oUser,"ITEM");
    int iLevel=GetLevelByClass(CLASS_TYPE_CLERIC, oCleric);
// Make sure the PC is online
    if(GetIsPC(oCleric)==TRUE)
    {
        SendMessageToPC(oUser,NPCONLY);
        return;
    }
// Make sure the cleric is a NPC and at least level 10 (raise dead is a level
// 5 spell, requires level 10 to cast)
    if(iLevel < 9)
    {
        SendMessageToPC(oUser,NOTPOWERFUL);
        return;
    }
    int nAlign=GetLocalInt(oItem, "Alignment");
    if (nAlign != ALIGNMENT_NEUTRAL &&
        GetAlignmentGoodEvil(oCleric) != ALIGNMENT_NEUTRAL)
    {
        if (GetAlignmentGoodEvil(oCleric) != nAlign)
        {
            SendMessageToPC(oUser,NOTALIGN);
            return;
        }
    }
    int nGold=GetGold(oUser);
    int nBaseCost=1;
    // Find out how much, and see if they have that much gold.
    int iRezAmount;
    iRezAmount=50*iLevel+500*nBaseCost;
    SendMessageToPC(oUser, "Raise Dead Cost: "+IntToString(iRezAmount)+" gold");
    iRezAmount=70*iLevel+500*nBaseCost;
    if (iLevel > 12)
    SendMessageToPC(oUser, "Ressurection Cost: "+IntToString(iRezAmount)+" gold");
    iRezAmount = 90*iLevel+5000*nBaseCost;
    if (iLevel > 16)
    SendMessageToPC(oUser, "True Ress Cost: "+IntToString(iRezAmount)+" gold");
    // hcr3
    AssignCommand(oUser, ActionStartConversation(oUser, "hc_c_resplayer", TRUE, FALSE));
}
