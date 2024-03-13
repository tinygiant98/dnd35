/*
ARMOR ENCUMBRANCE AND RACIAL MOVEMENT RATES INCLUDE - hc_inc_movement

Credits:
Kornstalxs, who did the original code and Kerry Solberg who modified it.
Adapted to HCR 3.3.0b by CFX

*/
// Debug Messages:  set to 0 to deactivate; set to 1 to activate
const int CRP_DEBUG = 0;

//The % movement penalty for Halfling, Dwarves, and Gnomes
const int SML_CREATURE_MOVEPEN = 20;
//The % AC encumbrance movement penalty for Humans, Elves, Halfelves, and Halforcs
const int MDM_CREATURE_ARMORPEN = 20;
//The % AC encumbrance movement penalty for Halflings, Dwarves, and Gnomes
const int SML_CREATURE_ARMORPEN = 15;

const string MSG = "Armor/Shield Applies: Movement Rate: ";

#include "x2_inc_itemprop"

//Apply armor encumbrance penalties to oObject
void EffectArmorEncumbrance(object oObject);

//Remove armor encumbrance penalties from oObject
void RemoveArmorEncumbrance(object oObject);

//Sets movement rates to more closely match the 3.5 D&D rules.
void SetRacialMovementRate(object oCreature);

void SetRacialMovementRate(object oCreature)
{
    if(GetLocalInt(oCreature, "RACIAL_MOVEMENT") == 1)
        return;

    int nType = GetRacialType(oCreature);
    if(nType == RACIAL_TYPE_ANIMAL || nType == RACIAL_TYPE_BEAST ||
       nType == RACIAL_TYPE_DRAGON || nType == RACIAL_TYPE_MAGICAL_BEAST ||
       nType == RACIAL_TYPE_VERMIN) return;

    if(GetCreatureSize(oCreature) == CREATURE_SIZE_SMALL || nType == RACIAL_TYPE_DWARF)
   {
        if(CRP_DEBUG == 1) SendMessageToPC(oCreature, "Setting Racial Movement");
        effect eRate = SupernaturalEffect(EffectMovementSpeedDecrease(SML_CREATURE_MOVEPEN));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRate, oCreature);
        SetLocalInt(oCreature, "RACIAL_MOVEMENT", 1);
        return;
   }
}
void EffectArmorEncumbrance(object oObject)
{

    object oArmor = GetPCItemLastEquipped();
    if(GetBaseItemType(oArmor) != BASE_ITEM_ARMOR)
        return;
    if(GetRacialType(oObject) == RACIAL_TYPE_DWARF)
        return;

    int nNetAC = GetItemACValue(oArmor);
    int nBonus = IPGetWeaponEnhancementBonus(oArmor, ITEM_PROPERTY_AC_BONUS);
    int nBaseAC = nNetAC - nBonus;
    float fMod;

    switch(nBaseAC)
    {
        case 0: case 1: case 2: case 3: return;
        case 4: case 5: fMod = 2.5f; break;
        default: fMod = 1.0f;
    }
    effect ePenalty;
    int nRate;
    if(GetCreatureSize(oObject) == CREATURE_SIZE_SMALL)
    {
        nRate = FloatToInt(SML_CREATURE_ARMORPEN / fMod);
        ePenalty = SupernaturalEffect(EffectMovementSpeedDecrease(nRate));
    }
    else
    {
        nRate = FloatToInt(MDM_CREATURE_ARMORPEN / fMod);
        ePenalty = SupernaturalEffect(EffectMovementSpeedDecrease(nRate));
    }
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenalty, oObject);
    SendMessageToPC(oObject, MSG + "Decreased " + IntToString(nRate) + "%");

}
void RemoveArmorEncumbrance(object oObject)
{
    object oArmor = GetPCItemLastUnequipped();
    if(GetBaseItemType(oArmor) != BASE_ITEM_ARMOR)
        return;
    if(GetRacialType(oObject) == RACIAL_TYPE_DWARF)
        return;
    int nType;
    effect ePenalty = GetFirstEffect(oObject);
    while(GetIsEffectValid(ePenalty))
    {
        nType = GetEffectType(ePenalty);
        if(CRP_DEBUG >= 1) SendMessageToPC(OBJECT_SELF, IntToString(nType));
        if(GetEffectCreator(ePenalty) == OBJECT_SELF &&
           nType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE &&
           GetEffectSubType(ePenalty) == SUBTYPE_SUPERNATURAL)
        {
            RemoveEffect(oObject, ePenalty);
        }
        ePenalty = GetNextEffect(oObject);
    }
    SendMessageToPC(oObject, MSG + "Normal");
    SetLocalInt(oObject, "RACIAL_MOVEMENT", 0);
    DelayCommand(0.5, SetRacialMovementRate(oObject));
}
