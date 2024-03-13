// hcr3.1
// took out heal code do not need without disabled.
// sr 5.5
// added bleeding code to set stableheal state when healed and dying.
// sr5.4.2
// Added code to remove disabled state.
// thanks to Binary for help with distance to target.
#include "hc_inc"
#include "hc_text_health"
// 5.5 added include file
//#include "hc_inc_heal"


void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    string sItemTag=GetLocalString(oUser,"TAG");
    DeleteLocalString(oUser,"TAG");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
        int nToHeal;
        effect eHeal;
        effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
        string sType=GetSubString(sItemTag,8,3);
        if ((oUser!=oOther) &&
           (GetDistanceBetween(oUser,oOther)>FeetToMeters(7.0)))
        {
           SendMessageToPC(oUser,"You must move within six feet.");
           return;
        }
        ActionDoCommand(ClearAllActions());
        SetCommandable(FALSE, oUser);
        DelayCommand(1.9, SetCommandable(TRUE, oUser));
        if (oOther != oUser)
        {
           if (GetCurrentHitPoints(oOther) > 0)
           {
              SendMessageToPC(oUser, "You can only use on a dying creature or yourself");
              return;
           }
           else
           {
           DelayCommand(2.0, AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW)));
           }
        }
        else
        {
           if(FindSubString(sItemTag,"scure")== -1)
              DelayCommand(0.5, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        }
        if(sType=="CLW") nToHeal=d8(1)+1;
        if(sType=="CMW") nToHeal=d8(2)+3;
        if(sType=="CSW") nToHeal=d8(3)+5;
        if(sType=="CCW") nToHeal=d8(4)+7;
        //Fire cast spell at event for the specified target
        SignalEvent(oOther, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_LIGHT_WOUNDS, FALSE));
        // 5.5 call heal function.
        // hcr3.1
        //nToHeal = HCRHeal(oOther, nToHeal);
        //Apply VFX impact and heal effect
        eHeal = EffectHeal(nToHeal);
        DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oOther));
        DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oOther));
        if(FindSubString(sItemTag,"scure")== -1)
           DestroyObject(oItem);
}
