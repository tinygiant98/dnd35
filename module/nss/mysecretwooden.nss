//::///////////////////////////////////////////////
//:: nw_o2_dtwalldoor.nss
//:: Copyright (c) 2001-2 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script runs on either the Hidden Trap Door
    or Hidden Wall Door Trigger invisible objects.
    This script will do a check and see
    if any PC comes within a radius of this Trigger.

    If the PC has the search skill or is an Elf then
    a search check will be made.

    It will create a Trap or Wall door that will have
    its Destination set to a waypoint that has
    a tag of DST_<tag of this object>

    The radius is determined by the Reflex saving
    throw of the invisible object

    The DC of the search stored by the Willpower
    saving throw.

*/
//:://////////////////////////////////////////////
//:: Created By  : Robert Babiak
//:: Created On  : June 25, 2002
//::---------------------------------------------
//:: Modifyed By : Robert, Andrew, Derek
//:: Modifyed On : July - September
//:://////////////////////////////////////////////

/*
My version JMcA 23/7/03
This version uses the original secret door scripts modified to check for active searching and specific races.
I also allow automatic detection if using true seeing
It triggers a custon door that has its own script that will transport associates
I have included possibility of henchmen finding, and a chat phrase - copied from the SOU secret trigger script
One script will create a wooden door, on e a stone door and one a metal door, etc
*/


void main()
{
    if (GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC)==OBJECT_INVALID) return;
    // get the radius and DC of the secret door.
    float fSearchDist = IntToFloat(GetReflexSavingThrow(OBJECT_SELF));
    int nDiffaculty = GetWillSavingThrow(OBJECT_SELF);

    // what is the tag of this object used in setting the destination
    string sTag = GetTag(OBJECT_SELF);

    // has it been found?
    int nDone = GetLocalInt(OBJECT_SELF,"D_"+sTag);
    int nReset = GetLocalInt(OBJECT_SELF,"Reset");
    object oidDoor;
    // ok reset the door is destroyed, and the done and reset flas are made 0 again
    if (nReset == 1)
    {
        nDone = 0;
        nReset = 0;

        SetLocalInt(OBJECT_SELF,"D_"+sTag,nDone);
        SetLocalInt(OBJECT_SELF,"Reset",nReset);

        object oidDoor= GetLocalObject(OBJECT_SELF,"Door");
        if (oidDoor != OBJECT_INVALID)
        {
            SetPlotFlag(oidDoor,0);
            DestroyObject(oidDoor,GetLocalFloat(OBJECT_SELF,"ResetDelay"));
        }

    }


    int nBestSkill = -50;
    object oidBestSearcher = OBJECT_INVALID;
    int nCount = 1;

    // Find the best searcher within the search radius.
    object oidNearestCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);       //enemy because trigger is hostile
    object oPC= oidNearestCreature;
    int nDoneSearch = 0;
    int nFoundPCs = 0;

    while ((nDone == 0) &&
           (nDoneSearch == 0) &&
           (oidNearestCreature != OBJECT_INVALID)
          )
    {
        // what is the distance of the PC to the door location
        float fDist = GetDistanceBetween(OBJECT_SELF,oidNearestCreature);

        if (fDist <= fSearchDist)
        {
            int nSkill = GetSkillRank(SKILL_SEARCH,oidNearestCreature);

            if (nSkill > nBestSkill)
            {
                nBestSkill = nSkill;
                oidBestSearcher = oidNearestCreature;
            }
            nFoundPCs = nFoundPCs +1;
        }
        else
        {
            // If there is no one in the search radius, don't continue to search
            // for the best skill.
            nDoneSearch = 1;
        }
        nCount = nCount +1;
        oidNearestCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF ,nCount);
    }

    if ((nDone == 0) &&
        (nFoundPCs != 0) &&
        (GetIsObjectValid(oidBestSearcher))
       )
    {
       int nMod = d20();

//mybit
    oPC=oidBestSearcher;
    int iRaceBonus=0;
    int iRace=GetRacialType(oPC);
    if (GetDetectMode(oPC)==DETECT_MODE_ACTIVE)
        {
        iRaceBonus=6;
        }



    effect e1=GetFirstEffect(oPC);
    effect e2=GetNextEffect(oPC);
    int itrue=0;
    if (GetEffectType(e1)==EFFECT_TYPE_TRUESEEING)
        {
        itrue=1;
        }
    else
        {
        while (GetIsEffectValid(e2) && itrue==0)
            {
            if (GetEffectType(e2)==EFFECT_TYPE_TRUESEEING)
                {
                itrue=1;
                }
            e2=GetNextEffect(oPC);
            }
        }

    e1=GetFirstEffect(oPC);
    e2=GetNextEffect(oPC);
    int iblind=0;
    if (GetEffectType(e1)==EFFECT_TYPE_BLINDNESS || GetEffectType(e1)==EFFECT_TYPE_DARKNESS)
        {
        iblind=1;
        }
    else
        {
        while (GetIsEffectValid(e2) && iblind==0)
            {
            if (GetEffectType(e2)==EFFECT_TYPE_BLINDNESS || GetEffectType(e2)==EFFECT_TYPE_DARKNESS)
                {
                iblind=1;
                }
            e2=GetNextEffect(oPC);
            }
        }
    if (iblind==1)
        {
        iRaceBonus=iRaceBonus-4;
        }


//end of mybit

            // did we find it.
       if ((nBestSkill +nMod +iRaceBonus> nDiffaculty)||itrue==1)
       {
            if (itrue==1)
                {
                AssignCommand(oPC, SpeakString("With magical aid you have found a secret door."));
                }
            location locLoc = GetLocation (OBJECT_SELF);

            // yes we found it, now create the appropriate door


            if (!GetIsPC(oPC))
                {
                // If a henchman, alert the PC if we make the detect check
                object oMaster = GetMaster(oPC);
                if (GetIsObjectValid(oMaster) )
                    {
                    AssignCommand(oPC, SpeakString(GetName(oPC)+" found something!"));
                    AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_SEARCH));
                    }
                else
                    {
                    return;
                    }
                }
            else
                {
                AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_LOOKHERE));
                }
            oidDoor = CreateObject(OBJECT_TYPE_PLACEABLE,"mysecretwooden",locLoc,TRUE);    //my bit - this generates my own door which has the myhidden door 2 trigger to move henchmen etc
            SetLocalString( oidDoor, "Destination" , "DST_"+sTag );
            // make this door as found.
            SetLocalInt(OBJECT_SELF,"D_"+sTag,1);
            SetPlotFlag(oidDoor,1);
            SetLocalObject(OBJECT_SELF,"Door",oidDoor);
            SetPlotFlag(OBJECT_SELF,0);
            DestroyObject(OBJECT_SELF);




       } // if skill search found

    }//if object valid  best searcher

}
