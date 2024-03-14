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
// Will create a NESS tag using arguments.
string GenerateNESSWaypointDataforGroup(int chance, int loot_table) 
{
  string lt = paddzero(loot_table);
  string rs = paddzero(chance);
  
  string wpname = "SP_SN05M03_SA05M03_SD12M10_PC03_SG_" + "LT" + lt + "_RS" + rs;
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
    string sTilesetResref = GetTilesetResRef(oArea);
    string group = "scaled_commoners";

    // If the area was created using the Rural Winter or Frozen Wastes tilesets...
    if((sTilesetResref == TILESET_RESREF_RURAL_WINTER) || (sTilesetResref == TILESET_RESREF_FROZEN_WASTES) || sTilesetResref == TILESET_RESREF_FOREST) {
        switch(Random(4) + 1) {
             case 1: group = "scaled_forest"; break;
             case 2: group = "scaled_outdoor"; break;
             case 3: group = "scaled_plants"; break;
             case 4: group = "scaled_elfs"; break;
        }
       
    } 

    if((sTilesetResref == TILESET_RESREF_RUINS) || (sTilesetResref == TILESET_RESREF_FROZEN_WASTES) || sTilesetResref == TILESET_RESREF_DESERT) {
        switch(Random(4) + 1) {
             case 1: group = "scaled_crypt"; break;
             case 2: group = "scaled_outdoor"; break;
             case 3: group = "scaled_trolls"; break;
             case 4: group = "scaled_giants"; break;
             case 5: group = "scaled_mercs"; break;
        }
      
    } 
 if((sTilesetResref == TILESET_RESREF_CITY_INTERIOR_2) ||  (sTilesetResref == TILESET_RESREF_CASTLE_INTERIOR_2) || (sTilesetResref == TILESET_RESREF_FORT_INTERIOR) ) {       
       group = "scaled_commoners";
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
        int how_many = Random(5);
        for (i = 0; i < how_many; i++)
        {
            chance = Random(100);
            loot_table = Random(3);
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
