// 5.4
// changed tracking name to racial type thanks Amurayi
//// hc_inc_track
// Tracking variables

/*
  Author: Big E
  Date:   July 20, 2002
  Given the facing value (0-360), set the compass direction.
  Modified by Archaegeo for Ranger Tracking
  Edit by Amurayi : Trackmessahe tells race only instead of creature's name
*/
void GetDirection(float fFacing, object oTracker, object oCritter)
    {
    //Correct the bug in GetFacing (Thanks Iskander)
    if (fFacing >= 360.0)
        fFacing  =  720.0 - fFacing;
    if (fFacing <    0.0)
        fFacing += (360.0);
    int iFacing = FloatToInt(fFacing);
    /*
      359 -  2  = E
        3 - 45  = ENE
       46 - 87  = NNE
       88 - 92  = N
       93 - 135 = NNW
      136 - 177 = WNW
      178 - 182 = W
      183 - 225 = WSW
      226 - 267 = SSW
      268 - 272 = S
      273 - 315 = SSE
      316 - 358 = ESE
    */
    string sDirection = "";
    if((iFacing >= 359) && (iFacing <=   2))
        sDirection = "E";
    if((iFacing >=   3) && (iFacing <=  45))
        sDirection = "ENE";
    if((iFacing >=  46) && (iFacing <=  87))
        sDirection = "NNE";
    if((iFacing >=  88) && (iFacing <=  92))
        sDirection = "N";
    if((iFacing >=  93) && (iFacing <= 135))
        sDirection = "NNW";
    if((iFacing >= 136) && (iFacing <= 177))
        sDirection = "WNW";
    if((iFacing >= 178) && (iFacing <= 182))
        sDirection = "W";
    if((iFacing >= 183) && (iFacing <= 225))
        sDirection = "WSW";
    if((iFacing >= 226) && (iFacing <= 267))
        sDirection = "SSW";
    if((iFacing >= 268) && (iFacing <= 272))
        sDirection = "S";
    if((iFacing >= 273) && (iFacing <= 315))
        sDirection = "SSE";
    if((iFacing >= 316) && (iFacing <= 358))
        sDirection = "ESE";
    string sRace;
    if (GetRacialType(oCritter) == RACIAL_TYPE_ABERRATION) sRace="An aberration";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ALL) sRace="A creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ANIMAL) sRace="An animal";
    if (GetRacialType(oCritter) == RACIAL_TYPE_BEAST) sRace="A beast";
    if (GetRacialType(oCritter) == RACIAL_TYPE_CONSTRUCT) sRace="A construct";
    if (GetRacialType(oCritter) == RACIAL_TYPE_DRAGON) sRace="A dragon";
    if (GetRacialType(oCritter) == RACIAL_TYPE_DWARF) sRace="A dwarf";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ELEMENTAL) sRace="An elemental";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ELF) sRace="An elf";
    if (GetRacialType(oCritter) == RACIAL_TYPE_FEY) sRace="A fey";
    if (GetRacialType(oCritter) == RACIAL_TYPE_GIANT) sRace="A giant";
    if (GetRacialType(oCritter) == RACIAL_TYPE_GNOME) sRace="A gnome";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HALFELF) sRace="A half-elf";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HALFLING) sRace="A halfling";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HALFORC) sRace="A half-orc";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMAN) sRace="A human";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_GOBLINOID) sRace="A goblinlike creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_MONSTROUS) sRace="A monstrous creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_ORC) sRace="An orclike creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_REPTILIAN) sRace="A reptilianlike creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_INVALID) sRace="An odd thing";
    if (GetRacialType(oCritter) == RACIAL_TYPE_MAGICAL_BEAST) sRace="A very unusual creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_OUTSIDER) sRace="An outsider";
    if (GetRacialType(oCritter) == RACIAL_TYPE_SHAPECHANGER) sRace="A possible shapechanger";
    if (GetRacialType(oCritter) == RACIAL_TYPE_UNDEAD) sRace="An undead";
    if (GetRacialType(oCritter) == RACIAL_TYPE_VERMIN) sRace="A vermin";
    SendMessageToPC(oTracker,sRace+" is to the "+sDirection);
    return ;
    }

