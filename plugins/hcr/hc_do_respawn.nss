// hcr3.1
// took out old subrace code.
// sr6.0 fix to try alternate jump to locations.
// 5.5.2
// added code to attack respwaner if close to monster.
// 5.5.1
// added code to destroy player corpse if its in someones inventory.
// sr 5.5
// respawn code in Fugue for alternate way to leave.
// good for solo games.
// this is called from hc_respawn

#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_inc_rezpen"
#include "hc_inc_transfer"
#include "hc_text_activate"


void TakeHPs(object oTarget)
{
effect eDam = EffectDamage(GetCurrentHitPoints(oTarget) - 1);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
}


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
        // sr6.0 added 1.5 second delay
        if(GetLocalInt(oMod,"REZPENALTY"))
           DelayCommand(1.5, hcRezPenalty(oRespawner));
        // sr6.0 added 2.0 second delay
        if( GetIsPC(oRespawner))
                DelayCommand(2.0, TakeHPs(oRespawner));
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

