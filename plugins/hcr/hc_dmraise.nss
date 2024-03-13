// sr 5.5
// respawn code to use on a object or conversation in Fugue for alternate way to leave.
// good for solo games.

void main()
{
object oRespawner = GetPCSpeaker();
if (!GetIsObjectValid(oRespawner))
   oRespawner = GetLastUsedBy();
ExecuteScript("hc_do_raise", oRespawner);
}
