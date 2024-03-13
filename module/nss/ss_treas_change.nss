//************************************************
//** ss_treas_change                            **
//**                                            **
//** Opens nearest store objec to the lever. It **
//** is best if the lever is placed on the      **
//** actual store it is expected to open.       **
//************************************************
//**Created By: Jason Hunter (SiliconScout)     **
//**                                            **
//**Version: 1.6c                               **
//**                                            **
//**Last Changed Date: June 29, 2004            **
//************************************************


void main()
{
    object oPC = GetLastUsedBy();
    object oTreasureType = GetNearestObject(OBJECT_TYPE_STORE);

    OpenStore(oTreasureType, oPC,0,0);

}
