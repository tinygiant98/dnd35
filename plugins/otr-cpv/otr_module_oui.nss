/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR)
//
//  Name:  otr_module_oui
//
//  Desc:  This script notifies OTR oxen
//         within a radius of 20 meters of dropped feed.
//         This script should be executed from the
//         module's OnUnaquireItem handler.
//
//  Author: David Bobeck 24Sep03
//
/////////////////////////////////////////////////////////
#include "otr_config_inc"

void main()
{
  object oItem = GetModuleItemLost();

  int bAlertOxen = FALSE;
  if (GetTag(oItem) == OTR_STRING_OXEN_FOOD_ITEM_TAG_1)
  {
    bAlertOxen = TRUE;
  }
  else if (GetTag(oItem) == OTR_STRING_OXEN_FOOD_ITEM_TAG_2)
  {
    bAlertOxen = TRUE;
  }

  if (bAlertOxen)
  {
    // find all oxen within 20 meters of the dropped food
    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oItem), FALSE, OBJECT_TYPE_CREATURE);
    while (oCreature != OBJECT_INVALID)
    {
      if (GetTag(oCreature) == "otrTradeRouteOx")
      {
        // alert the oxen that feed has been dropped near bye
        event eUserDef = EventUserDefined(2701);
        SignalEvent(oCreature, eUserDef);
      }
      oCreature = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(oItem), FALSE, OBJECT_TYPE_CREATURE);
    }
  }
}
