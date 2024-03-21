//
// Spawn Groups
//
// Player Character Level	Challenge Rating Range for Encounters
/* 1-3	                             CR 1/4 - CR 3 */
/* 4-6	                             CR 1/2 - CR 6 */
/* 7-9	                             CR 1 - CR 8 */
/* 10-12	                           CR 2 - CR 10 */
/* 13-15	                           CR 3 - CR 12 */
/* 16-18	                           CR 4 - CR 14 */
/* 19-20	                           CR 5 - CR 16 */
/* 21-23	                           CR 6 - CR 18 */
/* 24-26	                           CR 7 - CR 20 */
/* 27-29	                           CR 8 - CR 22 */
/* 30-32	                           CR 9 - CR 24 */
/* 33-35	                           CR 10 - CR 26 */
/* 36-38	                           CR 11 - CR 28 */
/* 39-41	                           CR 12 - CR 30 */
/* 42-44	                           CR 13 - CR 32 */
/* 45-47	                           CR 14 - CR 34 */
/* 48-50	                           CR 15 - CR 36 */
/* 51-53	                           CR 16 - CR 38 */
/* 54-56	                          .CR 17 - CR 40 */
/* 57-59	                           CR 18 - CR 42 */
/* 60	                             CR 19 - CR 44 */

string GetCreatureFromEncounterTable(int pclvl = 1, string environment = "FOREST")
{
  int min, max = 0;
  switch (pclvl) {
  case 1:
  case 2:
  case 3:
    min = 0;
    max = 3;
    break;
  case 4:
  case 5:
  case 6:
    min = 0;
    max = 6;
    break;
  case 7:
  case 8:
  case 9:
    min = 1;
    max = 8;
    break;
  case 10:
  case 11:
  case 12:
    min = 2;
    max = 10;
    break;

  case 13:
  case 14:
  case 15:
    min = 3;
    max = 12;
    break;
  case 16:
  case 17:
  case 18:
    min = 4;
    max = 14;
    break;

  case 19:
  case 20:
    min = 5;
    max = 16;
    break;
  case 21:
  case 22:
  case 23:
    min = 6;
    max = 18;
    break;
  default:
    min = d10(1);
    max = d20(1) + d20(1);
    break;
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
  string sRetTemplate;
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
  return sRetTemplate;
}
