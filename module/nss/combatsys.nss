/*
 * ----------------------------------------------------------------------------
 * "COMPLETO-WARE LICENSE" (Revision 42):
 * <capcrunch@gmail.com> Escribio esto.Mientras mantengas esta nota puedes hacer
 * lo que quieras con este codigo.Si algun dia nos conocemos, y crees que este
 * codigo lo vale, puedes comprarme un completo en agradecimiento.
 * ----------------------------------------------------------------------------
 */

 /* Combat System  semi merp no tan brutal :

 On damaged  roll a d100 if it is 1  roll again d20 to check for effects of the blow



*/

const int  CABEZA   = 1;
const int  TORAX    = 2 ;
const int  PIERNAS  = 3;
const int  BRAZOS   = 4 ;

/*
const int  FULLPLATE = 5; AC 5 -8
const int  MEDIUM_ARMOR = 6;  AC 5-4
const int  LIGHT_ARMOR = 7;   AC 3-1
 */

//Effects :

void ceguera(object oDamaged) {

effect eBlind = EffectBlindness();
effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oDamaged);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oDamaged,RoundsToSeconds(2));
}

void Stun_Confuse(object oDamaged) {

 effect eStun = EffectStunned();
 effect eConfused = EffectConfused();

 effect eVis = EffectVisualEffect(VFX_IMP_STUN);
 effect eVisconfusion = EffectVisualEffect(VFX_IMP_CONFUSION_S);

      if(d2() > 1) {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oDamaged);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oDamaged,RoundsToSeconds(2));
     } else  {

       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisconfusion, oDamaged);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConfused, oDamaged,RoundsToSeconds(2));
  }

}


  void Sordera(object oDamaged) {
    // Create the effect to apply
    effect eDeaf = EffectDeaf();

    // Create the visual portion of the effect. This is instantly
    // applied and not persistant with wether or not we have the
    // above effect.
    effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);

    // Apply the visual effect to the target
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oDamaged);
    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oDamaged,RoundsToSeconds(2));

 }

 void Attack_penalty(object oDamaged) {



// This is the Object to apply the effect to.

    // Create the effect to apply
    effect eAttackDecrease = EffectAttackDecrease(d4());

    // Create the visual portion of the effect. This is instantly
    // applied and not persistant with wether or not we have the
    // above effect.
    //effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

    // Apply the visual effect to the target
  //  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oDamaged);
    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackDecrease, oDamaged,RoundsToSeconds(2));

 }


 void knockdown(object oDamaged) {




 // Create the effect to apply
    effect eKnockdown = EffectKnockdown();

    // Create the visual portion of the effect. This is instantly
    // applied and not persistant with wether or not we have the
    // above effect.
   // effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);

    // Apply the visual effect to the target
   // ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oDamaged,RoundsToSeconds(2));
}


void movement_penalty(object oDamaged) {




 // Create the effect to apply
    effect eSlowDown = EffectMovementSpeedDecrease(50);


    // Apply the visual effect to the target
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oDamaged);
    // Apply the effect to the object
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlowDown, oDamaged,RoundsToSeconds(2));
}


int Check_gear(object oDamaged , int Slot) {

object oItem;

   oItem=GetItemInSlot(Slot, oDamaged);

   //unequip if valid
   if (GetIsObjectValid(oItem) ) return 1;
   else return 0 ;

}

/*
int check_armor(object oDamaged ){

object oItem;

   oItem=GetItemInSlot(INVENTORY_SLOT_CHEST, oDamaged);
   int nAC = GetItemACValue(oItem);

   //unequip if valid
   if (GetIsObjectValid(oItem) && (nAC > 5) ) return 5;
   if (GetIsObjectValid(oItem) && (nAC >= 4) &&(nAC <=5) ) return 6;
   if (GetIsObjectValid(oItem) && (nAC < 4) ) return 7;


}
 */



void Head_Damage(object oDamaged) {


      if(Check_gear(oDamaged,INVENTORY_SLOT_HEAD) == 1) {

      switch(d2()) {

         case 1 :  Sordera(oDamaged) ;
                   SendMessageToPC(oDamaged,"<cþ>El golpe a pegado en tu casco el sonido del impacto te ensordece</c>");
                    break ;
         case 2 :  ceguera(oDamaged);
                   SendMessageToPC(oDamaged,"<cþ>Te han golpeado la visera del casco</c>");
                    break ;
                 }

       }   else  {

       Stun_Confuse(oDamaged);
       SendMessageToPC(oDamaged,"<cþ>Te han golpeado la cabeza </c>");

    }
}

 void  Arm_Damage(object oDamaged) {


if(Check_gear(oDamaged,INVENTORY_SLOT_LEFTHAND) != 1 ){

                     Attack_penalty(oDamaged);
                     SendMessageToPC(oDamaged,"<cþ>Te han herido en el brazo </c>");

            }

}


void Leg_Damage(object oDamaged) {

    switch(d4()) {

    case 1 :      SendMessageToPC(oDamaged,"<cþ>Un corte en tu pierna </c>");
                  movement_penalty(oDamaged);
                  break;
    case 2 :      SendMessageToPC(oDamaged,"<cþ>Un golpe en la rodilla te hace perder el equilibrio </c>");
                  knockdown(oDamaged);
                  break;
            }


}

void Core_Combat(object oDamaged) {


  if(d100() > 95 ) {

  int BODY_PART = d4() ;


  switch (BODY_PART) {



  case 1 :    Head_Damage(oDamaged);
              break;

  case 2 :    //aca torax damaged ;
                break;

  case 3 :    Leg_Damage(oDamaged);
                break;

  case 4 :   Arm_Damage(oDamaged);
               break;

       }

    }
}



















