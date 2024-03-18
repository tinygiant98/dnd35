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
  int max = Random(8) + 1;
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

  float fRandX = IntToFloat(Random(iAreaX * 10)) + (IntToFloat(Random(90)) / 100) + 0.05f;
  float fRandY = IntToFloat(Random(iAreaY * 10)) + (IntToFloat(Random(90)) / 100) + 0.05f;

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
    switch(Random(16) + 1) {
    case 1: group = "scaled_forest"; break;
    case 2: group = "scaled_kobold"; break;
    case 3: group = "scaled_tree"; break;
    case 4: group = "scaled_elf"; break;
    case 5: group = "scaled_orc"; break;
    case 6: group = "scaled_bear"; break;
    case 7: group = "scaled_kobold"; break;
    case 8: group = "scaled_troll"; break;
    case 9: group = "forest"; break;
    case 10: group = "troll"; break;
    case 11: group = "rabbit"; break;
    case 12: group = "frog"; break;
    case 13: group = "scaled_wolf"; break;
    case 14: group = "wolf"; break;
    case 15: group = "scaled_goblin"; break;
    case 16: group = "goblin"; break;
    }
    return group;
  }

  if ((FindSubString(aname, "city") != -1) ||
      (FindSubString(aname, "keep") != -1) ||
      (FindSubString(aname, "castle") != -1) ||
      (FindSubString(aname, "town") != -1))
    {
      switch(Random(2) + 1) {
      case 1: group = "scaled_commoner";break;
      case 2: group = "commoner";break;
      }
      return group;
    }    

  if ((FindSubString(aname, "road") != -1) ||
      (FindSubString(aname, "path") != -1) ||
      (FindSubString(aname, "grounds") != -1) ||
      (FindSubString(aname, "vale") != -1) ||
      (FindSubString(aname, "way") != -1))
    {
      switch(Random(7) + 1)
        {
        case 1: group = "scaled_mercs"; break;
        case 2: group = "scaled_elfs"; break;
        case 3: group = "scaled_wolf"; break;
        case 4: group = "scaled_goblin"; break;
        case 5: group = "scaled_outdoor"; break;
        case 6: group = "goblin"; break;
        case 7: group = "cr_militia"; break;
        }
      return group;
    } 

  if ( (FindSubString(aname, "peak") != -1) ||
       (FindSubString(aname, "grounds") != -1) ||
       (FindSubString(aname, "mountain") != -1) ||
       (FindSubString(aname, "underdark") != -1) ||
       (FindSubString(aname, "dusty") != -1) ||
       (FindSubString(aname, "cavern") != -1) ||
       (FindSubString(aname, "valley") != -1))
    {
      switch(Random(9) + 1)
        {
        case 1: group = "scaled_ogre"; break;
        case 2: group = "scaled_drow"; break;
        case 3: group = "scaled_rxvar"; break;
        case 4: group = "scaled_giant"; break;
        case 5: group = "scaled_merce"; break;
        case 6: group = "scaled_kobold"; break;
        case 7: group = "kobold"; break;
        case 8: group = "scaled_goblin"; break;
        case 9: group = "goblin"; break;
        default: group = "goblin"; break;
        }
      return group;
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
    switch(Random(7) + 1) {
    case 1: group = "scaled_ghost"; break;
    case 2: group = "scaled_vampire"; break;
    case 3: group = "scaled_skeleton"; break;
    case 4: group = "scaled_outdoor"; break;
    case 5: group = "scaled_vampires"; break;
    case 6: group = "scaled_nomuertos"; break;
    case 7: group = "scaled_dead"; break;
    case 8: group = "dead"; break;
    }
    return group;
  }

  // Then just check tiles

  // If the area was created using the Rural Winter or Frozen Wastes tilesets...
  if((sTilesetResref == TILESET_RESREF_RURAL_WINTER) ||
     (sTilesetResref == TILESET_RESREF_FROZEN_WASTES)
     ) {
    switch(Random(5) + 1) {
    case 1: group = "scaled_forest"; break;
    case 2: group = "scaled_outdoor"; break;
    case 3: group = "scaled_plants"; break;
    case 4: group = "scaled_elfs"; break;
    case 5: group = "scaled_goblins_chantas"; break;
    }
  }

  if((sTilesetResref == TILESET_RESREF_RUINS)){
    switch(Random(6) + 1) {
    case 1: group = "scaled_crypt"; break;
    case 2: group = "scaled_outdoor"; break;
    case 3: group = "scaled_trolls"; break;
    case 4: group = "scaled_giants"; break;
    case 5: group = "scaled_mercs"; break;
    case 6: group = "scaled_blood"; break;
    case 7: group = "scaled_vampires"; break;
    }
  }

  if((sTilesetResref == TILESET_RESREF_CITY_INTERIOR_2) ||
     (sTilesetResref == TILESET_RESREF_CASTLE_INTERIOR_2) ||
     (sTilesetResref == TILESET_RESREF_FORT_INTERIOR) ) {
    group = "commoner";
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
  while (GetIsObjectValid(oArea))
    {
         
      int i;
      int how_many = fix_chances(Random(10) + 1, 5 ) ;
      for (i = 0; i < how_many; i++)
        {
          chance = fix_chances(Random(100), 20);
          loot_table = Random(4);
          locl = GetRandomLocationfromArea(oArea);
          NESS_wpname = GenerateNESSWaypointDataforGroup(chance, loot_table);
          oWP = CreateNamedWaypoint(locl, GenerateNESSWaypointDataforGroup(chance, loot_table));
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
