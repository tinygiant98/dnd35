int StartingConditional()
{
    // This sets the number of the rumor that the PC will hear
    SetLocalInt(GetPCSpeaker(),"RUMORD20",d20());
    // This is the current number of the conversation...
    SetLocalInt(GetPCSpeaker(),"CURRENTRUMOR20",1);
    // now check if it is this line
    if(GetLocalInt(GetPCSpeaker(),"RUMORD20") == GetLocalInt(GetPCSpeaker(),"CURRENTRUMOR20"))
    {
        return TRUE;
    } // end if
    else { return FALSE; }
}
