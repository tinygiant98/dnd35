const float VULC_HIDE_DECAY = 120.0;
const float VULC_MINE_SPAWN = 2880.0;

void DropCreatureHide()
{
    if(GetRacialType(OBJECT_SELF)==RACIAL_TYPE_ANIMAL)
    {
        int nApp = GetAppearanceType(OBJECT_SELF);
        int nHide;
        string sPelt = "vulc_skinable";
        object oPelt = CreateObject(OBJECT_TYPE_PLACEABLE,sPelt,
            GetLocation(OBJECT_SELF),FALSE);
        switch(nApp)
        {
            case APPEARANCE_TYPE_BADGER:nHide=1;break;
            case APPEARANCE_TYPE_BADGER_DIRE:nHide=2;break;
            case APPEARANCE_TYPE_BEAR_BLACK:
            case APPEARANCE_TYPE_BEAR_BROWN:nHide=4;break;
            case APPEARANCE_TYPE_BEAR_DIRE:nHide=8;break;
            case APPEARANCE_TYPE_BEAR_KODIAK:
            case APPEARANCE_TYPE_BEAR_POLAR:nHide=4;break;
            case APPEARANCE_TYPE_BOAR:nHide=2;break;
            case APPEARANCE_TYPE_BOAR_DIRE:
            case APPEARANCE_TYPE_CAT_CAT_DIRE:nHide=8;break;
            case APPEARANCE_TYPE_CAT_COUGAR:
            case APPEARANCE_TYPE_CAT_CRAG_CAT:
            case APPEARANCE_TYPE_CAT_JAGUAR:
            case APPEARANCE_TYPE_CAT_LEOPARD:nHide=2;break;
            case APPEARANCE_TYPE_CAT_LION:
            case APPEARANCE_TYPE_CAT_MPANTHER:nHide=4;break;
            case APPEARANCE_TYPE_CAT_PANTHER:
            case APPEARANCE_TYPE_DEER:nHide=2;break;
            case APPEARANCE_TYPE_DEER_STAG:nHide=4;break;
            case APPEARANCE_TYPE_DOG_DIRE_WOLF:nHide=8;break;
            case APPEARANCE_TYPE_DOG_WINTER_WOLF:
            case APPEARANCE_TYPE_DOG_WOLF:nHide=2;break;
            case APPEARANCE_TYPE_DOG_WORG:nHide=4;break;
            case APPEARANCE_TYPE_RAT_DIRE:nHide=1;break;
        }
        SetLocalInt(oPelt,"vulc_animal_hide",nHide);
        SetIsDestroyable(FALSE,FALSE,FALSE);
        DelayCommand(VULC_HIDE_DECAY, SetIsDestroyable(TRUE,FALSE,FALSE));
        DestroyObject(oPelt,60.1);
    }
}
void CheckToolBreakage(object oTool, object oPC)
{
    int nUses = GetLocalInt(oTool,"vulc_tool_uses");
    int nMW, nBroken;
    int nRoll = d20()+20;
    int nMWFound=0;
    string sMsg = "Your tools are in ";
    string sCond = "excellent";
    string sTag = GetTag(oTool);
    string sS = "";
    if(FindSubString(GetTag(oTool), "skin")>0  ||
       FindSubString(GetTag(oTool), "pick")>0)
    {
        sS = "s";
    }
    if(FindSubString(GetTag(oTool), "mw")>0)
    {
        nRoll += 60;
        nMWFound=TRUE;
    }
    else
    {
        sTag+="mw";
    }
    if(nUses>nRoll)
    {
        FloatingTextStringOnCreature("*Your "+GetName(oTool)+" break"+sS+"*",oPC,FALSE);
        DestroyObject(oTool);
        DeleteLocalObject(oPC,sTag);
        DeleteLocalInt(oPC,sTag);
        nBroken=TRUE;
    }
    nUses++;
    SetLocalInt(oTool, "vulc_tool_uses", nUses);
    if(nMWFound)
    {
        if(nUses>30){sCond = "good";}
        if(nUses>55){sCond = "used";}
        if(nUses>80){sCond = "worn";}
    }
    else
    {
        if(nUses>10){sCond = "good";}
        if(nUses>20){sCond = "used";}
        if(nUses>30){sCond = "worn";}
    }
    sMsg = sMsg + sCond+ " condition.";
    if(nBroken || oTool==OBJECT_INVALID)
    {
        return;
    }
    else
    {
        SendMessageToPC(oPC,sMsg);
    }
}
void CreatePelt(string sTemplate,object oObject)
{
    CreateItemOnObject(sTemplate,oObject,1);
}
void SetRockResRef(object oRock)
{
    string sRock;
    int nRock = d100();
    int nSub = d100();
    int nGem;
    if(nSub == 100 && nRock == 100)
    {
        if(d2()==1){sRock = "vulc_ore_adam";}
        else{sRock = "vulc_ore_mith";}
    }
    if(nRock<100)
    {
        if(nSub<=100)
        {
            sRock="vulcrgem6_";
            nGem = d10();
            if(nGem<10){sRock+="0";}
            sRock+=IntToString(nGem);
        }
        if(nSub<99)
        {
            sRock="vulcrgem5_";
            nGem = Random(17)+1;
            if(nGem<10){sRock+="0";}
            sRock+=IntToString(nGem);
        }
        if(nSub<97)
        {
            sRock="vulcrgem4_";
            nGem = d6();
            if(nGem<10){sRock+="0";}
            sRock+=IntToString(nGem);
        }
        if(nSub<95)
        {
            sRock="vulcrgem3_";
            nGem = Random(21)+1;
            if(nGem<10){sRock+="0";}
            sRock+=IntToString(nGem);
        }
        if(nSub<81)
        {
            sRock="vulcrgem2_";
            nGem = Random(26)+1;
            if(nGem<10){sRock+="0";}
            sRock+=IntToString(nGem);
        }
        if(nSub<61)
        {
            sRock="vulcrgem1_";
            nGem = Random(22)+1;
            if(nGem<10){sRock+="0";}
            sRock+=IntToString(nGem);
        }
    }
    if(nRock<91){sRock = "vulc_ore_plat";}
    if(nRock<89){sRock = "vulc_ore_gold";}
    if(nRock<84){sRock = "vulc_ore_silv";}
    if(nRock<74){sRock = "vulc_ore_iron";}
    if(nRock<34){sRock = "vulc_ore_null";}

    SetLocalString(oRock, "vulc_mineable_type", sRock);
}
void CreateMineableRock(string sRock, location lRock)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sRock, lRock);
    DestroyObject(OBJECT_SELF);
}
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
void Award_3E_XP(object oPC, object oDead)
{
    float fCR = GetChallengeRating(oDead);
    int nAvg,nTL,nParty,nAward,nCR;
    object oParty;
    oParty = GetFirstFactionMember(oPC, TRUE);
    while(GetIsObjectValid(oParty))
    {
        nParty++;
        nTL=nTL+GetHitDice(oParty)+GetLocalInt(oParty, "vulc_subrace_ecl");
        oParty = GetNextFactionMember(oPC, TRUE);
    }

    nAvg = nTL/nParty;
    nCR = FloatToInt(fCR);

    SendMessageToPC(oPC, "nAvg = "+IntToString(nAvg));
    SendMessageToPC(oPC, "nTL = "+IntToString(nTL));
    SendMessageToPC(oPC, "nParty = "+IntToString(nParty));
    SendMessageToPC(oPC, "nCR = "+IntToString(nCR));

    if(nCR==0){nCR=1;}
    switch(nCR)
    {
        case 0:case 1:
            switch(nAvg)
            {
                case 1:case 2:case 3:
                case 4:case 5:case 6:nAward=300;break;
                case 7:nAward=263;break;
                case 8:nAward=200;break;
            }
            break;
        case 2:
            switch(nAvg)
            {
                case 1:case 2:case 3:
                case 4:nAward=600;break;
                case 5:nAward=500;break;
                case 6:nAward=450;break;
                case 7:nAward=394;break;
                case 8:nAward=300;break;
                case 9:nAward=225;break;
            }
            break;
        case 3:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=900;break;
                case 4:nAward=800;break;
                case 5:nAward=750;break;
                case 6:nAward=600;break;
                case 7:nAward=525;break;
                case 8:nAward=450;break;
                case 9:nAward=338;break;
                case 10:nAward=250;break;
            }
            break;
        case 4:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=1350;break;
                case 4:nAward=1200;break;
                case 5:nAward=1000;break;
                case 6:nAward=900;break;
                case 7:nAward=700;break;
                case 8:nAward=600;break;
                case 9:nAward=506;break;
                case 10:nAward=375;break;
                case 11:nAward=275;break;
            }
            break;
        case 5:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=1800;break;
                case 4:nAward=1600;break;
                case 5:nAward=1500;break;
                case 6:nAward=1200;break;
                case 7:nAward=1050;break;
                case 8:nAward=800;break;
                case 9:nAward=675;break;
                case 10:nAward=563;break;
                case 11:nAward=413;break;
                case 12:nAward=300;break;
            }
            break;
        case 6:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=2700;break;
                case 4:nAward=2400;break;
                case 5:nAward=2250;break;
                case 6:nAward=1800;break;
                case 7:nAward=1400;break;
                case 8:nAward=1200;break;
                case 9:nAward=900;break;
                case 10:nAward=750;break;
                case 11:nAward=619;break;
                case 12:nAward=450;break;
                case 13:nAward=325;break;
            }
            break;
        case 7:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=3600;break;
                case 4:nAward=3200;break;
                case 5:nAward=3000;break;
                case 6:nAward=2700;break;
                case 7:nAward=2100;break;
                case 8:nAward=1600;break;
                case 9:nAward=1350;break;
                case 10:nAward=1000;break;
                case 11:nAward=825;break;
                case 12:nAward=675;break;
                case 13:nAward=488;break;
                case 14:nAward=350;break;
            }
            break;
        case 8:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=5400;break;
                case 4:nAward=4800;break;
                case 5:nAward=4500;break;
                case 6:nAward=3600;break;
                case 7:nAward=3150;break;
                case 8:nAward=2400;break;
                case 9:nAward=1800;break;
                case 10:nAward=1500;break;
                case 11:nAward=1100;break;
                case 12:nAward=900;break;
                case 13:nAward=731;break;
                case 14:nAward=525;break;
                case 15:nAward=375;break;
            }
            break;
        case 9:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=7200;break;
                case 4:nAward=6400;break;
                case 5:nAward=6000;break;
                case 6:nAward=5400;break;
                case 7:nAward=4200;break;
                case 8:nAward=3600;break;
                case 9:nAward=2700;break;
                case 10:nAward=2000;break;
                case 11:nAward=1650;break;
                case 12:nAward=1200;break;
                case 13:nAward=975;break;
                case 14:nAward=788;break;
                case 15:nAward=563;break;
                case 16:nAward=400;break;
            }
            break;
        case 10:
            switch(nAvg)
            {
                case 1:case 2:case 3:nAward=10800;break;
                case 4:nAward=9600;break;
                case 5:nAward=9000;break;
                case 6:nAward=7200;break;
                case 7:nAward=6300;break;
                case 8:nAward=4800;break;
                case 9:nAward=4050;break;
                case 10:nAward=3000;break;
                case 11:nAward=2200;break;
                case 12:nAward=1800;break;
                case 13:nAward=1300;break;
                case 14:nAward=1050;break;
                case 15:nAward=844;break;
                case 16:nAward=600;break;
                case 17:nAward=425;break;
            }
            break;
        case 11:
            switch(nAvg)
            {
                case 3:nAward=0;break;
                case 4:nAward=12800;break;
                case 5:nAward=12000;break;
                case 6:nAward=10800;break;
                case 7:nAward=8400;break;
                case 8:nAward=7200;break;
                case 9:nAward=5400;break;
                case 10:nAward=4500;break;
                case 11:nAward=3300;break;
                case 12:nAward=2400;break;
                case 13:nAward=1950;break;
                case 14:nAward=1400;break;
                case 15:nAward=1125;break;
                case 16:nAward=900;break;
                case 17:nAward=638;break;
                case 18:nAward=450;break;
            }
            break;
        case 12:
            switch(nAvg)
            {
                case 4:nAward=0;break;
                case 5:nAward=18000;break;
                case 6:nAward=14400;break;
                case 7:nAward=12600;break;
                case 8:nAward=9600;break;
                case 9:nAward=8100;break;
                case 10:nAward=6000;break;
                case 11:nAward=4950;break;
                case 12:nAward=3600;break;
                case 13:nAward=2600;break;
                case 14:nAward=2100;break;
                case 15:nAward=1500;break;
                case 16:nAward=1200;break;
                case 17:nAward=956;break;
                case 18:nAward=675;break;
                case 19:nAward=475;break;
            }
            break;
        case 13:
            switch(nAvg)
            {
                case 5:nAward=0;break;
                case 6:nAward=21600;break;
                case 7:nAward=16800;break;
                case 8:nAward=14400;break;
                case 9:nAward=10800;break;
                case 10:nAward=9000;break;
                case 11:nAward=6600;break;
                case 12:nAward=5400;break;
                case 13:nAward=3900;break;
                case 14:nAward=2800;break;
                case 15:nAward=2250;break;
                case 16:nAward=1600;break;
                case 17:nAward=1275;break;
                case 18:nAward=1013;break;
                case 19:nAward=713;break;
                case 20:nAward=500;break;
            }
            break;
        case 14:
            switch(nAvg)
            {
                case 6:nAward=0;break;
                case 7:nAward=25200;break;
                case 8:nAward=19200;break;
                case 9:nAward=16200;break;
                case 10:nAward=12000;break;
                case 11:nAward=9900;break;
                case 12:nAward=7200;break;
                case 13:nAward=5850;break;
                case 14:nAward=4200;break;
                case 15:nAward=3000;break;
                case 16:nAward=2400;break;
                case 17:nAward=1700;break;
                case 18:nAward=1350;break;
                case 19:nAward=1069;break;
                case 20:nAward=750;break;
            }
            break;
        case 15:
            switch(nAvg)
            {
                case 7:nAward=0;break;
                case 8:nAward=28800;break;
                case 9:nAward=21600;break;
                case 10:nAward=18000;break;
                case 11:nAward=13200;break;
                case 12:nAward=10800;break;
                case 13:nAward=7800;break;
                case 14:nAward=6300;break;
                case 15:nAward=4500;break;
                case 16:nAward=3200;break;
                case 17:nAward=2550;break;
                case 18:nAward=1800;break;
                case 19:nAward=1425;break;
                case 20:nAward=1000;break;
            }
            break;
        case 16:
            switch(nAvg)
            {
                case 8:nAward=0;break;
                case 9:nAward=32400;break;
                case 10:nAward=24000;break;
                case 11:nAward=19800;break;
                case 12:nAward=14400;break;
                case 13:nAward=11700;break;
                case 14:nAward=8400;break;
                case 15:nAward=6750;break;
                case 16:nAward=4800;break;
                case 17:nAward=3400;break;
                case 18:nAward=2700;break;
                case 19:nAward=1900;break;
                case 20:nAward=1500;break;
            }
            break;
        case 17:
            switch(nAvg)
            {
                case 9:nAward=0;break;
                case 10:nAward=36000;break;
                case 11:nAward=26400;break;
                case 12:nAward=21600;break;
                case 13:nAward=15600;break;
                case 14:nAward=12600;break;
                case 15:nAward=9000;break;
                case 16:nAward=7200;break;
                case 17:nAward=5100;break;
                case 18:nAward=3600;break;
                case 19:nAward=2850;break;
                case 20:nAward=2000;break;
            }
            break;
        case 18:
            switch(nAvg)
            {
                case 10:nAward=0;break;
                case 11:nAward=39600;break;
                case 12:nAward=28800;break;
                case 13:nAward=23400;break;
                case 14:nAward=16800;break;
                case 15:nAward=13500;break;
                case 16:nAward=9600;break;
                case 17:nAward=7650;break;
                case 18:nAward=5400;break;
                case 19:nAward=3800;break;
                case 20:nAward=3000;break;
            }
            break;
        case 19:
            switch(nAvg)
            {
                case 11:nAward=0;break;
                case 12:nAward=43200;break;
                case 13:nAward=31200;break;
                case 14:nAward=25200;break;
                case 15:nAward=18000;break;
                case 16:nAward=14400;break;
                case 17:nAward=10200;break;
                case 18:nAward=8100;break;
                case 19:nAward=5700;break;
                case 20:nAward=4000;break;
            }
            break;
        case 20:
            switch(nAvg)
            {
                case 12:nAward=0;break;
                case 13:nAward=46800;break;
                case 14:nAward=33600;break;
                case 15:nAward=27000;break;
                case 16:nAward=19200;break;
                case 17:nAward=15300;break;
                case 18:nAward=10800;break;
                case 19:nAward=8550;break;
                case 20:nAward=6000;break;
            }
            break;
    }
    if(fCR < 0.76 && nAward)
        {
            if (fCR <= 0.11)
                nAward = nAward / 10;
            else if (fCR <= 0.13)
                nAward = nAward / 8;
            else if (fCR <= 0.18)
                nAward = nAward / 6;
            else if (fCR <= 0.28)
                nAward = nAward / 4;
            else if (fCR <= 0.4)
                nAward = nAward / 3;
            else if (fCR <= 0.76)
                nAward = nAward /2;
            if (nAward == 0) nAward = 1;
        }
    //ok, here we make it so CR is always divided by at least 4.
    if(nParty<4){nParty=4;}
    nAward = nAward/nParty;
    oParty = GetFirstFactionMember(oPC, TRUE);
    while(GetIsObjectValid(oParty))
    {
        GiveXPToCreature(oPC, nAward);
        oParty = GetNextFactionMember(oPC, TRUE);
    }
}
