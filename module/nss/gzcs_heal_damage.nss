#include "gzinc_effecttool"

void main()
{
    int nGold = GetLocalInt(GetModule(),"T1_MODULE_HEALER_HEAL");
    if (GetGold(GetPCSpeaker())>=nGold)
    {
        TakeGoldFromCreature(nGold, GetPCSpeaker());
        ActionPauseConversation();
        ActionCastFakeSpellAtObject(SPELL_HEAL,GetPCSpeaker());
          //Apply the heal effect and the VFX impact
          effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_M);
          DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, GetPCSpeaker()));
        ActionDoCommand(GZRemovePhysicalDamage(GetPCSpeaker()));
        ActionResumeConversation();
    }
    else
    ActionSpeakString("Sorry, you cannot afford my services!");

}
