/////////////////////////////////////////////////////////
//
//  Oxen Trade Routes (OTR) by Festyx
//
//  Name:  otr_module_oml
//
//  Desc:  This script must be run by the module's
//         OnModuleLoad event handler.
//
//  Author: David Bobeck 12Sep03
//
/////////////////////////////////////////////////////////

void main()
{
  PrintString("Launching otr_route_init");
  ExecuteScript("otr_route_init", OBJECT_SELF);
}
