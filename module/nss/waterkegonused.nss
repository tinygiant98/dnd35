void main()
{
   object oPC = GetLastUsedBy();
   int nGP = GetGold(oPC);
   if (nGP >= 4)

   {  PlaySound("it_coins");
      TakeGoldFromCreature(4, oPC, TRUE);
      CreateItemOnObject("sweetmtnsprwater", oPC, 1);
   }
   else
   {
      SpeakString("You need 4gp");
   }
}
