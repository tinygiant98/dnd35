//::////////////////////////////////////////////////////////////////////////////
//:: HCR v3.0.3 - 18th May, 2005 - SE
//:: FileName hc_inc_wandering
//::////////////////////////////////////////////////////////////////////////////
/*
   Set int WANDERSYSTEM = 1; in hc_defaults to use this
   wandering encounter system.
   *Note* Only works with hostile creatures in the current area the player is
   resting in.

   At this time it is only called on player rest to see if an encounter occurs
   during their rest. A successful call to this script will cause a nearby
   hostile monster to come and attack.
   Adding WanderingMonster(object oPC) to the OnEnter of a trigger will also
   call the system.

   The default percentage rate for an encounter in game meters is:
   >100m = 1%, >60-100m = 2.5%, >50-60m = 5%, >40-50m = 7.5%, >30-40m = 10%

   To add extra percentage rate to an area:
   To setup >  EDIT > AREA PROPERTIES > ADAVANCED > VARIABLES,
   Add the variable - PLUS_WANDERING_PERCENT Type - INT Value - X
   X will be added to the base value which by default is 10% at 30 - 40 meters
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Sir Elric
//:: Added to Base On: 18th May, 2005
//:: Updated On: 29th December, 2004
//:: Restructured By: KMdS  aka Kilr Mik d Spik
//:: Restructured On: 29th December, 2004
//::////////////////////////////////////////////////////////////////////////////

//This processes the routines on a successful wandering monster check
void attackAndSendMessages(object oPC,object oTarget,string sTarget,float fDist,string sArea,int iDebug = 0,int iTellDMs = 0);
void attackAndSendMessages(object oPC,object oTarget,string sTarget,float fDist,string sArea,int iDebug = 0,int iTellDMs = 0)
{
    if(iTellDMs)
       SendMessageToAllDMs(GetName(oPC)+ " is resting and about to be attacked by a " +sTarget+ " from " +FloatToString(fDist, 3 ,2)+" away in " +sArea);
    if(iDebug)
       SendMessageToPC(oPC, "Nearest hostile creature is " +FloatToString(fDist, 3 ,2)+" and on it's way!");
    //Attack resting player
    AssignCommand(oTarget, ActionAttack(oPC));
}


//Call this function any time you want a wandering monster check
//located in the code file "Hc_Inc_Wandering".
void WanderingMonster(object oPC,int iPermil = 1);
void WanderingMonster(object oPC,int iPermil = 1)
{
    //System variables
    int iAttacked = 0; // Leave this value as is.
    int iDB       = 0; // Store to database? Set to 1.
    int iDebug    = 0; // Set to 1 for debugging only.
    int iTellDMs  = 1; // Set to 1 lets DM's know when players are attacked while resting

    //Function variables
    int     iPattern;
    float   fDist;
    object  oTarget;
    string  sTarget;
    object  oArea;
    string  sArea;
    object  oMod = GetModule();

    //Not turned on exit
    if (!GetLocalInt(oMod, "WANDERSYSTEM")) return;

    oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,oPC);
    sTarget = GetName(oTarget);
    //Valid hostile creature and not currently in combat proceed
    if(GetIsObjectValid(oTarget) && !GetIsInCombat(oTarget))
    {
        oArea = GetArea(oPC);
        sArea = GetName(oArea);
        //Get distance between player resting and nearest hostile
        fDist = GetDistanceBetween(oPC, oTarget);

        if(iDebug)
           SendMessageToPC(oPC, "Nearest hostile creature is " +FloatToString(fDist, 3 ,2));

        int iRoll = ((d100()*10)+d100()+1);

        //Let's check to see how closer the nearest hostile is.
        if(fDist > 100.0)                       iPattern = 1;
        if((fDist > 60.0)&&(fDist <= 100.0))    iPattern = 2;
        if((fDist > 50.0)&&(fDist <= 60.0))     iPattern = 3;
        if((fDist > 40.0)&&(fDist <= 50.0))     iPattern = 4;
        if((fDist > 30.0)&&(fDist <= 40.0))     iPattern = 5;

        iPermil = (iPermil + GetLocalInt(oArea,"PLUS_WANDERING_PERCENT"));
        switch (iPattern){
            case 1:
                if(iRoll >= (1000-(iPermil*10))){
                    attackAndSendMessages(oPC,oTarget,sTarget,fDist,sArea,iDebug,iTellDMs);
                    iAttacked = 1;} //frequency feedback
                break;
            case 2:
                if(iRoll >= (1000-(iPermil*25))){
                    attackAndSendMessages(oPC,oTarget,sTarget,fDist,sArea,iDebug,iTellDMs);
                    iAttacked = 1;} //frequency feedback
                break;
            case 3:
                if(iRoll >= (1000-(iPermil*50))){
                    attackAndSendMessages(oPC,oTarget,sTarget,fDist,sArea,iDebug,iTellDMs);
                    iAttacked = 1;} //frequency feedback
                break;
            case 4:
                if(iRoll >= (1000-(iPermil*75))){
                    attackAndSendMessages(oPC,oTarget,sTarget,fDist,sArea,iDebug,iTellDMs);
                    iAttacked = 1;} //frequency feedback
                break;
            case 5:
                if(iRoll >= (1000-(iPermil*100))){
                    attackAndSendMessages(oPC,oTarget,sTarget,fDist,sArea,iDebug,iTellDMs);
                    iAttacked = 1;} //frequency feedback
                break;
        }

    }
    else
    {
         if(iDebug)
             SendMessageToPC(oPC, "No wandering monsters this rest");
    }

    if(iAttacked && iDB)
    {
        // Save to database for frequency feedback for builder if turned on
        int iWM = GetCampaignInt("Wandering_Monsters", sTarget, oPC)+1;
                  SetCampaignInt("Wandering_Monsters", sTarget, iWM, oPC);
    }
}

