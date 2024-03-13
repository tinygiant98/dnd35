void main()
{
object oPC = GetLastOpenedBy();

DelayCommand(60.0, ActionCloseDoor(OBJECT_SELF));
}
