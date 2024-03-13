// 5.5
// added code so dying pcs cant spot traps.
// 5.4
// added code for npc traps.
//::///////////////////////////////////////////////
//:: HCR Detectable Object Heartbeat Script
//:: hc_detect_hrtbt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Created By: yibble <yibble@yibble.org>
    Created On: September 25, 2002
    Hacked up version of hc_act_search.
    Using GetDetectMode function to avoid using the
    SearchTool.

*/
//:://////////////////////////////////////////////
//:: Created By: Nathan Reynolds <yibble@yibble.org>
//:: Created On: 25th September 2002
//:://////////////////////////////////////////////
#include "hc_text_traps"

void main()
{
    /* Get the nearest searcher */
    object oUser;
    location lTrap = GetLocation(OBJECT_SELF);
    int nDetectMode = 0;
    float fSearchDist = 100.0;
    oUser = GetFirstObjectInShape(SHAPE_SPHERE, fSearchDist, lTrap, TRUE, OBJECT_TYPE_CREATURE);

    while(GetIsObjectValid(oUser))
    {
        if((nDetectMode = GetDetectMode(oUser)))
        {
            int nRogueLevel = GetLevelByClass(CLASS_TYPE_ROGUE, oUser);
            location locPlayer = GetLocation(oUser);
            float fDis = FeetToMeters(0.0);
            int nFT = FALSE;

            // elves have inate search ability search will always be active
            if(nDetectMode == DETECT_MODE_ACTIVE)
            {
                fDis = FeetToMeters(10.0);
                nFT = TRUE;
            }

            // Check to see if the object has a trap.
            // 5.5 added code so dying pcs cant spot traps.
            if ((GetIsTrapped(OBJECT_SELF)) && (GetDistanceToObject(oUser) <= fDis) && (nFT = TRUE) &&
                 GetCurrentHitPoints(oUser) > 0)
            {

                // Yes, so begin detection routine.
                int oTrapDC = GetTrapDetectDC(OBJECT_SELF) - 100;
                int bCanSpotTrap = FALSE; // Assume that the person cannot spot a trap.

                // Determine spotting capability
                if ((oTrapDC <= 20) || ((oTrapDC > 20) && (nRogueLevel >= 1 )))
                    bCanSpotTrap = TRUE;

                    // Only check to see if detected if not previously detected
                    // and the PC has the ability to do detect it.
                if (!GetTrapDetectedBy(OBJECT_SELF, oUser) && bCanSpotTrap)
                {
                    int nSearch = GetSkillRank(SKILL_SEARCH, oUser);
                    int nDCCheck = d20() + nSearch;
                    if (nDCCheck >= oTrapDC) // Trap found
                    {
                        SetTrapDetectedBy(OBJECT_SELF, oUser);
                        SendMessageToPC(oUser, TRAPFOUND);
                        //SendMessageToPC(oUser, "DEBUG: DETECT_MODE was " + IntToString(nDetectMode) + ". fDis was " + FloatToString(fDis) + ". nFT was " + IntToString(nFT) + ". oTrapDC was " + IntToString(oTrapDC) + ". nDCCheck was " + IntToString(nDCCheck) + ".");
                        SetTrapDetectedBy(OBJECT_SELF,GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oUser));
                        SetTrapDetectedBy(OBJECT_SELF,GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oUser));
                        AssignCommand(oUser,SpeakString("TRAP!"));
                        if(!GetIsPC(oUser))
                         {
                          SetTrapDetectedBy(OBJECT_SELF,GetMaster(oUser));
                         }
                    }
                }
            }
        }
        oUser = GetNextObjectInShape(SHAPE_SPHERE, fSearchDist, lTrap, TRUE, OBJECT_TYPE_CREATURE);
    }
}

