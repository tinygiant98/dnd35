// HCR v3.2.0 - Re-Added MATERCOMP code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  NW_S2_TurnDead
//::////////////////////////////////////////////////////////////////////////////
/*
   Checks domain powers and class to determine the proper turning abilities of
  the casting character.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov  2, 2001
//:: Updated On: Mar  5, 2003 - For Blackguards.
//:: Updated On: Jul 15, 2003 - Georg Zoeller
//:: Updated On: Jul 24, 2003 - For Planar Turning to include turn resistance hd.
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  if (GetLocalInt(GetModule(), "MATERCOMP") == TRUE)
    {
     object oComp = GetItemPossessedBy(OBJECT_SELF, "HolySymbol");
     string sMsg1 = "You must possess a holy symbol to turn undead.";
     string sMsg2 = "You must equip the holy symbol to turn undead.";
     string sMsg3 = " does not have a holy symbol to turn the undead with.";
     int bHasEquip = FALSE;

     // Determine if using the Hench System or generic henchman.
     object oMaster = GetLocalObject(OBJECT_SELF, "HS_REAL_MASTER");
     if (!GetIsObjectValid(oMaster))
       { oMaster = GetMaster(); }

     if (GetIsPC(OBJECT_SELF) &&
        !GetIsDM(OBJECT_SELF) &&
        !GetIsDMPossessed(OBJECT_SELF))
       {
        // It is a PC casting this spell.
        if (!GetIsObjectValid(oComp))
          {
           SendMessageToPC(OBJECT_SELF, sMsg1);
           ClearAllActions();
           return;
          }
        else
          {
           int i;
           for (i = 0; i <= NUM_INVENTORY_SLOTS; i++)
             {
              if (GetTag(GetItemInSlot(i)) == "HolySymbol")
                { bHasEquip = TRUE; }
             }

           if (bHasEquip == FALSE)
             {
              SendMessageToPC(OBJECT_SELF, sMsg2);
              ClearAllActions();
              return;
             }
          }
       }
     else if (GetIsObjectValid(oMaster) &&
             !GetIsPC(OBJECT_SELF) &&
              GetIsPC(oMaster) &&
             !GetIsDM(oMaster) &&
             !GetIsDMPossessed(oMaster))
       {
        // It is a henchman casting this spell.
        if (!GetIsObjectValid(oComp))
          {
           SendMessageToPC(oMaster, GetName(OBJECT_SELF) + sMsg3);
           ClearAllActions();
           return;
          }
       }
    }

  int nClericLevel = GetLevelByClass(CLASS_TYPE_CLERIC);
  int nPaladinLevel = GetLevelByClass(CLASS_TYPE_PALADIN);
  int nBlackguardlevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD);
  int nTotalLevel =  GetHitDice(OBJECT_SELF);
  int nTurnLevel = nClericLevel;
  int nClassLevel = nClericLevel;

  // GZ: Since paladin levels stack when turning, blackguard levels should stack
  // as well, but not with the paladin levels (thus else if).
  if ((nBlackguardlevel - 2) > 0 && (nBlackguardlevel > nPaladinLevel))
    {
     nClassLevel += (nBlackguardlevel - 2);
     nTurnLevel  += (nBlackguardlevel - 2);
    }
  else if ((nPaladinLevel - 2) > 0)
    {
     nClassLevel += (nPaladinLevel - 2);
     nTurnLevel  += (nPaladinLevel - 2);
    }

  // Flags for bonus turning types.
  int nElemental  = GetHasFeat(FEAT_AIR_DOMAIN_POWER) +
                    GetHasFeat(FEAT_EARTH_DOMAIN_POWER) +
                    GetHasFeat(FEAT_FIRE_DOMAIN_POWER) +
                    GetHasFeat(FEAT_WATER_DOMAIN_POWER);
  int nVermin     = GetHasFeat(FEAT_PLANT_DOMAIN_POWER);// + GetHasFeat(FEAT_ANIMAL_COMPANION);
  int nConstructs = GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER);
  int nGoodOrEvilDomain = GetHasFeat(FEAT_GOOD_DOMAIN_POWER) +
                          GetHasFeat(FEAT_EVIL_DOMAIN_POWER);
  int nPlanar = GetHasFeat(854);

  // Flag for improved turning ability.
  int nSun = GetHasFeat(FEAT_SUN_DOMAIN_POWER);

  // Make a turning check roll, modify if have the Sun Domain.
  int nChrMod = GetAbilityModifier(ABILITY_CHARISMA);
  int nTurnCheck = (d20() + nChrMod);// The roll to apply to the max HD of undead that can be turned --> nTurnLevel.
  int nTurnHD = (d6(2) + nChrMod + nClassLevel);// The number of HD of undead that can be turned.
  if (nSun == TRUE)
    {
     nTurnCheck += d4();
     nTurnHD += d6();
    }

  // Determine the maximum HD of the undead that can be turned.
  if (nTurnCheck <= 0)
    { nTurnLevel -= 4; }
  else if (nTurnCheck >= 1 && nTurnCheck <= 3)
    { nTurnLevel -= 3; }
  else if (nTurnCheck >= 4 && nTurnCheck <= 6)
    { nTurnLevel -= 2; }
  else if (nTurnCheck >= 7 && nTurnCheck <= 9)
    { nTurnLevel -= 1; }
  else if (nTurnCheck >= 10 && nTurnCheck <= 12)
    {
     // Stays the same.
    }
  else if (nTurnCheck >= 13 && nTurnCheck <= 15)
    { nTurnLevel += 1; }
  else if (nTurnCheck >= 16 && nTurnCheck <= 18)
    { nTurnLevel += 2; }
  else if (nTurnCheck >= 19 && nTurnCheck <= 21)
    { nTurnLevel += 3; }
  else if (nTurnCheck >= 22)
    { nTurnLevel += 4; }

  // Gets all creatures in a 20m radius around the caster and turns them or not.
  // If the creatures HD are 1/2 or less of the nClassLevel then the creature is
  // destroyed.
  int nCnt = 1;
  int nHD, nRacial, nHDCount, bValid, nDamage;
  nHDCount = 0;
  effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eVisTurn = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
  effect eDamage;
  effect eTurned = EffectTurned();
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  effect eLink = EffectLinkEffects(eVisTurn, eTurned);
  eLink = EffectLinkEffects(eLink, eDur);
  effect eDeath = SupernaturalEffect(EffectDeath(TRUE));
  effect eImpactVis = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpactVis, GetLocation(OBJECT_SELF));

  // Get nearest enemy within 20m. (60ft)
  // Why are you using GetNearest instead of GetFirstObjectInShape?
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
  while (GetIsObjectValid(oTarget) && nHDCount < nTurnHD && GetDistanceToObject(oTarget) <= 20.0)
    {
     if (!GetIsFriend(oTarget))
       {
        nRacial = GetRacialType(oTarget);
        if (nRacial == RACIAL_TYPE_OUTSIDER )
          {
           // Planar turning decreases spell resistance against turning by 1/2.
           if (nPlanar)
             { nHD = GetHitDice(oTarget) + (GetSpellResistance(oTarget)/2) + GetTurnResistanceHD(oTarget); }
           else
             { nHD = GetHitDice(oTarget) + (GetSpellResistance(oTarget) + GetTurnResistanceHD(oTarget)); }
          }
        else// (full turn resistance)
          { nHD = GetHitDice(oTarget) + GetTurnResistanceHD(oTarget); }

        if (nHD <= nTurnLevel && nHD <= (nTurnHD - nHDCount))
          {
           // Check the various domain turning types.
           if (nRacial == RACIAL_TYPE_UNDEAD)
             { bValid = TRUE; }
           else if (nRacial == RACIAL_TYPE_VERMIN && nVermin > 0)
             { bValid = TRUE; }
           else if (nRacial == RACIAL_TYPE_ELEMENTAL && nElemental > 0)
             { bValid = TRUE; }
           else if (nRacial == RACIAL_TYPE_CONSTRUCT && nConstructs > 0)
             {
              SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
              nDamage = d3(nTurnLevel);
              eDamage = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
              nHDCount += nHD;
             }
           else if (nRacial == RACIAL_TYPE_OUTSIDER && (nGoodOrEvilDomain+nPlanar > 0) )
             { bValid = TRUE; }
           else if (GetIsObjectValid(GetItemPossessedBy(oTarget, "x2_gauntletlich")) == TRUE)
             {
              // * If wearing gauntlets of the lich, then target can be turned.
              if (GetTag(GetItemInSlot(INVENTORY_SLOT_ARMS)) == "x2_gauntletlich")
                { bValid = TRUE; }
             }

           // Apply results of the turn.
           if (bValid == TRUE)
             {
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

              if (nPlanar > 0 && nRacial == RACIAL_TYPE_OUTSIDER)
                {
                 effect ePlane = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, ePlane, oTarget);
                }

              if ((nClassLevel/2) >= nHD)
                {
                 if (nPlanar > 0 && nRacial == RACIAL_TYPE_OUTSIDER)
                   {
                    effect ePlane2 = EffectVisualEffect(VFX_IMP_UNSUMMON);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePlane2, oTarget);
                   }

                 //effect ePlane2 = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);

                 // Fire cast spell at event for the specified target.
                 SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));

                 // Destroy the target.
                 DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                }
              else
                {
                 // Turn the target.
                 // Fire cast spell at event for the specified target.
                 SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_TURN_UNDEAD));
                 AssignCommand(oTarget, ActionMoveAwayFromObject(OBJECT_SELF, TRUE));
                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nClassLevel + 5));
                }
              nHDCount += nHD;
             }
          }
        bValid = FALSE;
       }
     nCnt++;
     oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nCnt, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    }
}
//::////////////////////////////////////////////////////////////////////////////
