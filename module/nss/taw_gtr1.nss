int StartingConditional()
{
 string sCamp = GetLocalString(OBJECT_SELF, "Campaign");
 string sInt = GetLocalString(OBJECT_SELF, "Integer");
if(!(GetCampaignInt(sCamp, sInt, GetPCSpeaker()) >1))
return FALSE;
return TRUE;
}
