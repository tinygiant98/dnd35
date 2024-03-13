// hcr3.1
// took out old subrace code.
// hcr3
// modified to use dm portal.
// sr6.0 fix to try alternate jump to locations.
// 5.5.2
// added code to attack respwaner if close to monster.
// hcr3
// ress code in Fugue for alternate way to leave.
// good for solo games.

#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_inc_transfer"
#include "hc_text_activate"


void main()
{
    object oMod = GetModule();
    object oRespawner=OBJECT_SELF;
    string sName = GetName(oRespawner);
    string sCDK = GetPCPlayerName(oRespawner);
    string sID = sName+sCDK;
    object oCorpse = GetLocalObject(oRespawner,"PlayerToken");
    if(GetIsObjectValid(oRespawner))
    {
        SetPlotFlag(oRespawner, FALSE);
        HCR_RemoveEffects(oRespawner);
        AssignCommand(oRespawner, ApplyEffectToObject(DURATION_TYPE_INSTANT,
                EffectResurrection(),oRespawner));
        // sr6.0 added alternative jumptolocation.
        if (GetIsObjectValid(GetItemPossessor(oCorpse)))
            AssignCommand(oRespawner, JumpToObject(GetItemPossessor(oCorpse)));
        else
            AssignCommand(oRespawner, JumpToObject( GetLocalObject(oMod, "DeathCorpse"+sID)));
        // 5.5.2 added code to attack target if ressed near hostiles.
        DelayCommand(5.0, ExecuteScript("hc_attackpc" , oRespawner));
        // 5.5.1 added code to destroy the player corpse
        DestroyObject(oCorpse);
        SPS(oRespawner,PWS_PLAYER_STATE_ALIVE);

    }
}

