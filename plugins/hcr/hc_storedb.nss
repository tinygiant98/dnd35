// hcr3 3.1
// added delay
// persistence store drop bags.

#include "hc_id"
#include "hc_inc_persist"

void main()
{
string sID =  GetsID(OBJECT_SELF);
DelayCommand(1.8, HCStoreDB(sID));
}
