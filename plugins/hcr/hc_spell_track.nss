// 5.3 changed public cd key to player name
void main()
{
// SPELL TRACKING BEGIN
    if(GetSpellCastItem()==OBJECT_INVALID)
    {
        object oW=GetLastSpellCaster();
        if(oW==OBJECT_INVALID) oW=OBJECT_SELF;
        string sNm=GetName(oW);
        string sPC=GetPCPlayerName(oW);
        int nSp=GetSpellId();
        object oMd=GetModule();
        int nTm=GetLocalInt(oMd, "SPTRK"+sNm+sPC+IntToString(nSp));
        SetLocalInt(oMd,"SPTRK"+sNm+sPC+IntToString(nSp), (nTm+1));
    }
// END SPELL TRACKING
}
