// HCR v3.2.0 -
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_Inc_DropBag
//::////////////////////////////////////////////////////////////////////////////
/*

*/
//::////////////////////////////////////////////////////////////////////////////
#include "HC_Id"
#include "HC_Inc_PWDB_Func"
//::////////////////////////////////////////////////////////////////////////////


// * FUNCTION PROTOTYPES


// Drop bag based on lDiedHere location and oPC facing.
object DropBag(location lDiedHere, object oPC);


// * FUNCTION DEFINITIONS


//::////////////////////////////////////////////////////////////////////////////
object DropBag(location lDiedHere, object oPC)
{
    // Generate New Facing.
    float fRandom = IntToFloat(d20());
    float fDither = (45.0 + fRandom);
    float fFacing = GetFacing(oPC);
    fFacing += fDither;
    if (fFacing > 360.0)
    {   fFacing = 720.0 - fFacing; }
    if (fFacing < 0.0)
    {   fFacing = 360.0 + fFacing; }

    // Generate New Position.
    float fNewX;
    float fNewY;
    float fNewZ;
    vector vCorpseLoc = GetPositionFromLocation(lDiedHere);
    float fDistance = -0.8;
    if ((fFacing > 0.0) && (fFacing < 90.0))
    {   fNewX = vCorpseLoc.x + ((cos(fFacing))*fDistance); fNewY = vCorpseLoc.y + ((sin(fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
    else if ((fFacing > 90.0f) && (fFacing < 180.0f))
    {   fNewX = vCorpseLoc.x - ((cos(180.0f - fFacing))*fDistance); fNewY = vCorpseLoc.y + ((sin(180.0f - fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
    else if ((fFacing > 180.0f) && (fFacing < 270.0f))
    {   fNewX = vCorpseLoc.x - ((cos(fFacing - 180.0f))*fDistance); fNewY = vCorpseLoc.y - ((sin(fFacing - 180.0f))*fDistance); fNewZ = vCorpseLoc.z; }
    else if ((fFacing > 270.0f) && (fFacing < 360.0f))
    {   fNewX = vCorpseLoc.x + ((cos(360.0f - fFacing))*fDistance); fNewY = vCorpseLoc.y - ((sin(360.0f - fFacing))*fDistance); fNewZ = vCorpseLoc.z; }
    else if (fFacing == 0.0f)
    {   fNewX = vCorpseLoc.x + fDistance; fNewY = vCorpseLoc.y; fNewZ = vCorpseLoc.z; }
    else if (fFacing == 90.0f)
    {   fNewX = vCorpseLoc.x + 0.2; fNewY = vCorpseLoc.y + fDistance; fNewZ = vCorpseLoc.z; }
    else if (fFacing == 180.0f)
    {   fNewX = vCorpseLoc.x - fDistance; fNewY = vCorpseLoc.y + 0.2; fNewZ = vCorpseLoc.z; }
    else if (fFacing == 270.0f)
    {   fNewX = vCorpseLoc.x + 0.2; fNewY = vCorpseLoc.y - fDistance; fNewZ = vCorpseLoc.z; }
    vector vNewFinal  = Vector(fNewX, fNewY, fNewZ);

    // Generate New Location.
    location lDropBag = Location(GetArea(oPC), vNewFinal, fFacing);

    // Use the new location to create the drop bag, set the locals also.
    string sID = GetsID(oPC);
    object oDropBag = CreateObject(OBJECT_TYPE_PLACEABLE, "DyingCorpse", lDropBag, FALSE, "DropBag" + sID);
    SetLocalObject(oPC, "DROPBAG", oDropBag);
    SetLocalString(oDropBag, "Pkey", sID);
    return oDropBag;
}
//::////////////////////////////////////////////////////////////////////////////
//void main(){}
