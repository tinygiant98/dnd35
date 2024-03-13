// hcr3

int StartingConditional()
{
    object oMod = GetModule();
    int iResult;
    if (!GetLocalInt(oMod, "RAISEPORT") &&
       !GetLocalInt(oMod, "RESSPORT") &&
       !GetLocalInt(oMod, "TRESSPORT"))
        iResult = TRUE;
    else
        iResult = FALSE;
    return iResult;
}
