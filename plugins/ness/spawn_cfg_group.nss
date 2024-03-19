//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
//
int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
string GetCreatureFromEncounterTable(int nMinimumCR = 1, string environment = "FOREST");
//
//

string GetCreatureFromEncounterTable(int nMinimumCR = 1, string environment = "FOREST")
{
  int min, max = 0;
  if (nMinimumCR <= 5) {
    min = 0;
    max = 5;
  } else {
    min = nMinimumCR - 5;
    max = nMinimumCR + 5;
  }
  string s = "SELECT TemplateResRef FROM Encounters " +
    " JOIN Creatures ON Encounters.CreatureID = Creatures.id and Encounters.LVL >= @min and Encounters.LVL <= @max " +
    " JOIN Environments ON Encounters.EnvironmentID = Environments.EnvironmentID " +
    " WHERE Environments.Name = @environment ORDER BY RANDOM() LIMIT 1;";

  sqlquery q = SqlPrepareQueryCampaign("dnd35", s);
  SqlBindInt(q, "@min", min);
  SqlBindInt(q, "@max", max);
  SqlBindString(q, "@environment", environment);
  return SqlStep(q) ? SqlGetString(q, 0) : "";
}

string GetTemplateByCR(int nCR, string sGroupType)
{
  string sRetTemplate;
  sRetTemplate = GetCreatureFromEncounterTable(nCR, sGroupType);
  return sRetTemplate;
}

// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
  float fCR, fEquivSq, fTemp;

  if (fEquiv == 0.0)
    {
      return 0.0;
    }

  fEquivSq = fEquiv * fEquiv;
  fTemp = log(fEquivSq);
  fTemp /= log(2.0);
  fCR = fEncounterLevel + fTemp;

  return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
  if (fCR > fEncounterLevel || fCR < 1.0)
    {
      return 1.;
    }

  float fEquiv, fExponent, fDenom;

  fExponent = fEncounterLevel - fCR;
  fExponent *= 0.5;
  fDenom = pow(2.0, fExponent);
  fEquiv =  1.0 / fDenom;

  return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
  // Initialize
  string sRetTemplate;

  // Initialize Values
  int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
  int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
  int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
  int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
  int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

  //
  // Only Make Modifications Between These Lines
  // -------------------------------------------

  if (GetStringLeft(sTemplate, 7) == "scaled_")
    {
      float fEncounterLevel;
      int nScaledInProgress = GetLocalInt(oSpawn, "ScaledInProgress");
      string sGroupType = GetStringRight(sTemplate,
                                         GetStringLength(sTemplate) - 7);

      // First Time in for this encounter?
      if (! nScaledInProgress)
        {

          // First time in - find the party level
          int nTotalPCs = 0;
          int nTotalPCLevel = 0;

          object oArea = GetArea(OBJECT_SELF);

          object oPC = GetFirstObjectInArea(oArea);
          while (oPC != OBJECT_INVALID)
            {
              if (GetIsPC(oPC) == TRUE)
                {
                  nTotalPCs++;
                  nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
                }
              oPC = GetNextObjectInArea(oArea);
            }
          if (nTotalPCs == 0)
            {
              fEncounterLevel = 0.0;
            }
          else
            {
              fEncounterLevel = IntToFloat(nTotalPCLevel) / IntToFloat(nTotalPCs);
            }

          // Save this for subsequent calls
          SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);

          // We're done when the CRs chosen add up to the
          // desired encounter level
          SetLocalInt(oSpawn, "ScaledCallCount", 0);
          SetLocalInt(oSpawn, "ScaledInProgress", TRUE);
        }


      fEncounterLevel = GetLocalFloat(oSpawn, "ScaledEncounterLevel");
      int nScaledCallCount = GetLocalInt(oSpawn, "ScaledCallCount");

      // For simplicity, I'm not supporting creatures with CR < 1.0)
      if (fEncounterLevel < 1.0)
        {
          // We're done... No creatures have CR low enough to add to this encounter
          sRetTemplate = "";
        }

      else
        {
          // randomly choose a CR at or below the remaining (uncovered) encounter
          // level
          int nCR = Random(FloatToInt(fEncounterLevel)) + 1;

          // cap to the largest CR we currently support in GetTemplateByCR
          //if (nCR > 3)
          // {
          //  nCR = 3;
          // }

          sRetTemplate = GetTemplateByCR(nCR, sGroupType);

          // Convert CR to Encounter Level equivalent so it can be correctly
          // subtracted.  This does the real scaling work
          float fELEquiv = ConvertCRToELEquiv(IntToFloat(nCR), fEncounterLevel);
          float fElRemaining = 1.0 - fELEquiv;

          fEncounterLevel = ConvertELEquivToCR(fElRemaining, fEncounterLevel);
          SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);
        }

      nScaledCallCount++;
      SetLocalInt(oSpawn, "ScaledCallCount", nScaledCallCount);

      nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

      if (nScaledCallCount >= nSpawnNumber)
        {
          // reset...
          SetLocalInt(oSpawn, "ScaledInProgress", FALSE);
        }
    } else {
    // Try to guess based on Template name what to spawn.
    int nTotalPCs;
    int nTotalPCLevel;
    int nAveragePCLevel;
    object oArea = GetArea(OBJECT_SELF);

    // Cycle through PCs in Area
    object oPC = GetFirstObjectInArea(oArea);
    while (oPC != OBJECT_INVALID)
      {
        if (GetIsPC(oPC) == TRUE)
          {
            nTotalPCs++;
            nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
          }
        oPC = GetNextObjectInArea(oArea);
      }
    if (nTotalPCs == 0)
      {
        nAveragePCLevel = 0;
      }
    else
      {
        nAveragePCLevel = nTotalPCLevel / nTotalPCs;
      }
    sRetTemplate = GetCreatureFromEncounterTable(nAveragePCLevel, sTemplate);
  }

  return sRetTemplate;
}
