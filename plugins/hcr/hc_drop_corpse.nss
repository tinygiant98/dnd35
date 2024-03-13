// hcr3
// deathcorpse changes
//sr6.1
// takes all corpses from inventory except for npc corpses.
// changed drop location to LastDied.
#include "hc_inc"
#include "hc_inc_dcorpse"

// PLACEHOLDER

void Drop(object oDropped, object oPC)
{
   object oDC=GetLocalObject(oDropped,"DeathCorpse");
   object oOwner=GetLocalObject(oDropped,"Owner");
   string sName=GetLocalString(oDropped,"Name");
   string sCDK=GetLocalString(oDropped,"Key");
   string sID=sName+sCDK;
   object oMod=GetModule();
   location lLoc=GetPersistentLocation(oMod,"DIED_HERE"+sID);
   if (GetAreaFromLocation(lLoc) == OBJECT_INVALID)
   {
      //sr6.1 changed location to GraveYard.
      object oSpawnPoint = GetObjectByTag("GraveYard");
      location lLoc = GetLocation(oSpawnPoint);
   }
   vector vCorpsevec = GetPositionFromLocation(lLoc)+Vector(0.0,0.6,0.0);
   lLoc = Location(GetAreaFromLocation(lLoc), vCorpsevec, 0.0);
   object oDeadMan;
   object oDeathCorpse;
   // hcr3 change for deathcorpse.
   SetLocalInt(oPC, "DEAD", TRUE);
   oDeathCorpse = CopyFromFugue(oOwner, oPC, oDropped);
   //oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse", lLoc);
   oDeadMan=CreateItemOnObject("PlayerCorpse", oDeathCorpse);
   SetLocalObject(oDeadMan,"Owner",oOwner);
   SetLocalString(oDeadMan,"Name",sName);
   SetLocalString(oDeadMan,"Key", sCDK);
   SetLocalObject(oDeadMan,"DeathCorpse",oDeathCorpse);
   SetLocalInt(oDeadMan,"Alignment",GetLocalInt(oDropped,"Alignment"));
   SetLocalString(oDeadMan,"Deity",GetLocalString(oDropped,"Deity"));
   SetLocalObject(oMod,"DeathCorpse"+sName+sCDK,oDeathCorpse);
   SetLocalObject(oMod,"PlayerCorpse"+sName+sCDK,oDeadMan);
   SetLocalObject(oDeathCorpse,"Owner",oOwner);
   SetLocalString(oDeathCorpse,"Name",sName);
   SetLocalString(oDeathCorpse,"Key",sCDK);
   SetLocalObject(oDeathCorpse,"PlayerCorpse",oDeadMan);
   DestroyObject(oDropped);
   SpeakString("Cadavre Droppe", TALKVOLUME_SHOUT);
}

void main()
{
    object oClient = OBJECT_SELF;
    object oEquip = GetFirstItemInInventory(oClient);
    while(GetIsObjectValid(oEquip))
    {
       if(GetTag(oEquip)=="PlayerCorpse") Drop(oEquip, oClient);
       oEquip = GetNextItemInInventory(oClient);
    }
}
