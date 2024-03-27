// The purpose of this is to create all required encounter waypoints in all areas
// As I'm just using NESS groups this seems simpler as CR is calculated at spawn
// decisioning so they should be somewhat balanced.
// Maybe a good idea is to create groups by type of terrain and create wps based on that.

const string NESS_GROUP = "SG";
const string NESS_PLACEABLE = "PL";

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
string GenerateNESSWaypointDataforGroup(int chance, int loot_table, string type)
{
  string wpname ;
  string lt = paddzero(loot_table);
  string rs = paddzero(chance);
  string smin, smax;

  int max = d4(2);
  int luck = d100(1);

  if (luck < 10) {
    lt =  paddzero(d4(1));
  } else if (luck > 70) {
    lt = paddzero(Random(3) + 1);
  } else {
    lt = paddzero(Random(2));
  }

  smax = paddzero(max);
  smin = paddzero(Random(max/2) + 1);

  if (type != NESS_PLACEABLE) {
    wpname = "SP_SN" + smax + "_SA"+ smax +"M"+ smin +"_SD10M05_PC03_SG_" + "LT" + lt + "_RS" + rs + "_RW";
  } else {
    wpname = "SP_PL";
  }
  return wpname;
}

location GetRandomLocationfromArea(object oArea) {
  int iAreaX = GetAreaSize(AREA_WIDTH, oArea);
  int iAreaY = GetAreaSize(AREA_HEIGHT, oArea);
  float fAngle = IntToFloat(Random(360));
  location lLoc;

  float fRandX = IntToFloat(Random(iAreaX * 10)) + (IntToFloat(Random(90)) / 100) + 0.55f;
  float fRandY = IntToFloat(Random(iAreaY * 10)) + (IntToFloat(Random(90)) / 100) + 0.55f;

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
/*
  1|CAVES
  2|FOREST
  3|RUINS
  4|HAUNTED
  5|CITY_EXTERIOR
  6|CITY_INTERIOR
  7|DUNGEON
  8|CRYPT
  9|DESERT
  10|FROZEN
  11|UNDERDARK
  12|SEWER
*/
string Area2Environment(object oArea)
{
  string aname = GetStringLowerCase(GetName(oArea));
  string sTilesetResref = GetTilesetResRef(oArea);

 if ((FindSubString(aname, "evenglari") != -1)) {
    return "CRYPT";
  }

  if ((FindSubString(aname, "cavern") != -1)) {
    return "CAVES";
  }

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
  if ((FindSubString(aname, "sewer") != -1) ||
      (FindSubString(aname, "pipes") != -1))
    {
      return "SEWER";
    }

  if ((FindSubString(aname, "road") != -1) ||
      (FindSubString(aname, "path") != -1) ||
      (FindSubString(aname, "grounds") != -1) ||
      (FindSubString(aname, "way") != -1))
    {
      return "CITY_EXTERIOR";
    }
  if ( (FindSubString(aname, "peak") != -1) ||
       (FindSubString(aname, "grounds") != -1) ||
       (FindSubString(aname, "mountain") != -1) ||
       (FindSubString(aname, "underdark") != -1) ||
       (FindSubString(aname, "dusty") != -1) ||
       (FindSubString(aname, "vale") != -1) ||
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
    return "CAVES";
  }

  if((sTilesetResref == TILESET_RESREF_RUINS)){
    return "RUINS";
  }

  if((sTilesetResref == TILESET_RESREF_CITY_INTERIOR_2) ||
     (sTilesetResref == TILESET_RESREF_CASTLE_INTERIOR_2) ||
     (sTilesetResref == TILESET_RESREF_FORT_INTERIOR) ) {
    return  "CITY_INTERIOR";
  }
  return "CITY_INTERIOR";
}

// this will match a group using tileset
// https://nwnlexicon.com/index.php/Tileset_resref
//  Now we have a list of areas if we use the
//  Name
/* ------------------------------------------------------ */
/* King's Forest - Arabel - High Horn Gate                */
/* King's Forest - Arabel - Calantar's Gate               */
/* Arak'haret                                             */
/* Vieja Tumba                                            */
/* King's Forest - Aunkspear                              */
/* Bamboo Marshes                                         */
/* King's Forest - Blisterfoot Inn                        */
/* Brythain                                               */
/* Buccaneer's Beacon                                     */
/* Buccaneer's Isle                                       */
/* Cabhan Daire                                           */
/* Caer Manann                                            */
/* King's Forest - Calantar's Way North                   */
/* King's Forest - Calantar's Way South                   */
/* The Captain's Daughter                                 */
/* Celestial City                                         */
/* Cinsti'oras                                            */
/* Citadel of the Deathless                               */
/* city_adventure1                                        */
/* Duke's Watch Sewers                                    */
/* Crag Cove                                              */
/* Crypts of Deceit                                       */
/* <c~!!>DARKTHORNE CASTLE</c>                            */
/* East Isles Trading Company                             */
/* King's Forest - Espar                                  */
/* Evenglari Castle Grounds                               */
/* Evenglari Chapel                                       */
/* Evenglari Keep - Level 1                               */
/* Evenglari Keep - Level 2                               */
/* Evenglari Keep - Level 3                               */
/* Evenglari Keep - Level 4                               */
/* Evenglari Keep - Level 5                               */
/* Forsaken Crags                                         */
/* Barbarian Fortress of Kharnath                         */
/* Fugue Plane                                            */
/* King's Forest - Gray Oaks                              */
/* Caer Manann Temple                                     */
/* King's Forest - Eveningstar - High Pasture             */
/* King's Forest - High Road West                         */
/* King's Forest - Hilp                                   */
/* Villa Hermosa                                          */
/* Hobbiton - The Hill                                    */
/* King's Forest - Calantar's Way - South of Immersea     */
/* King's Forest - Immersea                               */
/* King's Forest - Immersea - Redstone Castle             */
/* King's Forest - North of Immersea                      */
/* King's Forest - Blisterfoot Trail                      */
/* King's Forest - High Road East                         */
/* King's Forest - South Path                             */
/* King's Forest - The Way of the Dragon - North          */
/* King's Forest - The Way of the Dragon - South          */
/* The King's Ransom                                      */
/* Lanmorilyn Vale                                        */
/* King's Forest - Dhedluk                                */
/* King's Forest - Eveningstar                            */
/* King's Forest - Eveningstar - Dusty Cavern             */
/* King's Forest - Starwater Road North                   */
/* King's Forest - Eveningstar - Starwater Gorge          */
/* King's Forest - Eveningstar - Haunted Forest           */
/* King's Forest - Starwater Road South                   */
/* King's Forest - Knightswood                            */
/* King's Forest - Mouth o' Gargoyles                     */
/* Mama Marta's Voodoo Shop                               */
/* Masonic Temple                                         */
/* Minas Morgul                                           */
/* Minas Tirith - Center                                  */
/* Minas Tirith - Citadel                                 */
/* Khal Tax - North                                       */
/* Khal Tax - South                                       */
/* Khal Tax - Upper City                                  */
/* Nelvaren                                               */
/* Old Pirate Cave                                        */
/* Onimura Island                                         */
/* Our Lady of the Sea                                    */
/* Pirates' Guild Hall                                    */
/* Plains of Blood                                        */
/* King's Forest - Plungepool                             */
/* Primeval Forest                                        */
/* Queen's Palace                                         */
/* King's Forest - The Ranger's Way                       */
/* King's Forest - Eveningstar - Rivior's Keep Courtyard  */
/* Ruined City of Vardeness                               */
/* Ruined Pirate Fort                                     */
/* Serpent's Peak                                         */
/* Smythe's Smithy                                        */
/* Swashbuckler's Stash                                   */
/* Tol Miril                                              */
/* TreasureVault                                          */
/* King's Forest - Tyrluk                                 */
/* Vale of Mellondel                                      */
/* Valley of the Gods                                     */
/* King's Forest - Waymoot                                */
/* King's Forest - The Way of the Dragon South of Waymoot */
/* Wild Wood                                              */
/* Ynys Faladel  */

 string ChooseGroupbyTile(object oArea) 
{
  return  Area2Environment(oArea);
}

string ChooseResourcebyTile(object oArea) {
  string env = ChooseGroupbyTile(oArea);
  string resource = "";
  int luck = d100(1);

  if (env == "CAVES" || env == "CITY_EXTERIOR") {
    if (luck > 60 ) {
      resource = "minable";
    } else {
      resource = "deposit";
    }
  }

  if (env == "CITY_INTERIOR") {
    switch (d6(1)) {
      case 1 :
    resource = "bench";
    break;
    case 2:
    resource = "desk";
    break;
    case 3:
    resource = "station";
    break;
    case 4:
    resource = "brew";
    break;
    case 5:
    resource = "farmer";
    break;
    case 6:
    resource = "water";
    break;
    }
  }

  if (env == "FOREST" ) {
    if (luck > 60 ) {
      resource = "choppable";
    } else {
      resource = "plant";
    }
  }

  string s = "select TemplateResRef from placeables" +
    " where Tag like @cnr and LocName like @resource order by RANDOM()" +
    " limit 1;";
  sqlquery q = SqlPrepareQueryCampaign("dnd35", s);
  SqlBindString(q, "@cnr", "%cnr%");
  SqlBindString(q, "@resource", "%"+ resource + "%");
  return SqlStep(q) ? SqlGetString(q, 0) : "";
}

void CreateNESSWaypoints(string type)
{
  object oArea = GetFirstArea();
  object oWP ;
  string NESS_wpname;
  location locl ;
  int chance;
  int loot_table;
  string group_name;
  int i;
  int iAreaX;
  int how_many;
  int luck;

  while (GetIsObjectValid(oArea))
    {
      iAreaX = GetAreaSize(AREA_WIDTH, oArea);

      if (type == NESS_PLACEABLE){
        group_name = ChooseResourcebyTile(oArea);
        if (iAreaX <= 16) {
          how_many = d4(1);
        } else {
          how_many = d6(1);
        }
      } else {
        how_many = d4(1);
        group_name = ChooseGroupbyTile(oArea);
      }

      for (i = 0; i < how_many; i++)
        {
          chance = fix_chances(luck, 30);
          loot_table = Random(4);

          locl = GetRandomLocationfromArea(oArea);
          NESS_wpname = GenerateNESSWaypointDataforGroup(chance, loot_table, type);
          oWP = CreateNamedWaypoint(locl, NESS_wpname);

          if (GetIsObjectValid(oWP))
            {
              Debug("Waypoint created at: " + GetName(oArea) + " Name: "
                     + NESS_wpname + " tag:" + group_name);
              SetTag(oWP,group_name);
                
            } else {
            CriticalError("Waypoint could not be created at : " + GetName(oArea));
          }
        }       
      oArea = GetNextArea();
    }
}

void PopulateWorld() {
  CreateNESSWaypoints(NESS_PLACEABLE);
  CreateNESSWaypoints(NESS_GROUP);
}
