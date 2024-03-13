// hcr3.1
// changed delay.
// persistence store drop bags.

#include "hc_id"
#include "hc_inc_persist"

void main()
{
object oDC = OBJECT_SELF;
string sID = GetLocalString(oDC, "Pkey");
DelayCommand(1.5, HCStoreDB(sID));
}
