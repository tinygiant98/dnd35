// sr5.2
void DecrementTalentIndex(int iIndex, object oPC);

void main()
{
    object oPC = OBJECT_SELF;
    int iIndex;

    for (iIndex = 1; iIndex < 1000; iIndex++)
    {
        DecrementTalentIndex(iIndex, oPC);
    }
}

void DecrementTalentIndex(int iIndex, object oPC)
{
    int iDecrementIndex;

    talent tSpell;

/* create our talent */
    tSpell = TalentSpell(iIndex);

/* check for all spells */
    if (GetIsTalentValid(tSpell))
    {
        if (GetHasSpell(GetIdFromTalent(tSpell), oPC))
        {
            for (iDecrementIndex = 1; iDecrementIndex < 20; iDecrementIndex++)
            {
                DecrementRemainingSpellUses(oPC, GetIdFromTalent(tSpell));
                if(!GetHasSpell(GetIdFromTalent(tSpell), oPC))
                    iDecrementIndex=20;
            }
        }
    }

}

