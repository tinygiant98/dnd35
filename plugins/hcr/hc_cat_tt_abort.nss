void main()
{
    object oPC = GetPCSpeaker();

    if (oPC != OBJECT_INVALID)
    {
        DeleteLocalObject(oPC, "oToolTarget");
        DeleteLocalInt(oPC, "nSkillMod");
        DestroyObject(GetObjectByTag("InvisDM"));
    }
}
