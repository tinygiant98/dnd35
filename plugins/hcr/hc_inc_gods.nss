// hcr3 7/19/2003
// fix for logindeath.
// fixed to use waypoint to jumpto.
// 5.5.1
// added if statement around subraces.
// HCR 5.5 change by Lorinton
// Modified to respawn the subrace after removing effects.
// Modified to reduce (hopefully eliminate) subrace effects being stripped by the game
// and other effects such as level drain being stripped by the subrace system.
// 5.3 changed public cd key to player name
//hc_gods_inc
//Archaegeo

#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_text_gods"

int RessCheck(object oPlayer)
{
    if(GetLocalInt(oMod,"GODSYSTEM"))
    {
        int nrezpercent=GetLocalInt(oMod,"GODCHANCE")+(GetHitDice(oPlayer)/4);
        // hcr3 7/19/2003
        // fix for logindeath.
        if(GetLocalInt(oPlayer,"LOGINDEATH"))
        {
            return 0;
        }
        if(GetDeity(oPlayer)=="")
        {
            SendMessageToPC(oPlayer, NOGOD);
            return 0;
        }
        else if(d100(1) > nrezpercent)
        {
            if(GetDeity(oPlayer)!="")
                SendMessageToPC( oPlayer, GODREFUSED);
            return 0;
// If someone dies, move them to limbo and paralyze them there.
        }
        SendMessageToPC(oPlayer,GODLISTENED);
// Their god was listening!!
        if(GetLocalInt( oMod, "BLEEDSYSTEM"))
           SPS( oPlayer, PWS_PLAYER_STATE_ALIVE);
        // hcr3 use GodLoc waypoint to place where you want pcs to be ressed.
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPlayer));
        AssignCommand(oPlayer, DelayCommand( 0.4, JumpToLocation( GetLocation( GetObjectByTag( "GodLoc")))));
        DelayCommand(0.6, ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer));
    // At this point they are respawned where they stand.  If you want to move them
    // to safety, you should do so here.
        HCR_RemoveEffects(oPlayer);
        return 1;
    }
    return 0;
}
