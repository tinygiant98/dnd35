// sr5.3
// added check for tags of items if resref doesnt work (bug in imported items).
#include "hc_inc"
#include "hc_inc_htf"
#include "hc_text_activate"
#include "hc_text_rest"
void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    string sItemTag=GetLocalString(oUser,"TAG");
    int iHUNGERSYSTEM = GetLocalInt(oMod,"HUNGERSYSTEM");

    //Used uncooked foods
    if (FindSubString(GetStringUpperCase(sItemTag),"RAW")!= -1)
    {
        if(oOther==OBJECT_INVALID)
        {
            SendMessageToPC(oUser,COOKME);
            return;
        }
        if  (FindSubString(GetStringUpperCase(GetTag(oOther)), "FIRE") == -1 || FindSubString(GetStringUpperCase(sItemTag),"ATS_R")!= -1 )
        {
            SendMessageToPC(oUser, CANTCOOK);
            return;
        }
        FloatingTextStringOnCreature(COOKFLOAT,oUser);
        DestroyObject(oItem);
        CreateItemOnObject("cookedfood",oUser);
        return;
    }

    //Used Food item
    else if (FindSubString(GetStringUpperCase(sItemTag),"FOOD") != -1) {
        if (iHUNGERSYSTEM)
            UseFoodOrDrinkItem(oUser,oItem);
        else {
            SendMessageToPC(oUser,EATFOOD + " [" + GetName(oItem) + "]");
            DestroyObject(oItem);
        }
        return;
    }

    //Used Drink Item
    else if (FindSubString(GetStringUpperCase(sItemTag),"DRINK") != -1) {
        if (iHUNGERSYSTEM)
            UseFoodOrDrinkItem(oUser,oItem);
        else {
            SendMessageToPC(oUser,GULPDRINK + " [" + GetName(oItem) + "]");
            if (FindSubString(GetStringUpperCase(sItemTag),"ALCOHOL") != -1)
                MakePCDrunk(oUser,1,BURP);
            DestroyObject(oItem);
        }
        return;
    }

    //Used Water Canteen
    else if (sItemTag == "WaterCanteen") {
        if (iHUNGERSYSTEM) {
            location loc;
            if(oOther==OBJECT_INVALID)
                loc = GetItemActivatedTargetLocation();
            UseWaterCanteen(oUser,oItem,oOther,loc);
        }
        else {
            //The water canteen really has no purpose unless HUNGERSYSTEM is on,
            //but if it isn't give it some cool effects anyway.
             AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
            DelayCommand(1.5,FloatingTextStringOnCreature(GULP, oUser));
        }
        return;
    }
    else
    {
       // Some other unique power item either by its resref or its tag.
        if (GetResRef(GetItemActivated()) != "")
           ExecuteScript(GetResRef(GetItemActivated()), oUser);
        else
           ExecuteScript(GetTag(GetItemActivated()), oUser);
    }
    DeleteLocalString(oUser,"TAG");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
}

