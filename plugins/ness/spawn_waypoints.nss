// The purpose of this is to create all required encounter waypoints in all areas
// As I'm just using NESS groups this seems simpler as CR is calculated at spawn
// decisioning so they should be somewhat balanced.
// Maybe a good idea is to create groups by type of terrain and create wps based on that.


string paddzero(int n) {
  string val = IntToString(n);
  if (n < 10)
    val = "0"  + val;
  return val;
}
// fixes chances of encounters by setting a minimum
int fix_chances(int n, int min_chance) 
{
  if (n < min_chance)
    return min_chance;
  else
    return n;
}


// Will create a NESS tag using arguments.
string GenerateNESSWaypointDataforGroup(int chance, int loot_table) 
{
  string lt = paddzero(loot_table);
  string rs = paddzero(chance);
  int max = Random(5) + 1;

  int luck = Random(100) + 1;
  if (luck < 10) {
    max = Random(10)  + 1;
  }

  string min = paddzero(Random(max) + 1);
  string smax = paddzero(max);
  // SN05M03 = 5 spawns but spawn between 3 and 5  
  // SA05M03 spawn between 3 and 5 all at once
  // The parameter on the SD flag is a delay in minutes from the time the creature would 
  // normally have been spawned.
  // The optional Mm subflag will set a minimum delay in minutes, in which case the n
  //parameter sets a maximum delay before respawning and the respawn will occur randomly
  //between minimum m minutes and maximum n minutes
  string wpname = "SP_SN" + smax + "_SA"+ smax +"M"+ min +"_SD10M05_PC03_SG_" + "LT" + lt + "_RS" + rs + "_RW";
  return wpname;
}

location GetRandomLocationfromArea(object oArea) {
  int iAreaX = GetAreaSize(AREA_WIDTH, oArea);
  int iAreaY = GetAreaSize(AREA_HEIGHT, oArea);
  float fAngle = IntToFloat(Random(360));
  location lLoc;

  float fRandX = IntToFloat(Random(iAreaX * 10)) + (IntToFloat(Random(90)) / 100) + 0.15f;
  float fRandY = IntToFloat(Random(iAreaY * 10)) + (IntToFloat(Random(90)) / 100) + 0.15f;

  lLoc = Location(oArea, Vector(fRandX, fRandY, 0.0f), fAngle);

  return lLoc;
}
// Created by TinyGiant 03/14/2024
// Thanks a lot!!
object CreateNamedWaypoint(location l, string sName)
{
  json jWP = TemplateToJson("nw_waypoint001", RESTYPE_UTW);
  json jNames = JsonPointer(jWP, "/LocalizedName");
  json jValues = JsonPointer(jNames, "/value");
    
  int n; for (n; n <= PLAYER_LANGUAGE_POLISH; n++)
           jValues = JsonObjectSet(jValues, IntToString(n), JsonString(sName));
  jValues = JsonObjectDel(jValues, "id");
  return JsonToObject(JsonObjectSet(jWP, "LocalizedName", JsonObjectSet(jNames, "value", jValues)), l);
}

// this will match a group using tileset
// https://nwnlexicon.com/index.php/Tileset_resref
string ChooseGroupbyTile(object oArea) 
{
  // Determine the tileset used to create the area being entered.
  // current groups : rxvars, ogres, planars, drows, elfs, shapechangers, 
  string sTilesetResref = GetTilesetResRef(oArea);
  string aname = GetStringLowerCase(GetName(oArea));
  string group = "scaled_commoners";

  // First try to deduce what to spawn by looking at the name of the area
  if ((FindSubString(aname, "forest") != -1) ||
      (FindSubString(aname, "marsh") != -1) ) {
    return "FOREST";
  }

  if ((FindSubString(aname, "city") != -1) ||
      (FindSubString(aname, "keep") != -1) ||
      (FindSubString(aname, "castle") != -1) ||
      (FindSubString(aname, "town") != -1))
    {
      return "CITY_INTERIOR";
    }

  if ((FindSubString(aname, "road") != -1) ||
      (FindSubString(aname, "path") != -1) ||
      (FindSubString(aname, "grounds") != -1) ||
      (FindSubString(aname, "vale") != -1) ||
      (FindSubString(aname, "way") != -1))
    {
      // This should be road
      return "CITY_EXTERIOR";
    }

  if ( (FindSubString(aname, "peak") != -1) ||
       (FindSubString(aname, "grounds") != -1) ||
       (FindSubString(aname, "mountain") != -1) ||
       (FindSubString(aname, "underdark") != -1) ||
       (FindSubString(aname, "dusty") != -1) ||
       (FindSubString(aname, "cavern") != -1) ||
       (FindSubString(aname, "valley") != -1))
    {
      return "CAVES";
    }    

  if ((FindSubString(aname, "crypt") != -1) ||
      (FindSubString(aname, "tomb") != -1) ||
      (FindSubString(aname, "dark") != -1)  ||
      (FindSubString(aname, "cemetery") != -1) ||
      (FindSubString(aname, "tumba") != -1) ||
      (FindSubString(aname, "blood") != -1) ||
      (FindSubString(aname, "death") != -1) ||
      (FindSubString(aname, "chapel") != -1)
      ) {
    return "CRYPT";
  }

  // Then just check tiles
  if((sTilesetResref == TILESET_RESREF_RURAL_WINTER) ||
     (sTilesetResref == TILESET_RESREF_FROZEN_WASTES)
     ) {
    return "FOREST";
  }

  if((sTilesetResref == TILESET_RESREF_RUINS)){
    return "RUINS";
  }

  if((sTilesetResref == TILESET_RESREF_CITY_INTERIOR_2) ||
     (sTilesetResref == TILESET_RESREF_CASTLE_INTERIOR_2) ||
     (sTilesetResref == TILESET_RESREF_FORT_INTERIOR) ) {
    return  "CITY_INTERIOR";
  }

  return group;
}


void CreateNESSWaypoints()
{
  object oArea = GetFirstArea();
  object oWP ;
  string NESS_wpname;
  location locl ;
  int chance;
  int loot_table;
  string group_name;
  int i;
  int AreaX;
  int how_many;
  while (GetIsObjectValid(oArea))
    {
      iAreaX = GetAreaSize(AREA_WIDTH, oArea);
      if (iAreaX < 10) {
        how_many = d2(1);
      } else if (iAreaX => 10 and iAreaX <=  16 )  {
        how_many = d2(1) + d2(1);
      } else {
        how_many = d6(1);
      }
      for (i = 0; i < how_many; i++)
        {
          chance = fix_chances(Random(100), 20);
          loot_table = Random(4);
          locl = GetRandomLocationfromArea(oArea);
          NESS_wpname = GenerateNESSWaypointDataforGroup(chance, loot_table);
          oWP = CreateNamedWaypoint(locl, NESS_wpname);
          group_name = ChooseGroupbyTile(oArea);
          if (GetIsObjectValid(oWP))
            {
              Notice("Waypoint created at: " + GetName(oArea) + " Name: "
                     + NESS_wpname + " tag:" + group_name);
              SetTag(oWP,group_name);
              Debug(ObjectToString(oWP));
                
            } else {
            CriticalError("Waypoint could not be created at : " + GetName(oArea));
            CriticalError(ObjectToString(oWP));
          }
        }       
      oArea = GetNextArea();
    }
}
