// hcr3

int StartingConditional()
{
    object oMod = GetModule();
    int iResult;
    if (!GetLocalInt(oMod, "TRESSPORT"))
        iResult = FALSE;
    else
        iResult = TRUE;
    return iResult;
}
