#include "zep_inc_phenos"

void main()
{
object oPC = GetPCSpeaker();
object oFlyer = OBJECT_SELF;
zep_Fly( oFlyer, nNO_WING_CHANGE, fDEFAULT_SPEED, "");

}
