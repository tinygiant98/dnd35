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


void CreateNESSWaypoints()
{
    object oArea = GetFirstArea();
    object oWP ;
    string NESS_wpname;
    location locl ;
    int chance;
    int loot_table;

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
            if (GetIsObjectValid(oWP)) 
            {
                
                Debug("Waypoint created at: " + GetName(oArea) + " Name: "
                + NESS_wpname + " tag:" + " scaled_forest");
                SetTag(oWP,"scaled_forest");
                Debug(ObjectToString(oWP));
                
            } else {
                CriticalError("Waypoint could not be created at : " + GetName(oArea));
                CriticalError(ObjectToString(oWP));
            }
        }       
        oArea = GetNextArea();
    }
}
