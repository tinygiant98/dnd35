/*set localstring of store tag on object first*/

#include "nw_i0_plot"
void main()
{
    ExecuteScript("opst_template",OBJECT_SELF);
    object oStore = GetNearestObjectByTag(GetTag(OBJECT_SELF));
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
