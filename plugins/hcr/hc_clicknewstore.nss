// Store tag was wrong...
// Changed tag from NewbieMerchant2 to NewbieMerchant
// - 26th January, 2006 Sir Elric
void main()
{
    object oNewbiemerh = GetNearestObjectByTag("NewbieMerchant");
    OpenStore(oNewbiemerh, GetLastUsedBy());
}
