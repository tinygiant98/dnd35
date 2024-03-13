string DetermineTrap(object oTrappedObject)
{
 int nTrapType=GetTrapBaseType(oTrappedObject);

  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_ACID)
  {
   return "nw_it_trap014";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH)
  {
   return "nw_it_trap034";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_ELECTRICAL)
  {
   return "nw_it_trap022";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_FIRE)
  {
   return "nw_it_trap018";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_FROST)
  {
   return "nw_it_trap030";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_GAS)
  {
   return "nw_it_trap026";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_HOLY)
  {
   return "nw_it_trap006";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_NEGATIVE)
  {
   return "nw_it_trap042";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_SPIKE)
  {
   return "nw_it_trap002";
  }
  if(nTrapType==TRAP_BASE_TYPE_AVERAGE_TANGLE)
  {
   return "nw_it_trap010";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_ACID)
  {
   return "nw_it_trap016";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_ACID_SPLASH)
  {
   return "nw_it_trap036";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_ELECTRICAL)
  {
   return "nw_it_trap024";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_FIRE)
  {
   return "nw_it_trap020";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_FROST)
  {
   return "nw_it_trap032";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_GAS)
  {
   return "nw_it_trap028";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_HOLY)
  {
   return "nw_it_trap008";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_NEGATIVE)
  {
   return "nw_it_trap044";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_SONIC)
  {
   return "nw_it_trap040";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_SPIKE)
  {
   return "nw_it_trap004";
  }
  if(nTrapType==TRAP_BASE_TYPE_DEADLY_TANGLE)
  {
   return "nw_it_trap012";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_ACID)
  {
   return "nw_it_trap013";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_ACID_SPLASH)
  {
   return "nw_it_trap033";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_ELECTRICAL)
  {
   return "nw_it_trap021";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_FIRE)
  {
   return "nw_it_trap017";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_FROST)
  {
   return "nw_it_trap029";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_GAS)
  {
   return "nw_it_trap025";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_HOLY)
  {
   return "nw_it_trap005";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_NEGATIVE)
  {
   return "nw_it_trap041";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_SONIC)
  {
   return "nw_it_trap037";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_SPIKE)
  {
   return "nw_it_trap001";
  }
  if(nTrapType==TRAP_BASE_TYPE_MINOR_TANGLE)
  {
   return "nw_it_trap009";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_ACID)
  {
   return "nw_it_trap015";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_ACID_SPLASH)
  {
   return "nw_it_trap035";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_ELECTRICAL)
  {
   return "nw_it_trap023";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_FIRE)
  {
   return "nw_it_trap019";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_FROST)
  {
   return "nw_it_trap031";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_GAS)
  {
   return "nw_it_trap027";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_HOLY)
  {
   return "nw_it_trap007";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_NEGATIVE)
  {
   return "nw_it_trap043";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_SONIC)
  {
   return "nw_it_trap039";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_SPIKE)
  {
   return "nw_it_trap003";
  }
  if(nTrapType==TRAP_BASE_TYPE_STRONG_TANGLE)
  {
   return "nw_it_trap011";
  }

 return "OBJECT_INVALID";
}
