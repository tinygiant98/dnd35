// sr5.3
// Added example of how to set a ALLOWREST variable for a area

#include "hc_inc_htf"
#include "hc_inc_pwdb_func"

//Place holder
void SetAreaOnEnterMessageByStageOfDay(object oArea,int stageofday,string varname, string message)
{
    SetLocalString(oArea, varname + GetStageOfDaySuffix(stageofday), message);
}

void SetAreaOnEnterMessage(object oArea,string varname,string message)
{
    SetAreaOnEnterMessageByStageOfDay(oArea,DAY,varname,message);
    SetAreaOnEnterMessageByStageOfDay(oArea,DAWN,varname,message);
    SetAreaOnEnterMessageByStageOfDay(oArea,DUSK,varname,message);
    SetAreaOnEnterMessageByStageOfDay(oArea,NIGHT,varname,message);
}

void main()
{
    TurnOffAreaConsumeRates(GetObjectByTag("FuguePlane"));


    //Use this script to set all Initial Area variables.
    //This is executed from on module load.


    //The following line is remarked out but use it as a example on how to set a area
    // to Allow unrestricted rest. Just change the tag name to the tag name of the area
    // that you want to allow unrestricted resting (ie inn etc.) Multiple areas can
    // be set up just add a new line and change the tag name.

    //SetPersistentInt(GetObjectByTag("AREA51"), "ALLOWREST", TRUE);
}


