//  ----------------------------------------------------------------------------
//  hc_act_skinning
//  ----------------------------------------------------------------------------
/*
    OnActivate event script for skinning knife item.
*/
//  ----------------------------------------------------------------------------
/*
    HCR 3.02 - 26 July 2004 - Sunjammer
    - rewritten
*/
//  ----------------------------------------------------------------------------
#include "hc_inc_npccorpse"
#include "hc_text_activate"


//  ----------------------------------------------------------------------------
//  CONSTANTS
//  ----------------------------------------------------------------------------

const string HC_RES_SKINNING_MEAT   = "it_mmidmisc006";


//  ----------------------------------------------------------------------------
//  FUNCTIONS
//  ----------------------------------------------------------------------------

void HC_ActionButcherAnimal()
{
    object oPC = OBJECT_SELF;

    FloatingTextStringOnCreature("*" + GetName(oPC) + SKINNING, oPC);
    CreateObject(OBJECT_TYPE_ITEM, HC_RES_SKINNING_MEAT, GetLocation(oPC));
}


//  ----------------------------------------------------------------------------
//  MAIN
//  ----------------------------------------------------------------------------

void main()
{
    object oPC = OBJECT_SELF;
    object oCorpse = GetLocalObject(oPC, "OTHER");
    object oBody = GetLocalObject(oCorpse, HC_VAR_NPCCORPSE_BODY);

    DeleteLocalObject(oPC, "OTHER");

    // pre-emptive abort for invalid objects
    if(GetIsObjectValid(oCorpse) == FALSE
    || GetIsObjectValid(oBody) == FALSE)
    {
        return;
    }

    // the body must be an animal, must be dead and must be within 3m to be
    // successfully skinned.

    if(GetRacialType(oBody) != RACIAL_TYPE_ANIMAL)
    {
        SendMessageToPC(oPC, ANIMALONLY);
        return;
    }

    if(GetIsDead(oBody) == FALSE)
    {
        SendMessageToPC(oPC, NOTDEAD);
        return;
    }

    if(GetDistanceBetween(oPC, oBody) > 3.0)
    {
        SendMessageToPC(oPC, MOVECLOSER);
        return;
    }

    // skin the body: animate the PC, create the product and destroy the body
    AssignCommand(oPC, ActionMoveToLocation(GetLocation(oBody)));
    AssignCommand(oPC, DelayCommand(1.0, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.0)));
    AssignCommand(oPC, DelayCommand(2.0, HC_ActionButcherAnimal()));
    HC_NPCCorpse_CleanUp(oCorpse);
}

