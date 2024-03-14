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


void CreateNESSWaypoints()
{
    object oArea = GetFirstArea();
    object owp ;
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
            owp = CreateObject(OBJECT_TYPE_WAYPOINT,"nw_waypoint001",locl,FALSE,"scaled_kobolds");
            if (GetIsObjectValid(owp)) 
            {
                PrintString("[NESS] Waypoint created at: " + GetName(oArea) + " Name: "
                + NESS_wpname + " tag:" + " scaled_forest");
                SetName(owp, NESS_wpname);
                SetTag(owp,"scaled_forest");
                PrintString(ObjectToString(owp));
                
            } else {
                PrintString("[NESS] Waypoint could not be created at : " + GetName(oArea));
                PrintString(ObjectToString(owp));
            }
        }       
        oArea = GetNextArea();
    }
}
