// HCR v3.4.0 21st July, 2008
// * Cleaned up & removed redundant code
// * Moved dropping of bedroll to after conversation
// * Added new wandering monster check to ApplySleepEffects()
//   Note - requires new hc_inc_wandering
// * Added party rest in shifts variable(set in hc_defaults)
// * Added player state safety check(If dead and resting somethings up!)

//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_On_Play_Rest
//::////////////////////////////////////////////////////////////////////////////

#include "HC_Inc"
#include "HC_Inc_HTF"
#include "HC_Inc_On_Rest"
#include "HC_Inc_TimeCheck"
#include "HC_Text_Rest"
#include "X2_Inc_ItemProp"
#include "HC_Inc_Wandering"
#include "x3_inc_horse"

//::////////////////////////////////////////////////////////////////////////////
int iRESTSYSTEM,iRESTBREAK,iREALFAM,iBEDROLLSYSTEM,iFOODSYSTEM, iHUNGERSYSTEM,
iLIMITEDRESTHEAL,iRESTARMORPEN,iWANDERSYSTEM,iBLEEDSYSTEM,iPARTYREST,iMinRest,
iFATIGUESYSTEM,iRESTCONV,iBADREST,iRESTINSHIFTS,nRestHP,nSSB,nHasFood,iCount;

object oBedroll;
//::////////////////////////////////////////////////////////////////////////////

//Return the rest variables
void InitRestVariables();

//Check for bad effects
int CheckBadEffects(object oPC);

//Party rest option code
void PartyRest(object oPC);

//Return if they have food?
object GetPCRestFood(object oPC);

//Does PC have food to rest?
int DoesPCHaveFoodToRest(object oPC);

//Rest started set the rest timer
void SetRestTime(object oPC);

//Return if they have familiar or companion
object GetPCFamiliar(object oPC);

//Save pre-rest familiar hp's
void SavePreRestFamiliarHP(object oPC, object oFam);

//Return pet damage
void pet_rest_dam(object oFam, object oPC, int nAny=0);

//Return if party member is already resting?
int PartyRestInShifts(object oPC);

//Do they have a bedroll?
int DoesPCHaveBedroll(object oPC);

//Is it too soon to rest?
int IsTooSoonToRest(object oPC);

//Is PC too hungry or thirsty to rest?
int IsPCTooHungryToRest(object oPC);

//Apply sleep effects
void ApplySleepEffects(object oPC);

//Remove the sleep blindness
void RemoveSleepBlindness(object oPC);

//Do limited rest healing
void DoLimitedRestDamage(object oPC, object oFam, int ExtraPostRestHealing = 0, int nLastRestType = 0);

//Replace bedroll
void ReplaceBedroll(object oPC);

//Apply armour penalty
void ApplyArmorRestPenalty(object oPC);

void InitRestVariables()
{
    iRESTSYSTEM      = GetLocalInt(oMod, "RESTSYSTEM");
    iRESTINSHIFTS    = GetLocalInt(oMod,"RESTINSHIFTS");//New 18th May, 2005 -SE
    iRESTCONV        = GetLocalInt(oMod, "RESTCONV");
    iREALFAM         = GetLocalInt(oMod,"REALFAM");
    iBEDROLLSYSTEM   = GetLocalInt(oMod, "BEDROLLSYSTEM");
    iFOODSYSTEM      = GetLocalInt(oMod, "FOODSYSTEM");
    iHUNGERSYSTEM    = GetLocalInt(oMod, "HUNGERSYSTEM");
    iLIMITEDRESTHEAL = GetLocalInt(oMod, "LIMITEDRESTHEAL");
    iRESTARMORPEN    = GetLocalInt(oMod, "RESTARMORPEN");
    iWANDERSYSTEM    = GetLocalInt(oMod,"WANDERSYSTEM");
    iBLEEDSYSTEM     = GetLocalInt(oMod, "BLEEDSYSTEM");
    iRESTBREAK       = GetLocalInt(oMod,"RESTBREAK");
    iMinRest         = GetLocalInt(oMod,"RESTBREAK")*nConv;
    iPARTYREST       = GetLocalInt(oMod,"PARTYREST");
    iFATIGUESYSTEM   = GetLocalInt(oMod,"FATIGUESYSTEM");
    iBADREST         = GetLocalInt(oMod, "BADREST");
    nSSB             = SecondsSinceBegin();
}
//::////////////////////////////////////////////////////////////////////////////
int CheckBadEffects(object oPC)
{
    if (iBADREST)
       return 0;

    effect eBad = GetFirstEffect(oPC);
    while(GetIsEffectValid(eBad))
    {
       int nEtype=GetEffectType(eBad);
       if (nEtype == EFFECT_TYPE_CHARMED    || nEtype == EFFECT_TYPE_CURSE     ||
           nEtype == EFFECT_TYPE_DOMINATED  || nEtype == EFFECT_TYPE_DARKNESS  ||
           nEtype == EFFECT_TYPE_ENTANGLE   || nEtype == EFFECT_TYPE_BLINDNESS ||
           nEtype == EFFECT_TYPE_DEAF       || nEtype == EFFECT_TYPE_PARALYZE  ||
           nEtype == EFFECT_TYPE_FRIGHTENED || nEtype == EFFECT_TYPE_DAZED     ||
           nEtype == EFFECT_TYPE_CONFUSED   || nEtype == EFFECT_TYPE_POISON    ||
           nEtype == EFFECT_TYPE_PARALYZE   || nEtype == EFFECT_TYPE_SLEEP     ||
           nEtype == EFFECT_TYPE_STUNNED    || nEtype == EFFECT_TYPE_TURNED    ||
           nEtype == EFFECT_TYPE_SILENCE    || nEtype == EFFECT_TYPE_DISEASE)
       {
          SendMessageToPC(oPC, NOTWELL);
          AssignCommand( oPC, ClearAllActions());
          return 1;
       }
       eBad = GetNextEffect(oPC);
    }
 return 0;
}
//::////////////////////////////////////////////////////////////////////////////
void PartyRest(object oPC)
{
   object oPlayer = GetFirstFactionMember(oPC);
   while (GetIsObjectValid(oPlayer))
   {
     if (GetIsInCombat(oPlayer)|| (GetArea(oPC) != GetArea(oPlayer)
        && GetTag(GetArea(oPlayer)) != "FuguePlane") || IsInConversation(oPC))
     {
        SendMessageToPC(oPC, PCANTREST);
        return;
     }
     oPlayer = GetNextFactionMember(oPC);
   }
   SetLocalInt(oMod, "PREST", TRUE);
   // hcr3
   AssignCommand(oPC, ActionStartConversation(oPC, "hc_c_lprest", TRUE, FALSE));
}
//::////////////////////////////////////////////////////////////////////////////
int PartyRestInShifts(object oPC)
{
    // added party rest check
    if(iRESTINSHIFTS)
    {
       object oPM=GetFirstFactionMember(oPC);
       while(GetIsObjectValid(oPM))
       {
          if(GetLocalInt(oPM,"RESTING") && oPM != oPC)
          {
             AssignCommand(oPC, ClearAllActions());
             SendMessageToPC(oPC,"You cannot rest while another party member is resting, sleep in shifts.");
             //Reset so convo starts again on next try - SE
             SetLocalInt(oPC,"RESTING",0);
             return 1;
          }
            oPM=GetNextFactionMember(oPC);
       }
    }
    return 0;
}
//::////////////////////////////////////////////////////////////////////////////
object GetPCRestFood(object oPC)
{
    object oMyFood;
    object oEquip = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oEquip))
    {
       if(!FindSubString(GetTag(oEquip),"Food"))
       {
          oMyFood = oEquip;
          break;
       }
       oEquip = GetNextItemInInventory(oPC);
    }
    return oMyFood;
}
//::////////////////////////////////////////////////////////////////////////////
int DoesPCHaveFoodToRest(object oPC)
{
    int nNotOkToRest = 0;
    if(iRESTSYSTEM && iFOODSYSTEM && !nHasFood && !iHUNGERSYSTEM)
    {
       FloatingTextStringOnCreature(TOOHUNGRY, oPC, FALSE);
       AssignCommand( oPC, ClearAllActions());
       nNotOkToRest = 1;
    }
    return nNotOkToRest;
}
//::////////////////////////////////////////////////////////////////////////////
void SetRestTime(object oPC)
{
    float fDelay = HoursToSeconds(iRESTBREAK);
    string sRestTimer = GetPlayerID(oPC) + "RestTimer";

    if(iBEDROLLSYSTEM)
    {
        // using the bedroll system but bedroll: double the delay
        if(DoesPCHaveBedroll(oPC) == FALSE)
        {
           SendMessageToPC(oPC, "Doubling timer");//debug
           fDelay *= 2.0;
        }
    }

    // schedule hourly count down and deletion
    float fHours;
    while(fHours < fDelay)
    {
       DelayCommand(fHours, SetLocalFloat(oMod, sRestTimer, fDelay - fHours));
       fHours += 60.0;
    }
    DelayCommand(fDelay, DeleteLocalFloat(oMod, sRestTimer));

    // allow eating of food
    if(GetLocalInt(oPC, "ATEFOOD") == FALSE)
    {
        if(iFOODSYSTEM && !iHUNGERSYSTEM)
        {
           object oFood = GetPCRestFood(oPC);
           SendMessageToPC(oPC, EATFOOD + " [" + GetName(oFood) + "]");
           SetLocalInt(oPC, "ATEFOOD", TRUE);
           DestroyObject(oFood);
        }
    }
}
//::////////////////////////////////////////////////////////////////////////////
object GetPCFamiliar(object oPC)
{
    object oFam=GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    if(!GetIsObjectValid(oFam))
       oFam=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    return oFam;
}
//::////////////////////////////////////////////////////////////////////////////
void SavePreRestFamiliarHP(object oPC, object oFam)
{
    if(iLIMITEDRESTHEAL)
    {
        if(GetIsObjectValid(oFam) && !GetLocalInt(oPC,"RESTING"))
        {
            SetLocalInt(oPC,"FamiliarHealth",GetCurrentHitPoints(oFam));
        }
    }
}
//::////////////////////////////////////////////////////////////////////////////
void pet_rest_dam(object oFam, object oPC, int nAny=0)
{
    int nSHP = GetLocalInt(oPC,"FamiliarHealth");
    int nHD = GetHitDice(oPC);
    int nRestHP = GetCurrentHitPoints(oFam);
    if(nRestHP > nSHP+nHD || nAny)
    {
       int nDam = (nRestHP-(nSHP+nHD));
       if(nAny)
       nDam = nRestHP-nSHP;
       effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
       ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oFam);
    }
}
//::////////////////////////////////////////////////////////////////////////////
int DoesPCHaveBedroll(object oPC)
{
    oBedroll = GetItemPossessedBy(oPC,"bedroll");
    if (GetIsObjectValid(oBedroll))
        return 1;
    else
    {
       oBedroll = GetLocalObject(oMod,"inbedroll" + GetPlayerID(oPC));
       if (GetIsObjectValid(oBedroll))
           return 1;
    }

    return 0;
}

//::////////////////////////////////////////////////////////////////////////////
int IsTooSoonToRest(object oPC)
{
    int nNotOkToRest = 0;
    string sRestTimer = GetPlayerID(oPC) + "RestTimer";

    // calculate time remaining till rest
    string sRestIn = FloatToString(GetLocalFloat(oMod, sRestTimer) / HoursToSeconds(1), 0, 0);
    string sRestText = GetName(oPC) + " is not tired enough, try again in " + sRestIn + " hour/s";

    if(GetLocalFloat(oMod, sRestTimer)> 0.0 && GetPersistentInt(GetArea(oPC), "ALLOWREST") == FALSE)
    {
       AssignCommand(oPC, ClearAllActions());
       FloatingTextStringOnCreature(sRestText, oPC, FALSE);
       nNotOkToRest = 1;
    }

    return nNotOkToRest;
}
//::////////////////////////////////////////////////////////////////////////////
int IsPCTooHungryToRest(object oPC)
{
    int nNotOkToRest = 0;
    if(iRESTSYSTEM && iHUNGERSYSTEM)
    {
        int nHungerThirstRating = IsPCVeryHungryOrThirsty(oPC);
        if (nHungerThirstRating > 0)
        {
           if (nHungerThirstRating==1)
               FloatingTextStringOnCreature(TOOHUNGRY, oPC, FALSE);
           if (nHungerThirstRating==2)
               FloatingTextStringOnCreature(TOOTHIRSTY, oPC, FALSE);
           if (nHungerThirstRating==3)
               FloatingTextStringOnCreature(TOOHUNGRYANDTHIRSTY, oPC, FALSE);
           AssignCommand( oPC, ClearAllActions());
           nNotOkToRest = 1;
        }
    }
    return nNotOkToRest;
}
//::////////////////////////////////////////////////////////////////////////////
void ApplySleepEffects(object oPC)
{
    // See HC_Inc_Wandering for more information
    WanderingMonster(oPC);

    effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
    SetLocalInt(oPC,"RESTING",1);
    if (GetRacialType(oPC) != RACIAL_TYPE_ELF && GetRacialType(oPC) != RACIAL_TYPE_HALFELF)
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0);
    //insert special effects here. I tried EffectSleep along with different
    //animations. They either get overrode by the rest anim or cancel the rest.
    if (GetRacialType(oPC) != RACIAL_TYPE_ELF && GetRacialType(oPC) != RACIAL_TYPE_HALFELF)
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0);
    effect eBad = GetFirstEffect(oPC);
    //Search for negative effects
    int nBlindMe=1;
    while(GetIsEffectValid(eBad))
    {
        int nEtype=GetEffectType(eBad);
        if(nEtype==EFFECT_TYPE_TRUESEEING)
            nBlindMe=0;
        eBad=GetNextEffect(oPC);
    }
    if(nBlindMe)
    {
        effect eBlind =  SupernaturalEffect(EffectBlindness());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oPC, 29.0);
    }
    if (GetRacialType(oPC) != RACIAL_TYPE_ELF && GetRacialType(oPC) != RACIAL_TYPE_HALFELF)
        DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0));

    SetPanelButtonFlash(oPC,PANEL_BUTTON_REST,0);
}
//::////////////////////////////////////////////////////////////////////////////
void RemoveSleepBlindness(object oPC)
{
    effect eBad = GetFirstEffect(oPC);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
      int nEtype=GetEffectType(eBad);
      if (nEtype == EFFECT_TYPE_BLINDNESS)
      {
         //Remove effect if it is negative.
         RemoveEffect(oPC, eBad);
      }
     eBad = GetNextEffect(oPC);
    }
}
//::////////////////////////////////////////////////////////////////////////////
void DoLimitedRestDamage(object oPC, object oFam, int ExtraPostRestHealing = 0, int nLastRestType = 0)
{
    int nHD=GetHitDice(oPC);
    // hcr3.1 changed variable.
    int nSHP=GetLocalInt(oPC, "HPStartRest");
    int nDam;
    int nLTC;

    if(GetLocalInt(oMod, "LONGTERMCARE"+GetPlayerID(oPC)) == 2)
        nLTC=GetHitDice(oPC);
    else nLTC=0;

   if(nLastRestType == REST_EVENTTYPE_REST_FINISHED)
    {
      if(nRestHP > (nSHP+nHD+nLTC + ExtraPostRestHealing))
      {
         nDam=(nRestHP - (nSHP+nHD+nLTC + ExtraPostRestHealing));
        int nHeal = nHD + nLTC + ExtraPostRestHealing;
        effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPC);
      }
    }
    else if (GetLocalInt(oPC, "REST"))
    {
       if (nSHP < GetCurrentHitPoints(oPC))
       {
          nDam=(GetCurrentHitPoints(oPC)-nSHP);
          effect eDamage = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
          ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPC);
       }
    }
    SetLocalInt(oMod, "LONGTERMCARE"+GetPlayerID(oPC), 0);

    if(GetIsObjectValid(oFam))
    {
        if(GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED)
           DelayCommand(1.0,pet_rest_dam(oFam, oPC));
        else
           DelayCommand(31.0,pet_rest_dam(oFam, oPC, 1));
    }
}
//::////////////////////////////////////////////////////////////////////////////
void ReplaceBedroll(object oPC)
{
    oBedroll=GetLocalObject(oMod, "inbedroll"+GetPlayerID(oPC));
    CreateItemOnObject("bedroll", oPC);
    DestroyObject(oBedroll);
    DeleteLocalObject(oMod, "inbedroll"+GetPlayerID(oPC));
}
//::////////////////////////////////////////////////////////////////////////////
void ApplyArmorRestPenalty(object oPC)
{
    // Armor penalty.  Check only if rest fully completed.
    if (GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED )
    {
       int bFatigued = GetLocalInt(oPC, "bFatigued");
       int bExhausted = GetLocalInt(oPC, "bExhausted");

       // Check for armor, and give a penalty for armor +5 and above.
       object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
       int nNetAC = GetItemACValue(oArmor);
       int nBonus = IPGetWeaponEnhancementBonus(oArmor, ITEM_PROPERTY_AC_BONUS);
       int nBaseAC = nNetAC - nBonus;
       if (nBaseAC > 5)
       {
          if (!bFatigued && !bExhausted)
              MakePlayerFatigued(oPC,FATIG);
          else
          {
             SetLocalInt(oPC, "bFatigued",FALSE);
             SetLocalInt(oPC, "bExhausted", FALSE);
             MakePlayerExhausted(oPC,EXHAUS);
          }
        }
        else
        {
           SetLocalInt(oPC, "bFatigued",FALSE);
           SetLocalInt(oPC, "bExhausted", FALSE);
        }
    }
}
//::////////////////////////////////////////////////////////////////////////////
void main()
{
    object oPC   = GetLastPCRested();
    object oArea = GetArea(oPC);
    string sID   = GetPlayerID(oPC);
    object oMount;

    if (!GetLocalInt(GetModule(),"X3_MOUNT_NO_REST_DISMOUNT"))
    { // make sure not mounted
        /*  Deva, Jan 17, 2008
            Do not allow a mounted PC to rest
        */
        if (HorseGetIsMounted(oPC))
        { // cannot mount
            if (GetLocalInt(oPC,"X3_REST_CANCEL_MESSAGE_SENT"))
            { // cancel message already played
                DeleteLocalInt(oPC,"X3_REST_CANCEL_MESSAGE_SENT");
            } // cancel message already played
            else
            { // play cancel message
                FloatingTextStrRefOnCreature(112006,oPC,FALSE);
                SetLocalInt(oPC,"X3_REST_CANCEL_MESSAGE_SENT",TRUE); // sentinel
                // value to prevent message played a 2nd time on canceled rest
            } // play cancel message
            AssignCommand(oPC,ClearAllActions(TRUE));
            return;
        } // cannot mount
    } // make sure not mounted

    if (!GetLocalInt(GetModule(),"X3_MOUNT_NO_REST_DESPAWN"))
    { // if there is a paladin mount despawn it
        oMount=HorseGetPaladinMount(oPC);
        if (!GetIsObjectValid(oMount)) oMount=GetLocalObject(oPC,"oX3PaladinMount");
        if (GetIsObjectValid(oMount))
        { // paladin mount exists
            if (oMount==oPC||!GetIsObjectValid(GetMaster(oMount))) AssignCommand(oPC,HorseUnsummonPaladinMount());
            else { AssignCommand(GetMaster(oMount),HorseUnsummonPaladinMount()); }
        } // paladin mount exists
    } // if there is a paladin mount despawn it

    // Get the rest variables
    InitRestVariables();

    // Player state safety check - SE
    int nHP = GetCurrentHitPoints(oPC);
    if(GetTag(GetArea(oPC)) != "FuguePlane")
    {
       int nCurState = GPS(oPC);
       if(nHP > 0 && (nCurState != PWS_PLAYER_STATE_ALIVE))
       {
          SendMessageToAllDMs(GetName(oPC)+" 's player state is incorrect and has been adjusted");
          SPS(oPC, PWS_PLAYER_STATE_ALIVE);
       }
    }

    if(!preEvent()) return;

    // Section 1 - PRI SYSYTEM
    object oPRIForceInnRest = GetNearestObjectByTag("PRIForceInnRest", oPC);
    int iBedUse = GetLocalInt(oPC, "RSA_BedUse");
    if( GetIsObjectValid(oPRIForceInnRest) && !iBedUse )
    {
        AssignCommand( oPC, ClearAllActions());
        SendMessageToPC( oPC, "The local authorities require you to rest in an inn." );
        return;
    }

    // Section 2 - INN REST SYSTEM
    int InnRest = GetLocalInt(oArea, "HCINN");
    if (InnRest)
    {
       ExecuteScript("hc_innrest", oPC);
       if (iFATIGUESYSTEM )
           SetLocalInt(oMod,"FATIGUELEVEL"+sID, INITFATIGUELEVEL);
       return;
    }

    // Section 3 - PREEMTIVE ABORT
    if(!iRESTSYSTEM)
    {
       if (iFATIGUESYSTEM )
           SetLocalInt(oMod,"FATIGUELEVEL"+sID, INITFATIGUELEVEL);
       postEvent();
       return;
    }

    // Section 4 - SET CURRENT HP's
    object oFam = GetPCFamiliar(oPC);
    nRestHP = GetCurrentHitPoints(oPC);

    // Section 5 - Rest in shifts?
    if (PartyRestInShifts(oPC))
        return;

    // Section 6 - REST STARTED
   if(GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
   {
        SavePreRestFamiliarHP(oPC, oFam);
        SetLocalInt(oPC, "HPStartRest", nRestHP);

        nHasFood = 0;
        object oFood;
        if(iFOODSYSTEM && !iHUNGERSYSTEM)
        {
           oFood = GetPCRestFood(oPC);
           if (GetIsObjectValid(oFood))
               nHasFood = 1;
        }

        //Check conditions before allowing to rest
        int iFail = 0;
        iFail = IsTooSoonToRest(oPC);
        if (!iFail)
            iFail = DoesPCHaveFoodToRest(oPC);
        if (!iFail)
            iFail = IsPCTooHungryToRest(oPC);
        if (!iFail)
            iFail = CheckBadEffects(oPC);

        //Continue if conditions met...
        if (!iFail)
        {
            //Start rest conversation if set and break rest
            if (!GetLocalInt(oPC, "REST") && GetIsPC(oPC)&& iRESTCONV)
            {
               AssignCommand(oPC, ClearAllActions());
               if (!iPARTYREST)
               {
                  AssignCommand(oPC, ActionStartConversation(oPC, "hc_c_rest", TRUE, FALSE));
               }
               else if (GetFactionLeader(oPC) == oPC)
                    {
                       PartyRest(oPC);
                    }
               else if (!GetLocalInt(GetFactionLeader(oPC), "REST"))
                    {
                       AssignCommand(oPC, ActionStartConversation(oPC, "hc_c_prest", TRUE, FALSE));
                    }
               SetLocalInt(oPC, "REST", FALSE);
               return;
             }
             else
             {
                SetLocalInt(oPC, "REST", TRUE);
             }

             if (iPARTYREST && (GetFactionLeader(oPC) == oPC))
                // 5.5 added code for using rest break timeinstead of 8 hours fixed.
                SetTime(GetTimeHour()+iRESTBREAK, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());

             //Set the rest timer ONLY if they are not in a free rest area
             if(!GetPersistentInt( GetArea(oPC), "ALLOWREST"))
             {
                DelayCommand(1.5, SetRestTime(oPC));
             }

             //Rest system on and they have a bedroll?
             if (iBEDROLLSYSTEM && DoesPCHaveBedroll(oPC))
             {
                SetLocalInt(oMod, "LostBedroll"+sID,TRUE);
                DestroyObject(oBedroll);
                object oNewBedroll = CreateObject(OBJECT_TYPE_PLACEABLE,"bedroll", GetLocation(oPC));
                SetLocalObject(oMod,"inbedroll"+sID, oNewBedroll);
             }

          ApplySleepEffects(oPC);
        }
     }

    int nLastRestType = GetLastRestEventType();
    int iFinished = FALSE;
    if (nLastRestType == REST_EVENTTYPE_REST_FINISHED || nLastRestType == REST_EVENTTYPE_REST_CANCELLED)
    {
        DeleteLocalObject(oPC, "RESTOBJ");
        RemoveSleepBlindness(oPC);
        int ExtraPostRestHealing = 0;
        SetLocalInt(oPC,"RESTING",0);
        if(nLastRestType == REST_EVENTTYPE_REST_FINISHED)
        {
            iFinished = TRUE;
            if(!GetIsDM(oPC))
                SetPersistentInt(oMod, ("LastRest" +sID), nSSB);
        }

        DeleteLocalInt(oPC, "REST");

        //If set do limited healing on rest
        if(iLIMITEDRESTHEAL)
        {
           DoLimitedRestDamage( oPC, oFam, ExtraPostRestHealing, nLastRestType);
        }
        //If using the bedroll system and lost bedroll on rest replae bedroll
        if (iBEDROLLSYSTEM && (GetLocalInt(oMod, "LostBedroll" +sID)))
        {
           ReplaceBedroll(oPC);
           DeleteLocalInt(oMod, "LostBedroll" +sID);
        }
        //If using resting in armour penalties do check
        if(iRESTARMORPEN)
        {
           ApplyArmorRestPenalty(oPC);
        }

        if (nLastRestType == REST_EVENTTYPE_REST_FINISHED)
        {
          DeleteLocalInt(oPC, "ATEFOOD");
          // Added party rest system code to advance time once per rest complete
          if (iPARTYREST && GetLocalInt(oMod, "PREST"))
          {
              DeleteLocalInt(oMod, "PREST");
              // 5.5 added code to use restbreak time instead of 8 fixed.
              SetTime(GetTimeHour()+iRESTBREAK, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());
              nSSB=SecondsSinceBegin();
              if(!GetIsDM(oPC))
                SetPersistentInt(oMod, ("LastRest" +sID), nSSB);
          }

          ExecuteScript("st_resetspells", GetLastPCRested());

          if (GetLocalInt(oMod, "DECONENTER"))
              SetLocalInt(oMod, sID+"NOTRESTED", FALSE);
        }
    }

    if (iFATIGUESYSTEM && (nLastRestType == REST_EVENTTYPE_REST_FINISHED))
        SetLocalInt(oMod,"FATIGUELEVEL" +sID, INITFATIGUELEVEL);

    postEvent();
}

