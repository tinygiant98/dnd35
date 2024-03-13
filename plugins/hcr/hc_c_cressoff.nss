int StartingConditional()
{
    object oMod = GetModule();
    int iResult;
    if (GetLocalInt(oMod, "RESSPORT"))
        iResult = FALSE;
    else
        iResult = TRUE;
    return iResult;
}
