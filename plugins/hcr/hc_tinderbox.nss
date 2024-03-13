//5.4 inspired by Haroc
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
        if(oOther==OBJECT_INVALID)
        {
            location lWhere=GetItemActivatedTargetLocation();
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
            return;
        }
}
