/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  otr_oxen_oud
//
//  Desc:  This is a custom handler for the OTR ox's
//         OnUserDefined event. User event 2701 will be
//         fired by the module whenever ox food is
//         dropped in the vicinity of this ox. The
//         ox will move to the food and eat it. Hungry oxen
//         will stop following the PC.
//
//  Author: David Bobeck 24Sep03
//
/////////////////////////////////////////////////////////
#include "otr_route_utils"

void main()
{
  int nEventNumber = GetUserDefinedEventNumber();
  if (nEventNumber == 2701) // food has been dropped
  {
    location locFood;
    int bFoodFound = FALSE;
    int nFoodPoints = 0;

    // locate the nearest cow food item and move to it.
    object oItem = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_ITEM);
    while ((oItem != OBJECT_INVALID) && !bFoodFound)
    {
      if (GetTag(oItem) == OTR_STRING_OXEN_FOOD_ITEM_TAG_1)
      {
        bFoodFound = TRUE;
      }
      else if (GetTag(oItem) == OTR_STRING_OXEN_FOOD_ITEM_TAG_2)
      {
        bFoodFound = TRUE;
      }

      if (bFoodFound)
      {
        ActionMoveToLocation(GetLocation(oItem), FALSE);
        ActionDoCommand(OtrEatOxFood(OBJECT_SELF, oItem));
      }
      else
      {
        oItem = GetNextObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_ITEM);
      }
    }

    if (bFoodFound)
    {
      // keep looking for more food
      event eUserDef = EventUserDefined(2701);
      ActionDoCommand(SignalEvent(OBJECT_SELF, eUserDef));
    }
  }
}

