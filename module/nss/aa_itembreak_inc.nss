//:://////////////////////////////////////////////
//:: Created By: Raasta
//:: Created On: 4/3/04
//:://////////////////////////////////////////////

// DEBUG MODE - TRUE is ON / FALSE if OFF
// Set this to FALSE to not see the debug info
// Set this to TRUE to see all debug info
// (Default = TRUE)
int DEBUGME = FALSE;

// void DoCheckMissleReturn(object oAttacker, object oTarget, object oWeapon);
// ================================================================
// This funtion Checks to see if the weapon (oWeapon) being used by (oAttacker)
// is a valid ranged weapon on (oTarget).  If so then it rolls a base chance and
// creates a duplicate of the missle on the target.  So on death there is a chance
// of recovering your missle weapons.
void DoCheckMissleReturn(object oAttacker, object oTarget, object oWeapon);

// int GetIsWeaponAmmoReturnable(object oWeapon);
// ================================================================
// This function returns TRUE if the weapon is ranged
// and returns FALSE if it is not.
int GetIsWeaponAmmoReturnable(object oWeapon);

// int DoGetMagicItemBonus(object oWeapon);
// ================================================================
// This function is used with the DoSetItemMax function to determine
// the ItemMax HitPoints.  This is set through a loop that will determine
// all the magic properties and add them up to get a total.  The iMax +
// values can be changed to suit your taste.
int DoGetMagicItemBonus(object oWeapon);

// int DoGetBaseItemBonus(object oWeapon);
// ================================================================
// This function is used with the DoSetItemMax function to determine
// the ItemMax HitPoints.  This is will determine the base item type
// and set the base hit points for that item.  The iMax + values can
// be changed to suit your taste.
int DoGetBaseItemBonus(object oWeapon);

// void DoSetItemMax(object oWeapon, object oPC);
// ================================================================
// This function will get the base item type (base hit points) and
// then check to see if there are magic item properties on it if so
// it will add all these up to get the ItemMax Hit Points.  This is
// a variable stored on the item itsself.
void DoSetItemMax(object oWeapon, object oPC);


// void DoWeaponBreakageAdvance(object oAttacker, object oWeapon, int iCurrent);
// ================================================================
// This function will advance the damage on an item (subtract hit points)
// from the MaxHit Points of an item damaged.  Note, there is a 3% chance
// that damage done to an item can be 'exceptional'.  Exceptional damage
// will do 2d20 points of damage.
void DoWeaponBreakageAdvance(object oAttacker, object oWeapon, int iCurrent);


// void DoWeaponBreakage(object oAttacker, object oTarget, object oWeapon);
// ================================================================
// This is the base function that will check if an item is valid and if it
// has a set MaxHit Points.  If not then it will create a new MaxHit point
// value and do calculations against the weapon.
void DoWeaponBreakage(object oAttacker, object oTarget, object oWeapon);


// void DoArmorItemBreakage(object oAttacker, object oTarget);
// ================================================================
// This is the base function that will check if an item is valid and if it
// has a set MaxHit Points.  If not then it will create a new MaxHit point
// value and do calculations against the armor or worn item (this includes
// all worn item slots).
void DoArmorItemBreakage(object oAttacker, object oTarget);

/////////////////////////////////////////////////////////////////////////
// Get bonus for being a dwarven metal weapon or a elven metal weapon
//
int GetRaceMadebonus(object oWeapon);
/////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////
// FUNCTIONS
////////////////////////////////////////////////////////////////////////////

int  GetRaceMadebonus(object oWeapon) {

int bonus= 0 ;

string weapontag = GetTag(oWeapon);
string elven = GetSubString(weapontag , 0,4) ;
string dwarf = GetSubString(weapontag , 0,2) ;

 if (GetStringLowerCase(dwarf) == GetStringLowerCase("dwf")) bonus = 1500 ;
 if (GetStringLowerCase(elven) == GetStringLowerCase("elven")) bonus = 1000 ;

    return bonus ;

}





void DoCheckMissleReturn(object oAttacker, object oTarget, object oWeapon)
{
    int iWeapon = GetBaseItemType(oWeapon);
    int iRandRoll = d20();
    int iRandBreak = d100();

    switch(iWeapon)
    {
        case BASE_ITEM_DART:
            if(iRandBreak >= 5)
            {
                string sAmmoResRef = GetResRef(oWeapon);
                CreateItemOnObject(sAmmoResRef, oTarget, 1);
            }
            break;
        case BASE_ITEM_HEAVYCROSSBOW:
            if(iRandBreak <= 12)
            {
                object oAmmo = GetItemInSlot(INVENTORY_SLOT_BOLTS, oAttacker);
                if(GetIsObjectValid(oAmmo) == TRUE)
                {
                    string sAmmoResRef = GetResRef(oAmmo);
                    CreateItemOnObject(sAmmoResRef, oTarget, 1);
                }
            }
            break;
        case BASE_ITEM_LIGHTCROSSBOW:
            if(iRandBreak <= 12)
            {
                object oAmmo = GetItemInSlot(INVENTORY_SLOT_BOLTS, oAttacker);
                if(GetIsObjectValid(oAmmo) == TRUE)
                {
                    string sAmmoResRef = GetResRef(oAmmo);
                    CreateItemOnObject(sAmmoResRef, oTarget, 1);
                }
            }
            break;
        case BASE_ITEM_LONGBOW:
            if(iRandBreak <= 12)
            {
                object oAmmo = GetItemInSlot(INVENTORY_SLOT_ARROWS, oAttacker);
                if(GetIsObjectValid(oAmmo) == TRUE)
                {
                    string sAmmoResRef = GetResRef(oAmmo);
                    CreateItemOnObject(sAmmoResRef, oTarget, 1);
                }
            }
            break;
        case BASE_ITEM_SHORTBOW:
            if(iRandBreak <= 12)
            {
                object oAmmo = GetItemInSlot(INVENTORY_SLOT_ARROWS, oAttacker);
                if(GetIsObjectValid(oAmmo) == TRUE)
                {
                    string sAmmoResRef = GetResRef(oAmmo);
                    CreateItemOnObject(sAmmoResRef, oTarget, 1);
                }
            }
            break;
        case BASE_ITEM_SHURIKEN:
            if(iRandBreak >= 5)
            {
                string sAmmoResRef = GetResRef(oWeapon);
                CreateItemOnObject(sAmmoResRef, oTarget, 1);
            }
            break;
        case BASE_ITEM_SLING:
            if(iRandBreak <= 12)
            {
                object oAmmo = GetItemInSlot(INVENTORY_SLOT_BULLETS, oAttacker);
                if(GetIsObjectValid(oAmmo) == TRUE)
                {
                    string sAmmoResRef = GetResRef(oAmmo);
                    CreateItemOnObject(sAmmoResRef, oTarget, 1);
                }
            }
            break;
        case BASE_ITEM_THROWINGAXE:
            if(iRandBreak >= 5)
            {
                string sAmmoResRef = GetResRef(oWeapon);
                CreateItemOnObject(sAmmoResRef, oTarget, 1);
            }
            break;
        default:
            break;
    }
}


int GetIsWeaponAmmoReturnable(object oWeapon)
{
    int iReturn;
    int iWeapon = GetBaseItemType(oWeapon);

    if( iWeapon == BASE_ITEM_DART ||
        iWeapon == BASE_ITEM_HEAVYCROSSBOW ||
        iWeapon == BASE_ITEM_LIGHTCROSSBOW ||
        iWeapon == BASE_ITEM_LONGBOW ||
        iWeapon == BASE_ITEM_SHORTBOW ||
        iWeapon == BASE_ITEM_SHURIKEN ||
        iWeapon == BASE_ITEM_SLING ||
        iWeapon == BASE_ITEM_THROWINGAXE)    iReturn = TRUE;
    else iReturn = FALSE;

    return iReturn;
}

int DoGetMagicItemBonus(object oWeapon)
{
    int iMax = 1;
    itemproperty ipLoop = GetFirstItemProperty(oWeapon);

    while (GetIsItemPropertyValid(ipLoop))
    {
        int iType = GetItemPropertyType(ipLoop);

        if(iType == ITEM_PROPERTY_ABILITY_BONUS)                                    iMax = iMax + 1000;
        else if(iType == ITEM_PROPERTY_AC_BONUS)                                    iMax = iMax + 1000;
        else if(iType == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP)                 iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE)                     iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)                    iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT)              iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_ARCANE_SPELL_FAILURE)                        iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_ATTACK_BONUS)                                iMax = iMax + 750;
        else if(iType == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)             iMax = iMax + 450;
        else if(iType == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)                iMax = iMax + 250;
        else if(iType == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)          iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION)                  iMax = iMax + 100;
        else if(iType == ITEM_PROPERTY_BONUS_FEAT)                                  iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)                 iMax = iMax + 400;
        else if(iType == ITEM_PROPERTY_CAST_SPELL)                                  iMax = iMax + 1000;
        else if(iType == ITEM_PROPERTY_DAMAGE_BONUS)                                iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP)             iMax = iMax + 700;
        else if(iType == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP)                iMax = iMax + 700;
        else if(iType == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT)          iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_DAMAGE_REDUCTION)                            iMax = iMax + 1200;
        else if(iType == ITEM_PROPERTY_DAMAGE_RESISTANCE)                           iMax = iMax + 1200;
        else if(iType == ITEM_PROPERTY_DAMAGE_VULNERABILITY)                        iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DARKVISION)                                  iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_DECREASED_ABILITY_SCORE)                     iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DECREASED_AC)                                iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER)                   iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DECREASED_DAMAGE)                            iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER)              iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DECREASED_SAVING_THROWS)                     iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC)            iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)                    iMax = iMax + 1;
        else if(iType == ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT)           iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_ENHANCEMENT_BONUS)                           iMax = iMax + 1200;
        else if(iType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP)        iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP)           iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT)    iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE)                     iMax = iMax + 1200;
        else if(iType == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE)                    iMax = iMax + 1200;
        else if(iType == ITEM_PROPERTY_FREEDOM_OF_MOVEMENT)                         iMax = iMax + 900;
        else if(iType == ITEM_PROPERTY_HASTE)                                       iMax = iMax + 900;
        else if(iType == ITEM_PROPERTY_HOLY_AVENGER)                                iMax = iMax + 1500;
        else if(iType == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)                        iMax = iMax + 1500;
        else if(iType == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)                      iMax = iMax + 1500;
        else if(iType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)                     iMax = iMax + 1500;
        else if(iType == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)                       iMax = iMax + 1500;
        else if(iType == ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)                    iMax = iMax + 900;
        else if(iType == ITEM_PROPERTY_IMPROVED_EVASION)                            iMax = iMax + 1200;
        else if(iType == ITEM_PROPERTY_KEEN)                                        iMax = iMax + 1200;
        else if(iType == ITEM_PROPERTY_LIGHT)                                       iMax = iMax + 100;
        else if(iType == ITEM_PROPERTY_MASSIVE_CRITICALS)                           iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_MIGHTY)                                      iMax = iMax + 600;
        else if(iType == ITEM_PROPERTY_MIND_BLANK)                                  iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_ON_HIT_PROPERTIES)                           iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_ON_MONSTER_HIT)                              iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_ONHITCASTSPELL)                              iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_POISON)                                      iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_REGENERATION)                                iMax = iMax + 1100;
        else if(iType == ITEM_PROPERTY_REGENERATION_VAMPIRIC)                       iMax = iMax + 900;
        else if(iType == ITEM_PROPERTY_SAVING_THROW_BONUS)                          iMax = iMax + 600;
        else if(iType == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC)                 iMax = iMax + 600;
        else if(iType == ITEM_PROPERTY_SKILL_BONUS)                                 iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_SPELL_RESISTANCE)                            iMax = iMax + 1000;
        else if(iType == ITEM_PROPERTY_TRUE_SEEING)                                 iMax = iMax + 500;
        else if(iType == ITEM_PROPERTY_TURN_RESISTANCE)                             iMax = iMax + 600;
        else if(iType == ITEM_PROPERTY_UNLIMITED_AMMUNITION)                        iMax = iMax + 800;
        else if(iType == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP)              iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_USE_LIMITATION_CLASS)                        iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE)                  iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT)           iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_USE_LIMITATION_TILESET)                      iMax = iMax + 300;
        else if(iType == ITEM_PROPERTY_VISUALEFFECT)                                iMax = iMax + 100;
        else if(iType == ITEM_PROPERTY_WEIGHT_INCREASE)                             iMax = iMax + 10;

        ipLoop = GetNextItemProperty(oWeapon);
    }

    return iMax;
}


int DoGetBaseItemBonus(object oWeapon)
{
    int iMax = 1;
    int iWeapon = GetBaseItemType(oWeapon);

    if(iWeapon == BASE_ITEM_AMULET)             iMax = iMax + 500;
    else if(iWeapon == BASE_ITEM_ARMOR)         iMax = iMax + 120 + (GetItemACValue(oWeapon)*20);
    else if(iWeapon == BASE_ITEM_ARROW)         iMax = iMax + 5000;
    else if(iWeapon == BASE_ITEM_BASTARDSWORD)  iMax = iMax + 2000;
    else if(iWeapon == BASE_ITEM_BATTLEAXE)     iMax = iMax + 2000;
    else if(iWeapon == BASE_ITEM_BELT)          iMax = iMax + 500;
    else if(iWeapon == BASE_ITEM_BOLT)          iMax = iMax + 5000;
    else if(iWeapon == BASE_ITEM_BOOTS)         iMax = iMax + 500;
    else if(iWeapon == BASE_ITEM_BRACER)        iMax = iMax + 2000;
    else if(iWeapon == BASE_ITEM_BULLET)        iMax = iMax + 5000;
    else if(iWeapon == BASE_ITEM_CLOAK)         iMax = iMax + 500;
    else if(iWeapon == BASE_ITEM_CLUB)          iMax = iMax + 1250;
    else if(iWeapon == BASE_ITEM_DAGGER)        iMax = iMax + 1450;
    else if(iWeapon == BASE_ITEM_DART)          iMax = iMax + 1700;
    else if(iWeapon == BASE_ITEM_DIREMACE)      iMax = iMax + 2300;
    else if(iWeapon == BASE_ITEM_DOUBLEAXE)     iMax = iMax + 2300;
    else if(iWeapon == BASE_ITEM_DWARVENWARAXE) iMax = iMax + 2300;
    else if(iWeapon == BASE_ITEM_GLOVES)        iMax = iMax + 500;
    else if(iWeapon == BASE_ITEM_GOLD)          iMax = iMax + 99999;
    else if(iWeapon == BASE_ITEM_GREATAXE)      iMax = iMax + 2600;
    else if(iWeapon == BASE_ITEM_GREATSWORD)    iMax = iMax + 2600;
    else if(iWeapon == BASE_ITEM_HALBERD)       iMax = iMax + 2200;
    else if(iWeapon == BASE_ITEM_HANDAXE)       iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_HEAVYCROSSBOW) iMax = iMax + 2900;
    else if(iWeapon == BASE_ITEM_HEAVYFLAIL)    iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_HELMET)        iMax = iMax + 800;
    else if(iWeapon == BASE_ITEM_KAMA)          iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_KATANA)        iMax = iMax + 2100;
    else if(iWeapon == BASE_ITEM_KUKRI)         iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_LARGESHIELD)   iMax = iMax + 650;
    else if(iWeapon == BASE_ITEM_LIGHTCROSSBOW) iMax = iMax + 2200;
    else if(iWeapon == BASE_ITEM_LIGHTFLAIL)    iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_LIGHTHAMMER)   iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_LIGHTMACE)     iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_LONGBOW)       iMax = iMax + 2800;
    else if(iWeapon == BASE_ITEM_LONGSWORD)     iMax = iMax + 2100;
    else if(iWeapon == BASE_ITEM_MORNINGSTAR)   iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_QUARTERSTAFF)  iMax = iMax + 1600;
    else if(iWeapon == BASE_ITEM_RAPIER)        iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_RING)          iMax = iMax + 250;
    else if(iWeapon == BASE_ITEM_SCIMITAR)      iMax = iMax + 1900;
    else if(iWeapon == BASE_ITEM_SCYTHE)        iMax = iMax + 2100;
    else if(iWeapon == BASE_ITEM_SHORTBOW)      iMax = iMax + 2100;
    else if(iWeapon == BASE_ITEM_SHORTSPEAR)    iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_SHORTSWORD)    iMax = iMax + 1800;
    else if(iWeapon == BASE_ITEM_SHURIKEN)      iMax = iMax + 500;
    else if(iWeapon == BASE_ITEM_SICKLE)        iMax = iMax + 2300;
    else if(iWeapon == BASE_ITEM_SLING)         iMax = iMax + 2800;
    else if(iWeapon == BASE_ITEM_SMALLSHIELD)   iMax = iMax + 450;
    else if(iWeapon == BASE_ITEM_THROWINGAXE)   iMax = iMax + 500;
    else if(iWeapon == BASE_ITEM_TOWERSHIELD)   iMax = iMax + 850;
    else if(iWeapon == BASE_ITEM_TWOBLADEDSWORD)iMax = iMax + 2300;
    else if(iWeapon == BASE_ITEM_WARHAMMER)     iMax = iMax + 1900;
    else if(iWeapon == BASE_ITEM_WHIP)          iMax = iMax + 1500;
    else if(iWeapon == BASE_ITEM_INVALID)       iMax = 100000;
    else iMax = 500;

    return iMax;
}


void DoSetItemMax(object oWeapon, object oPC)
{
    int iMax = 1;
    int iISPlotItem = GetPlotFlag(oWeapon);
    int iTypeBonus = DoGetBaseItemBonus(oWeapon);
    int iMagicBonus = DoGetMagicItemBonus(oWeapon);
    int RaceBonus  =  GetRaceMadebonus(oWeapon);
    if(iISPlotItem == TRUE)    iMax = iMax + 2000000;

    int iTotal = iMax + iMagicBonus + iTypeBonus + RaceBonus;

    if(DEBUGME == TRUE)
    {
        SendMessageToPC(oPC, "SETTING NEW ITEM HP ");
        SendMessageToPC(oPC, "=======================");
        SendMessageToPC(oPC, "BASE BONUS  = " + IntToString(iTypeBonus));
        SendMessageToPC(oPC, "MAGIC BONUS = " + IntToString(iMagicBonus));
        SendMessageToPC(oPC, "TOTAL BONUS = " + IntToString(iTotal));
        SendMessageToPC(oPC, "=======================");
    }

    SetLocalInt(oWeapon, "MAX_HP", iTotal);
    SetLocalInt(oWeapon, "CUR_HP", iTotal);
    SetLocalInt(oWeapon, "ITEM_SET", TRUE);
}

void DoWeaponBreakageAdvance(object oAttacker, object oWeapon, int iCurrent)
{
    int iExceptional = d100();

    if(iCurrent <= 0)
    {
        SendMessageToPC(oAttacker, "<cþ>*************************</c>");
        SendMessageToPC(oAttacker, "<cþ>*** Tu arma se ha roto !! : </c>" + GetName(oWeapon) + "<cþ> ***</c>");
        SendMessageToPC(oAttacker, "<cþ>*************************</c>");
        DestroyObject(oWeapon);
    }
    else
    {
        if(iExceptional <= 3)
        {
            SendMessageToPC(oAttacker, "** Se ha mellado un poco : " + GetName(oWeapon) + "**");
            int iDamRoll = d20(2);
            int iNewTotal = iCurrent - iDamRoll;
            SendMessageToPC(oAttacker, "tu arma se ha estropeado por " + IntToString(iDamRoll) + " de golpe.");
            SetLocalInt(oWeapon, "CUR_HP", iNewTotal);
        }
        else
        {
            int iNewTotal = iCurrent - 1;
            SetLocalInt(oWeapon, "CUR_HP", iNewTotal);
        }

        if(DEBUGME == TRUE)
        {
            int iCURitemHP = GetLocalInt(oWeapon, "CUR_HP");
            SendMessageToPC(oAttacker, "SETTING NEW HP ");
            SendMessageToPC(oAttacker, "=======================");
            SendMessageToPC(oAttacker, "NEW TOTAL = " + IntToString(iCURitemHP));
            SendMessageToPC(oAttacker, "=======================");
        }
    }
}


void DoWeaponBreakage(object oAttacker, object oTarget, object oWeapon)
{
    int iIsValid = GetIsWeaponAmmoReturnable(oWeapon);
    int iMAXitemHP = GetLocalInt(oWeapon, "MAX_HP");
    int iISitemSET = GetLocalInt(oWeapon, "ITEM_SET");

    if(DEBUGME == TRUE)
    {
        SendMessageToPC(oAttacker, "HP SETTINGS");
        SendMessageToPC(oAttacker, "=======================");
        SendMessageToPC(oAttacker, "MAX TOTAL  = " + IntToString(iMAXitemHP));
        SendMessageToPC(oAttacker, "ITEM SETUP = " + IntToString(iISitemSET));
        SendMessageToPC(oAttacker, "=======================");
    }

    if(iIsValid == TRUE)
    {
        if(iISitemSET == FALSE)
        {
            DoSetItemMax(oWeapon, oAttacker);

            if(DEBUGME == TRUE)
            {
                int iCURitemHP = GetLocalInt(oWeapon, "CUR_HP");
                SendMessageToPC(oAttacker, "=======================");
                SendMessageToPC(oAttacker, "MAX TOTAL = " + IntToString(iMAXitemHP));
                SendMessageToPC(oAttacker, "CUR TOTAL = " + IntToString(iCURitemHP));
                SendMessageToPC(oAttacker, "=======================");
            }
        }
        else
        {
            int iCURitemHP = GetLocalInt(oWeapon, "CUR_HP");
            DoCheckMissleReturn(oAttacker, oTarget, oWeapon);
            DoWeaponBreakageAdvance(oAttacker, oWeapon, iCURitemHP);
        }
    }
    else
    {
        if(iISitemSET == FALSE)
        {
            DoSetItemMax(oWeapon, oAttacker);
        }
        else
        {
            int iCURitemHP = GetLocalInt(oWeapon, "CUR_HP");
            DoWeaponBreakageAdvance(oAttacker, oWeapon, iCURitemHP);

            if(DEBUGME == TRUE)
            {
                int iCURitemHP = GetLocalInt(oWeapon, "CUR_HP");
                SendMessageToPC(oAttacker, "ITEM = " + GetName(oWeapon));
                SendMessageToPC(oAttacker, "=======================");
                SendMessageToPC(oAttacker, "CUR TOTAL = " + IntToString(iCURitemHP));
                SendMessageToPC(oAttacker, "=======================");
            }
        }
    }
}

void DoArmorItemBreakage(object oAttacker, object oTarget)
{
    int iBeenDamaged = GetLocalInt(oAttacker, "LAST_HP");
    int iCurrent = GetCurrentHitPoints(oAttacker);

    if(iCurrent < iBeenDamaged)
    {
        int nSlot = Random(17);

        object oItem=GetItemInSlot(nSlot, oAttacker);

        if (GetIsObjectValid(oItem))
        {
            int iMAXitemHP = GetLocalInt(oItem, "MAX_HP");
            int iISitemSET = GetLocalInt(oItem, "ITEM_SET");

            if(iISitemSET == FALSE)
            {
                DoSetItemMax(oItem, oAttacker);

                if(DEBUGME == TRUE)
                {
                    int iCURitemHP = GetLocalInt(oItem, "CUR_HP");
                    SendMessageToPC(oAttacker, "ITEM = " + GetName(oItem));
                    SendMessageToPC(oAttacker, "=======================");
                    SendMessageToPC(oAttacker, "CUR TOTAL = " + IntToString(iCURitemHP));
                    SendMessageToPC(oAttacker, "=======================");
                }
            }
            else
            {
                int iCURitemHP = GetLocalInt(oItem, "CUR_HP");
                DoWeaponBreakageAdvance(oAttacker, oItem, iCURitemHP);

                if(DEBUGME == TRUE)
                {
                    int iCURitemHP = GetLocalInt(oItem, "CUR_HP");
                    SendMessageToPC(oAttacker, "ITEM = " + GetName(oItem));
                    SendMessageToPC(oAttacker, "=======================");
                    SendMessageToPC(oAttacker, "MAX TOTAL = " + IntToString(iMAXitemHP));
                    SendMessageToPC(oAttacker, "CUR TOTAL = " + IntToString(iCURitemHP));
                    SendMessageToPC(oAttacker, "=======================");
                }
            }
        }
    }

    // SET PC's HitPoints to CurrentLevel to check at next EOR
    SetLocalInt(oAttacker, "LAST_HP", iCurrent);
}
