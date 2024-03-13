void main()
{
   object oPC = GetLastUsedBy();
   int nGP = GetGold(oPC);
   if (nGP >= 0)

   {  PlaySound("it_coins");
      TakeGoldFromCreature(0, oPC, TRUE);
      CreateItemOnObject("sweetmtnsprwater", oPC, 1);
   }
}
