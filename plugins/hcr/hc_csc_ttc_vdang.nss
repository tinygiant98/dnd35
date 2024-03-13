//SR5.2
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetLocalObject(oPC, "oToolTarget");
    if (oTarget == OBJECT_INVALID) return FALSE;
    int iDC=GetTrapDisarmDC(oTarget);
    if(iDC>101)iDC=iDC-100;
    int nDisarmDiff = 10 + GetSkillRank(SKILL_DISABLE_TRAP, oPC) - iDC;

    if (nDisarmDiff <= -5) return TRUE;

    return FALSE;
}
