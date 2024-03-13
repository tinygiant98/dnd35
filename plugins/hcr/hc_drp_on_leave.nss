// hcr3
// added new death corpse code.
//sr6.1
// do not need to transfer objects as corpses do not have inv. now.
// changed drop location tag to GraveYard
// sr4

// sr6.1
//#include "hc_inc_transfer"
#include "hc_inc"
// hcr3 new death corpse code.
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
   object oDeadMan;
   object oDeathCorpse;
   // hcr3
   //oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse", lLoc);
   // hcr3 change for deathcorpse.
   oDeathCorpse = CopyFromFugue(oOwner, oPC, oDropped);
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
   // sr6.1
   // not needed as object are not stored in corpse.
   // hcTakeObjects(oDC, oDeathCorpse);
   SpeakString("Cadavre Droppe", TALKVOLUME_SHOUT);
}

void DrpCrpse()
{
    object oClient = GetExitingObject();
    object oEquip = GetFirstItemInInventory(oClient);
    while(GetIsObjectValid(oEquip))
    {
       if(GetTag(oEquip)=="PlayerCorpse") Drop(oEquip, oClient);
       oEquip = GetNextItemInInventory(oClient);
    }
    return;
}


