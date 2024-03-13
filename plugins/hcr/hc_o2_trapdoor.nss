// sr5
//:://////////////////////////////////////////////
//::// Modified By:Ellis Garrett
//::// Modified On: Oct 10 2002
//::// Modification: Added henchmen and companions
//::// can follow through hiddendoor
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetLastUsedBy();
    string sDest = GetLocalString( OBJECT_SELF, "Destination" );
    object oDest = GetObjectByTag(sDest);
    location lDest = GetLocation(oDest);
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    int iAnimal = GetIsObjectValid(oAnimal);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    int iDominated = GetIsObjectValid(oDominated);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    int iFamiliar = GetIsObjectValid(oFamiliar);
    object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    int iHenchman = GetIsObjectValid(oHenchman);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    int iSummoned = GetIsObjectValid(oSummoned);
    if (!GetLocked(OBJECT_SELF))
    {
        if (GetIsOpen(OBJECT_SELF))
        {
            AssignCommand(oPC, JumpToLocation(lDest));
            if (iAnimal == TRUE)
            {
              AssignCommand( oAnimal, JumpToLocation(lDest));
            }
            if (iAnimal == TRUE)
            {
              AssignCommand( oDominated, JumpToLocation(lDest));
            }
            if (iAnimal == TRUE)
            {
              AssignCommand( oFamiliar, JumpToLocation(lDest));
            }
            if (iAnimal == TRUE)
            {
              AssignCommand( oHenchman, JumpToLocation(lDest));
            }
            if (iAnimal == TRUE)
            {
              AssignCommand( oSummoned, JumpToLocation(lDest));
            }
            PlayAnimation(ANIMATION_PLACEABLE_CLOSE);
        } else
        {
            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        }
    } else
    {
    //    ActionUseSkill
    }
}

