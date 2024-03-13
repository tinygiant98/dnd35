//::///////////////////////////////////////////////
//:: Trap door that takes you to a waypoint that
//:: is stored into the Destination local string.
//:: FileName
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Robert Babiak
//:: Created On: June 25, 2002
//:://////////////////////////////////////////////
//:: Modified By: Andrew Nobbs
//:: Modified On: September 23, 2002
//:: Modification: Removed unnecessary spaces.
//:://////////////////////////////////////////////

void main()
{
    object oidUser;
    object oidDest;
    string sDest;

    if (!GetLocked(OBJECT_SELF))
    {
        if (GetIsOpen(OBJECT_SELF))
        {
            sDest = GetLocalString(OBJECT_SELF,"Destination");

            oidUser = GetLastUsedBy();
            oidDest = GetObjectByTag(sDest);

            AssignCommand(oidUser,ActionJumpToObject(oidDest,FALSE));
object familiar=GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oidUser);
if (familiar!=OBJECT_INVALID)
    {
    AssignCommand(familiar,JumpToObject(oidDest));
 }
object henchman;
int n;
for (n=1;n<=3;n++)
    {
    henchman=GetHenchman(oidUser,n);
    if (henchman!=OBJECT_INVALID)
        {
        AssignCommand(henchman,JumpToObject(oidDest));
        object summoned=GetAssociate(ASSOCIATE_TYPE_SUMMONED,henchman);
        if (summoned!=OBJECT_INVALID)
            {
            AssignCommand(summoned,JumpToObject(oidDest));
            }
        }
    }
object summoned=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oidUser);
if (summoned!=OBJECT_INVALID)
    {
    AssignCommand(summoned,JumpToObject(oidDest));
    }
object animalcompanion=GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oidUser);
if (animalcompanion!=OBJECT_INVALID)
    {
    AssignCommand(animalcompanion,JumpToObject(oidDest));
    }
object dominated=GetAssociate(ASSOCIATE_TYPE_DOMINATED,oidUser);
if (dominated!=OBJECT_INVALID)
    {
    AssignCommand(dominated,JumpToObject(oidDest));
    }
            DelayCommand(0.5,PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
        } else
        {
            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        }
    } else
    {

    }

}
