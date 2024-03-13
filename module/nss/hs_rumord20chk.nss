int StartingConditional()
{
    // increment the position in the possible conversations
    int temp = GetLocalInt(GetPCSpeaker(),"CURRENTRUMOR20");
    temp++;
    SetLocalInt(GetPCSpeaker(),"CURRENTRUMOR20",temp);

    // see if this is the rumor selected
    if(GetLocalInt(GetPCSpeaker(),"RUMORD20") == temp)
    {
        return TRUE;
    }
    else { return FALSE; }
}
