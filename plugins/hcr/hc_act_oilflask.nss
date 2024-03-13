//5.4
// fixed campfire distance.

#include "hc_inc"
#include "hc_text_activate"
void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
    location lWhere=GetItemActivatedTargetLocation();
        if(oOther==OBJECT_INVALID)
        {

            if(GetDistanceBetweenLocations(GetLocation(oUser), lWhere) > 3.0)
            {
                SendMessageToPC(oUser,MOVECLOSER);
                return;
            }
            AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
            DelayCommand(0.8,AssignCommand(oUser,ActionPlayAnimation(
                ANIMATION_LOOPING_GET_LOW)));
            SendMessageToPC(oUser,STARTFIRE);
            CreateObject(OBJECT_TYPE_PLACEABLE,"campfr001",lWhere);
            DestroyObject(oItem);
            return;
        }
        if(GetTag(oOther)=="hc_campfire")
        {
            if(GetDistanceBetweenLocations(GetLocation(oUser), lWhere) > 3.0)
            {
                SendMessageToPC(oUser,MOVECLOSER);
                return;
            }
            AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
            DelayCommand(0.8,AssignCommand(oUser,ActionPlayAnimation(
                ANIMATION_LOOPING_GET_LOW)));
            SetLocalInt(oOther,"BURNCOUNT",
                GetLocalInt(oOther,"BURNCOUNT")+
                (-1*GetLocalInt(oMod,"BURNTORCH")*(FloatToInt(HoursToSeconds(3)/6.0))));
            SendMessageToPC(oUser,FUELFIRE);
            DestroyObject(oItem);
            return;
        }
        if(GetTag(oOther)=="hc_lantern")
        {
            if(GetDistanceBetweenLocations(GetLocation(oUser), lWhere) > 3.0)
            {
                SendMessageToPC(oUser,MOVECLOSER);
                return;
            }
            AssignCommand(oUser,ActionMoveToLocation(GetLocation(oOther)));
            DelayCommand(0.8,AssignCommand(oUser,ActionPlayAnimation(
                ANIMATION_LOOPING_GET_LOW)));
            if(GetLocalInt(oOther,"BURNCOUNT") >
             (-6*GetLocalInt(oMod,"BURNTORCH")*(FloatToInt(HoursToSeconds(1)/6.0))))
            {
                SetLocalInt(oOther,"BURNCOUNT",
                    (-6*GetLocalInt(oMod,"BURNTORCH")*(FloatToInt(HoursToSeconds(1)/6.0))));
                SendMessageToPC(oUser,REFILL);
                DestroyObject(oItem);
                return;
            }
            else
            {
                SendMessageToPC(oUser,ALREADYFULL);
                return;
            }
        }
        else
        {
            SetLocalObject(oUser,"GRENADE",oItem);
            SetLocalObject(oUser,"GRENADETARGET",oOther);
            ExecuteScript("hc_grenade", oUser);
        }
}
