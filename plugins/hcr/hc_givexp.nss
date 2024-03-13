// hcr3.1
// took out old sei xp code.
// 5.5
// This script is executed by a calling script that gives experience
// for use with level trainers. You need to set a local int "XPGAIN"
// for the pc before you call this script with the amount of xp to award.


// this is a good example of how to give xp for quest etc. using level trainers

void main()
{
object oMod = GetModule();
object oPC = OBJECT_SELF;
int nCharXP = GetLocalInt(OBJECT_SELF, "XPGAIN");
DeleteLocalInt(OBJECT_SELF, "XPGAIN");
int nCurLvl=GetHitDice(oPC);
int nExpPen=GetLocalInt(GetModule(),"REZPEN"+GetName(oPC)+
    GetPCPlayerName(oPC));
if(!GetLocalInt(oMod,"LEVELTRAINER"))
            {
                GiveXPToCreature(oPC, nCharXP);
            }
else if(nExpPen)
            {
             if(nCharXP > nExpPen)
                {
                    SendMessageToPC(oPC,"You have paid off your exp penalty.");
                    DeleteLocalInt(GetModule(),"REZPEN"+GetName(oPC)+
                        GetPCPlayerName(oPC));
                }
             SetLocalInt(GetModule(),"REZPEN"+GetName(oPC)+
             GetPCPlayerName(oPC),nExpPen-nCharXP);
            }
else if( (GetXP(oPC)+nCharXP) >
         ((((nCurLvl+1) * nCurLvl) / 2 * 1000)-1))
            {
             int nXp =(((nCurLvl+1) * nCurLvl) / 2 * 1000)-1;
             if (nXp <= GetXP(oPC))
                   SendMessageToPC(oPC,"You learn nothing, perhaps "+
                      "you should seek out training.");
             else
                {
                   SetXP(oPC, (((nCurLvl+1) * nCurLvl) / 2 * 1000)-1);
                   SendMessageToPC(oPC,"You learn little, perhaps "+
                    "you should seek out training.");
               }
            }
else
     {
        GiveXPToCreature(oPC, nCharXP);
     }

}
