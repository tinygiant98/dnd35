// HCR v3.2.0 - Included formulas for epic level XP progression. - Thx CatScan.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  HC_Inc_Exp
//::////////////////////////////////////////////////////////////////////////////
/*

*/
//::////////////////////////////////////////////////////////////////////////////


// * FUNCTION PROTOTYPES


int UseXPTable(int nBaseExp, float fCR, int nLevel);


// * FUNCTION DEFINITIONS


//::////////////////////////////////////////////////////////////////////////////
int UseXPTable(int nBaseExp, float fCR, int nLevel)
{

   int nCR;
   int nExp;
   nCR = FloatToInt(fCR);
   float fPow;
   if (nCR > 40)
      fPow = (fCR - 39.0);
   if (nCR <= 1){
        if (nLevel >= 1 &&
            nLevel <= 6)
            nExp = nBaseExp;
        else if (nLevel == 7)
            nExp = FloatToInt(nBaseExp * 0.8767);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 0.6667);
        else nExp =  0;
      }
      else if (nCR == 2){
        if (nLevel >= 1 &&
            nLevel <= 4)
            nExp =  nBaseExp * 2;
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 1.6667);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 1.3134);
        else if (nLevel == 8)
            nExp =  nBaseExp;
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 0.75);
        else nExp =  0;
      }
      else if (nCR == 3){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 2.6667);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 2.5);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 2.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 1.75);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 1.1267);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 0.8334);
        else nExp =  0;
      }
      else if (nCR == 4){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 3.3334);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 2.3334);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 2.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 1.6867);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 1.25);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 0.9167);
        else nExp =  0;
      }
      else if (nCR == 5){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 5.3334);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 3.5);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 2.6667);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 2.25);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 1.8767);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 1.3767);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 1.0);
        else nExp =  0;
      }
      else if (nCR == 6){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 7.5);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 4.6667);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 2.5);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 2.0634);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 1.0834);
        else nExp =  0;
      }
      else if (nCR == 7){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 10.6667);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 7.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 5.3334);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 3.3334);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 2.75);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 2.25);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 1.6267);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 1.1667);
        else nExp =  0;
      }
      else if (nCR == 8){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 15.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 10.5);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 3.6667);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 2.4367);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 1.75);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 1.25);
        else nExp =  0;
      }
      else if (nCR == 9){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 21.3334);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 20.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 14.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 6.6667);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 5.5);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 3.25);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 2.6267);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 1.8767);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 1.3334);
        else nExp =  0;
      }
      else if (nCR == 10){
        if (nLevel >= 1 &&
            nLevel <= 3)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 4)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 21.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 13.5);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 7.3334);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 4.3334);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 3.5);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 2.8134);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 2.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 1.4167);
        else nExp =  0;
      }
      else if (nCR == 11){
        if (nLevel >= 1 &&
            nLevel <= 4)
            nExp =  FloatToInt(nBaseExp * 42.6667);
        else if (nLevel == 5)
            nExp =  FloatToInt(nBaseExp * 40.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 28.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 15.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 11.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 6.5);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 4.6667);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 3.75);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 2.1267);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 1.5);
        else nExp =  0;
      }
      else if (nCR == 12){
        if (nLevel >= 1 &&
            nLevel <= 5)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 6)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 42.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 27.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 20.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 16.5);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 8.6667);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 7.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 3.1867);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 2.25);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 1.5834);
        else nExp =  0;
      }
      else if (nCR == 13){
        if (nLevel >= 1 &&
            nLevel <= 6)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 7)
            nExp =  FloatToInt(nBaseExp * 56.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 22.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 13.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 9.3334);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 7.5);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 5.3334);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 4.25);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 3.3767);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 2.3767);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 1.6667);
        else nExp =  0;
      }
      else if (nCR == 14){
        if (nLevel >= 1 &&
            nLevel <= 7)
            nExp =  FloatToInt(nBaseExp * 84.0);
        else if (nLevel == 8)
            nExp =  FloatToInt(nBaseExp * 64.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 40.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 33.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 19.5);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 14.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 5.6667);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 3.5634);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 2.5);
        else if (nLevel == 21)
            nExp = FloatToInt(nBaseExp * 1.74);
        else nExp =  0;
      }
      else if (nCR == 15){
        if (nLevel >= 1 &&
            nLevel <= 8)
            nExp =  FloatToInt(nBaseExp * 96.0);
        else if (nLevel == 9)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 44.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 26.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 21.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 15.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 10.6667);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 8.5);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 4.75);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 3.3334);
        else if (nLevel == 21)
            nExp = FloatToInt(nBaseExp * 2.6267);
        else if (nLevel == 22)
            nExp = FloatToInt(nBaseExp * 1.8333);
        else nExp =  0;
      }
      else if (nCR == 16){
        if (nLevel >= 1 &&
            nLevel <= 9)
            nExp =  FloatToInt(nBaseExp * 108.0);
        else if (nLevel == 10)
            nExp =  FloatToInt(nBaseExp * 80.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 66.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 39.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 28.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 22.5);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 11.3334);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 6.3334);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 21)
            nExp = FloatToInt(nBaseExp * 3.5);
        else if (nLevel == 22)
            nExp = FloatToInt(nBaseExp * 2.75);
        else if (nLevel == 23)
            nExp = FloatToInt(nBaseExp * 1.1967);
        else nExp =  0;
      }
      else if (nCR == 17){
        if (nLevel >= 1 &&
            nLevel <= 10)
            nExp =  FloatToInt(nBaseExp * 120.0);
        else if (nLevel == 11)
            nExp =  FloatToInt(nBaseExp * 88.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 52.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 42.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 17.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 9.5);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 6.6667);
        else if (nLevel == 21)
            nExp = FloatToInt(nBaseExp * 5.25);
        else if (nLevel == 22)
            nExp = FloatToInt(nBaseExp * 3.6667);
        else if (nLevel == 23)
            nExp = FloatToInt(nBaseExp * 2.8767);
        else if (nLevel == 24)
            nExp = FloatToInt(nBaseExp * 2.0);
        else nExp =  0;
      }
      else if (nCR == 18){
        if (nLevel >= 1 &&
            nLevel <= 11)
            nExp =  FloatToInt(nBaseExp * 132.0);
        else if (nLevel == 12)
            nExp =  FloatToInt(nBaseExp * 96.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 78.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 45.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 25.5);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 12.6667);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 21)
            nExp = FloatToInt(nBaseExp * 7.0);
        else if (nLevel == 22)
            nExp = FloatToInt(nBaseExp * 5.5);
        else if (nLevel == 23)
            nExp = FloatToInt(nBaseExp * 3.8333);
        else if (nLevel == 24)
            nExp = FloatToInt(nBaseExp * 3.0);
        else if (nLevel == 25)
            nExp = FloatToInt(nBaseExp * 2.0833);
        else nExp =  0;
      }
      else if (nCR == 19){
        if (nLevel >= 1 &&
            nLevel <= 12)
            nExp =  FloatToInt(nBaseExp * 144.0);
        else if (nLevel == 13)
            nExp =  FloatToInt(nBaseExp * 104.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 84.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 34.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 27.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 19.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 13.3334);
        else if (nLevel == 21)
            nExp = FloatToInt(nBaseExp * 10.5);
        else if (nLevel == 22)
            nExp = FloatToInt(nBaseExp * 7.3333);
        else if (nLevel == 23)
            nExp = FloatToInt(nBaseExp * 5.75);
        else if (nLevel == 24)
            nExp = FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 25)
            nExp = FloatToInt(nBaseExp * 3.1267);
        else if (nLevel == 26)
            nExp = FloatToInt(nBaseExp * 2.1667);
        else nExp =  0;
      }
      else if (nCR == 20){
        if (nLevel >= 1 &&
            nLevel <= 13)
            nExp =  FloatToInt(nBaseExp * 156.0);
        else if (nLevel == 14)
            nExp =  FloatToInt(nBaseExp * 112.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 90.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 64.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 51.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 28.5);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 20.0);
        else if (nLevel == 21)
            nExp = FloatToInt(nBaseExp * 14.0);
        else if (nLevel == 22)
            nExp = FloatToInt(nBaseExp * 11.00);
        else if (nLevel == 23)
            nExp = FloatToInt(nBaseExp * 7.6667);
        else if (nLevel == 24)
            nExp = FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 25)
            nExp = FloatToInt(nBaseExp * 4.1667);
        else if (nLevel == 26)
            nExp = FloatToInt(nBaseExp * 3.25);
        else if (nLevel == 27)
            nExp = FloatToInt(nBaseExp * 2.25);
        else nExp =  0;
      }
      else if (nCR == 21){
        if (nLevel >= 1 &&
            nLevel <= 14)
            nExp =  FloatToInt(nBaseExp * 168.0);
        else if (nLevel == 15)
            nExp =  FloatToInt(nBaseExp * 120.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 96.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 68.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 54.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 38.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 21)
            nExp =  FloatToInt(nBaseExp * 21.0);
        else if (nLevel == 22)
            nExp = FloatToInt(nBaseExp * 14.6667);
        else if (nLevel == 23)
            nExp = FloatToInt(nBaseExp * 11.5);
        else if (nLevel == 24)
            nExp = FloatToInt(nBaseExp * 7.6667);
        else if (nLevel == 25)
            nExp = FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 26)
            nExp = FloatToInt(nBaseExp * 6.25);
        else if (nLevel == 27)
            nExp = FloatToInt(nBaseExp * 4.3333);
        else if (nLevel == 28)
            nExp = FloatToInt(nBaseExp * 3.3767);
        else nExp =  0;
      }
      else if (nCR == 22){
        if (nLevel >= 1 &&
            nLevel <= 15)
            nExp =  FloatToInt(nBaseExp * 180.0);
        else if (nLevel == 16)
            nExp =  FloatToInt(nBaseExp * 128.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 102.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 57.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 40.0);
        else if (nLevel == 21)
            nExp =  FloatToInt(nBaseExp * 28.0); // Discrepency between DMG and ELHB
        else if (nLevel == 22)
            nExp =  FloatToInt(nBaseExp * 22.0);
        else if (nLevel == 23)
            nExp = FloatToInt(nBaseExp * 15.3333);
        else if (nLevel == 24)
            nExp = FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 25)
            nExp = FloatToInt(nBaseExp * 8.3333);
        else if (nLevel == 26)
            nExp = FloatToInt(nBaseExp * 6.5);
        else if (nLevel == 27)
            nExp = FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 28)
            nExp = FloatToInt(nBaseExp * 3.5);
        else if (nLevel == 29)
            nExp = FloatToInt(nBaseExp * 2.4167);
        else nExp =  0;
      }
      else if (nCR == 23){
        if (nLevel >= 1 &&
            nLevel <= 16)
            nExp =  FloatToInt(nBaseExp * 192.0);
        else if (nLevel == 17)
            nExp =  FloatToInt(nBaseExp * 136.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 108.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 76.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 21)
            nExp =  FloatToInt(nBaseExp * 42.0);
        else if (nLevel == 22)
            nExp =  FloatToInt(nBaseExp * 29.3333);
        else if (nLevel == 23)
            nExp =  FloatToInt(nBaseExp * 23.0);
        else if (nLevel == 24)
            nExp = FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 25)
            nExp = FloatToInt(nBaseExp * 12.5);
        else if (nLevel == 26)
            nExp = FloatToInt(nBaseExp * 8.6667);
        else if (nLevel == 27)
            nExp = FloatToInt(nBaseExp * 6.75);
        else if (nLevel == 28)
            nExp = FloatToInt(nBaseExp * 4.6667);
        else if (nLevel == 29)
            nExp = FloatToInt(nBaseExp * 3.6267);
        else if (nLevel == 30)
            nExp = FloatToInt(nBaseExp * 2.5);
        else nExp =  0;
      }
      else if (nCR == 24){
        if (nLevel >= 1 &&
            nLevel <= 17)
            nExp =  FloatToInt(nBaseExp * 204.0);
        else if (nLevel == 18)
            nExp =  FloatToInt(nBaseExp * 144.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 114.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 80.0);
        else if (nLevel == 21)
            nExp =  FloatToInt(nBaseExp * 56.0);  // Discrepency between DMG and ELHB
        else if (nLevel == 22)
            nExp =  FloatToInt(nBaseExp * 44.0);
        else if (nLevel == 23)
            nExp =  FloatToInt(nBaseExp * 30.6667);
        else if (nLevel == 24)
            nExp =  FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 25)
            nExp = FloatToInt(nBaseExp * 16.6667);
        else if (nLevel == 26)
            nExp = FloatToInt(nBaseExp * 13.0);
        else if (nLevel == 27)
            nExp = FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 28)
            nExp = FloatToInt(nBaseExp * 7.0);
        else if (nLevel == 29)
            nExp = FloatToInt(nBaseExp * 4.8333);
        else if (nLevel == 30)
            nExp = FloatToInt(nBaseExp * 3.75);
        else if (nLevel == 31)
            nExp = FloatToInt(nBaseExp * 2.5833);
        else nExp =  0;
      }
      else if (nCR == 25){
        if (nLevel >= 1 &&
            nLevel <= 18)
            nExp =  FloatToInt(nBaseExp * 216.0);
        else if (nLevel == 19)
            nExp =  FloatToInt(nBaseExp * 152.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 120.0);
        else if (nLevel == 21)
            nExp =  FloatToInt(nBaseExp * 84.0);
        else if (nLevel == 22)
            nExp =  FloatToInt(nBaseExp * 58.6667);
        else if (nLevel == 23)
            nExp =  FloatToInt(nBaseExp * 46.0);
        else if (nLevel == 24)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 25)
            nExp =  FloatToInt(nBaseExp * 25.0);
        else if (nLevel == 26)
            nExp = FloatToInt(nBaseExp * 17.3333);
        else if (nLevel == 27)
            nExp = FloatToInt(nBaseExp * 13.5);
        else if (nLevel == 28)
            nExp = FloatToInt(nBaseExp * 9.3333);
        else if (nLevel == 29)
            nExp = FloatToInt(nBaseExp * 7.25);
        else if (nLevel == 30)
            nExp = FloatToInt(nBaseExp * 5.0);
        else if (nLevel == 31)
            nExp = FloatToInt(nBaseExp * 3.8767);
        else if (nLevel == 32)
            nExp = FloatToInt(nBaseExp * 2.6667);
        else nExp =  0;
      }
      else if (nCR == 26){
        if (nLevel >= 1 &&
            nLevel <= 19)
            nExp =  FloatToInt(nBaseExp * 228.0);
        else if (nLevel == 20)
            nExp =  FloatToInt(nBaseExp * 160.0);
        else if (nLevel == 21)
            nExp =  FloatToInt(nBaseExp * 112.0);  // Discrepency between DMG and ELHB
        else if (nLevel == 22)
            nExp =  FloatToInt(nBaseExp * 88.0);
        else if (nLevel == 23)
            nExp =  FloatToInt(nBaseExp * 61.3333);
        else if (nLevel == 24)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 25)
            nExp =  FloatToInt(nBaseExp * 33.3333);
        else if (nLevel == 26)
            nExp =  FloatToInt(nBaseExp * 26.0);
        else if (nLevel == 27)
            nExp = FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 28)
            nExp = FloatToInt(nBaseExp * 14.0);
        else if (nLevel == 29)
            nExp = FloatToInt(nBaseExp * 9.6667);
        else if (nLevel == 30)
            nExp = FloatToInt(nBaseExp * 7.5);
        else if (nLevel == 31)
            nExp = FloatToInt(nBaseExp * 5.1667);
        else if (nLevel == 32)
            nExp = FloatToInt(nBaseExp * 4.0);
        else if (nLevel == 33)
            nExp = FloatToInt(nBaseExp * 2.75);
        else nExp =  0;
      }
      else if (nCR == 27){
        if (nLevel >= 1 &&
            nLevel <= 20)
            nExp =  FloatToInt(nBaseExp * 240.0);
        else if (nLevel == 21)
            nExp =  FloatToInt(nBaseExp * 168.0);
        else if (nLevel == 22)
            nExp =  FloatToInt(nBaseExp * 117.3333);
        else if (nLevel == 23)
            nExp =  FloatToInt(nBaseExp * 92.0);
        else if (nLevel == 24)
            nExp =  FloatToInt(nBaseExp * 64.0);
        else if (nLevel == 25)
            nExp =  FloatToInt(nBaseExp * 50.0);
        else if (nLevel == 26)
            nExp =  FloatToInt(nBaseExp * 34.6667);
        else if (nLevel == 27)
            nExp =  FloatToInt(nBaseExp * 27.0);
        else if (nLevel == 28)
            nExp = FloatToInt(nBaseExp * 18.6667);
        else if (nLevel == 29)
            nExp = FloatToInt(nBaseExp * 14.5);
        else if (nLevel == 30)
            nExp = FloatToInt(nBaseExp * 10.0);
        else if (nLevel == 31)
            nExp = FloatToInt(nBaseExp * 7.75);
        else if (nLevel == 32)
            nExp = FloatToInt(nBaseExp * 5.3333);
        else if (nLevel == 33)
            nExp = FloatToInt(nBaseExp * 4.1267);
        else if (nLevel == 34)
            nExp = FloatToInt(nBaseExp * 2.8333);
        else nExp =  0;
      }
      else if (nCR == 28){
        if (nLevel >= 1 &&
            nLevel <= 21)
            nExp =  FloatToInt(nBaseExp * 224.0);   // Discrepency between DMG and ELHB
        else if (nLevel == 22)
            nExp =  FloatToInt(nBaseExp * 176.0);
        else if (nLevel == 23)
            nExp =  FloatToInt(nBaseExp * 122.6667);
        else if (nLevel == 24)
            nExp =  FloatToInt(nBaseExp * 96.0);
        else if (nLevel == 25)
            nExp =  FloatToInt(nBaseExp * 66.6667);
        else if (nLevel == 26)
            nExp =  FloatToInt(nBaseExp * 52.0);
        else if (nLevel == 27)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 28)
            nExp =  FloatToInt(nBaseExp * 28.0);
        else if (nLevel == 29)
            nExp = FloatToInt(nBaseExp * 19.3333);
        else if (nLevel == 30)
            nExp = FloatToInt(nBaseExp * 15.0);
        else if (nLevel == 31)
            nExp = FloatToInt(nBaseExp * 10.3333);
        else if (nLevel == 32)
            nExp = FloatToInt(nBaseExp * 8.0);
        else if (nLevel == 33)
            nExp = FloatToInt(nBaseExp * 5.5);
        else if (nLevel == 34)
            nExp = FloatToInt(nBaseExp * 4.25);
        else if (nLevel == 35)
            nExp = FloatToInt(nBaseExp * 2.9167);
        else nExp =  0;
      }
      else if (nCR == 29){
        if (nLevel >= 1 &&
            nLevel <= 22)
            nExp =  FloatToInt(nBaseExp * 234.6667);
        else if (nLevel == 23)
            nExp =  FloatToInt(nBaseExp * 184.0);
        else if (nLevel == 24)
            nExp =  FloatToInt(nBaseExp * 128.0);
        else if (nLevel == 25)
            nExp =  FloatToInt(nBaseExp * 100.0);
        else if (nLevel == 26)
            nExp =  FloatToInt(nBaseExp * 69.3333);
        else if (nLevel == 27)
            nExp =  FloatToInt(nBaseExp * 54.0);
        else if (nLevel == 28)
            nExp =  FloatToInt(nBaseExp * 37.3333);
        else if (nLevel == 29)
            nExp =  FloatToInt(nBaseExp * 29.0);
        else if (nLevel == 30)
            nExp = FloatToInt(nBaseExp * 20.0);
        else if (nLevel == 31)
            nExp = FloatToInt(nBaseExp * 15.5);
        else if (nLevel == 32)
            nExp = FloatToInt(nBaseExp * 10.6667);
        else if (nLevel == 33)
            nExp = FloatToInt(nBaseExp * 8.25);
        else if (nLevel == 34)
            nExp = FloatToInt(nBaseExp * 5.6667);
        else if (nLevel == 35)
            nExp = FloatToInt(nBaseExp * 3.3767);
        else if (nLevel == 36)
            nExp = FloatToInt(nBaseExp * 3.0);
        else nExp =  0;
      }
      else if (nCR == 30){
        if (nLevel >= 1 &&
            nLevel <= 23)
            nExp =  FloatToInt(nBaseExp * 245.3333);
        else if (nLevel == 24)
            nExp =  FloatToInt(nBaseExp * 192.0);
        else if (nLevel == 25)
            nExp =  FloatToInt(nBaseExp * 133.3333);
        else if (nLevel == 26)
            nExp =  FloatToInt(nBaseExp * 104.0);
        else if (nLevel == 27)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 28)
            nExp =  FloatToInt(nBaseExp * 56.0);
        else if (nLevel == 29)
            nExp =  FloatToInt(nBaseExp * 38.6667);
        else if (nLevel == 30)
            nExp =  FloatToInt(nBaseExp * 30.0);
        else if (nLevel == 31)
            nExp = FloatToInt(nBaseExp * 20.6667);
        else if (nLevel == 32)
            nExp = FloatToInt(nBaseExp * 16.0);
        else if (nLevel == 33)
            nExp = FloatToInt(nBaseExp * 11.0);
        else if (nLevel == 34)
            nExp = FloatToInt(nBaseExp * 8.5);
        else if (nLevel == 35)
            nExp = FloatToInt(nBaseExp * 5.8333);
        else if (nLevel == 36)
            nExp = FloatToInt(nBaseExp * 4.5);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 3.0833);
        else nExp =  0;
      }
      else if (nCR == 31){
        if (nLevel >= 1 &&
            nLevel <= 24)
            nExp =  FloatToInt(nBaseExp * 256.00);
        else if (nLevel == 25)
            nExp =  FloatToInt(nBaseExp * 200.0);
        else if (nLevel == 26)
            nExp =  FloatToInt(nBaseExp * 138.6667);
        else if (nLevel == 27)
            nExp =  FloatToInt(nBaseExp * 108.0);
        else if (nLevel == 28)
            nExp =  FloatToInt(nBaseExp * 74.6667);
        else if (nLevel == 29)
            nExp =  FloatToInt(nBaseExp * 58.0);
        else if (nLevel == 30)
            nExp =  FloatToInt(nBaseExp * 40.0);
        else if (nLevel == 31)
            nExp =  FloatToInt(nBaseExp * 31.0);
        else if (nLevel == 32)
            nExp = FloatToInt(nBaseExp * 21.3333);
        else if (nLevel == 33)
            nExp = FloatToInt(nBaseExp * 16.5);
        else if (nLevel == 34)
            nExp = FloatToInt(nBaseExp * 11.3333);
        else if (nLevel == 35)
            nExp = FloatToInt(nBaseExp * 8.75);
        else if (nLevel == 36)
            nExp = FloatToInt(nBaseExp * 6.0);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 4.6267);
        else if (nLevel == 38)
            nExp = FloatToInt(nBaseExp * 3.1667);
        else nExp =  0;
      }
      else if (nCR == 32){
        if (nLevel >= 1 &&
            nLevel <= 25)
            nExp =  FloatToInt(nBaseExp * 266.6667);
        else if (nLevel == 26)
            nExp =  FloatToInt(nBaseExp * 208.0);
        else if (nLevel == 27)
            nExp =  FloatToInt(nBaseExp * 144.0);
        else if (nLevel == 28)
            nExp =  FloatToInt(nBaseExp * 112.0);
        else if (nLevel == 29)
            nExp =  FloatToInt(nBaseExp * 77.3333);
        else if (nLevel == 30)
            nExp =  FloatToInt(nBaseExp * 60.0);
        else if (nLevel == 31)
            nExp =  FloatToInt(nBaseExp * 41.3333);
        else if (nLevel == 32)
            nExp =  FloatToInt(nBaseExp * 32.0);
        else if (nLevel == 33)
            nExp = FloatToInt(nBaseExp * 22.0);
        else if (nLevel == 34)
            nExp = FloatToInt(nBaseExp * 17.0);
        else if (nLevel == 35)
            nExp = FloatToInt(nBaseExp * 11.6667);
        else if (nLevel == 36)
            nExp = FloatToInt(nBaseExp * 9.0);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 6.1667);
        else if (nLevel == 38)
            nExp = FloatToInt(nBaseExp * 4.75);
        else if (nLevel == 39)
            nExp = FloatToInt(nBaseExp * 3.25);
        else nExp =  0;
      }
      else if (nCR == 33){
        if (nLevel >= 1 &&
            nLevel <= 26)
            nExp =  FloatToInt(nBaseExp * 273.3333);
        else if (nLevel == 27)
            nExp =  FloatToInt(nBaseExp * 216.0);
        else if (nLevel == 28)
            nExp =  FloatToInt(nBaseExp * 149.3333);
        else if (nLevel == 29)
            nExp =  FloatToInt(nBaseExp * 116.0);
        else if (nLevel == 30)
            nExp =  FloatToInt(nBaseExp * 80.0);
        else if (nLevel == 31)
            nExp =  FloatToInt(nBaseExp * 62.0);
        else if (nLevel == 32)
            nExp =  FloatToInt(nBaseExp * 42.6667);
        else if (nLevel == 33)
            nExp =  FloatToInt(nBaseExp * 33.0);
        else if (nLevel == 34)
            nExp = FloatToInt(nBaseExp * 22.6667);
        else if (nLevel == 35)
            nExp = FloatToInt(nBaseExp * 17.5);
        else if (nLevel == 36)
            nExp = FloatToInt(nBaseExp * 12.0);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 9.25);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 6.3333);
        else if (nLevel == 38)
            nExp = FloatToInt(nBaseExp * 4.8767);
        else if (nLevel == 40)
            nExp = FloatToInt(nBaseExp * 3.3333);
        else nExp =  0;
      }
      else if (nCR == 34){
        if (nLevel >= 1 &&
            nLevel <= 27)
            nExp =  FloatToInt(nBaseExp * 288.0);
        else if (nLevel == 28)
            nExp =  FloatToInt(nBaseExp * 224.0);
        else if (nLevel == 29)
            nExp =  FloatToInt(nBaseExp * 154.66667);
        else if (nLevel == 30)
            nExp =  FloatToInt(nBaseExp * 120.0);
        else if (nLevel == 31)
            nExp =  FloatToInt(nBaseExp * 82.6667);
        else if (nLevel == 32)
            nExp =  FloatToInt(nBaseExp * 64.0);
        else if (nLevel == 33)
            nExp =  FloatToInt(nBaseExp * 44.0);
        else if (nLevel == 34)
            nExp =  FloatToInt(nBaseExp * 34.0);
        else if (nLevel == 35)
            nExp = FloatToInt(nBaseExp * 23.3333);
        else if (nLevel == 36)
            nExp = FloatToInt(nBaseExp * 18.0);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 12.3333);
        else if (nLevel == 38)
            nExp = FloatToInt(nBaseExp * 9.5);
        else if (nLevel == 39)
            nExp = FloatToInt(nBaseExp * 6.5);
        else if (nLevel == 40)
            nExp = FloatToInt(nBaseExp * 5.0);

        else nExp =  0;
      }
      else if (nCR == 35){
        if (nLevel >= 1 &&
            nLevel <= 28)
            nExp =  FloatToInt(nBaseExp * 298.6667);
        else if (nLevel == 29)
            nExp =  FloatToInt(nBaseExp * 232.0);
        else if (nLevel == 30)
            nExp =  FloatToInt(nBaseExp * 160.0);
        else if (nLevel == 31)
            nExp =  FloatToInt(nBaseExp * 124.0);
        else if (nLevel == 32)
            nExp =  FloatToInt(nBaseExp * 85.333);
        else if (nLevel == 33)
            nExp =  FloatToInt(nBaseExp * 66.0);
        else if (nLevel == 34)
            nExp =  FloatToInt(nBaseExp * 45.3333);
        else if (nLevel == 35)
            nExp =  FloatToInt(nBaseExp * 35.0);
        else if (nLevel == 36)
            nExp = FloatToInt(nBaseExp * 24.0);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 18.5);
        else if (nLevel == 38)
            nExp = FloatToInt(nBaseExp * 12.6667);
        else if (nLevel == 39)
            nExp = FloatToInt(nBaseExp * 9.75);
        else if (nLevel == 40)
            nExp = FloatToInt(nBaseExp * 6.6667);
        else nExp =  0;
      }
      else if (nCR == 36){
        if (nLevel >= 1 &&
            nLevel <= 29)
            nExp =  FloatToInt(nBaseExp * 309.3333);
        else if (nLevel == 30)
            nExp =  FloatToInt(nBaseExp * 240.0);
        else if (nLevel == 31)
            nExp =  FloatToInt(nBaseExp * 165.3333);
        else if (nLevel == 32)
            nExp =  FloatToInt(nBaseExp * 128.0);
        else if (nLevel == 33)
            nExp =  FloatToInt(nBaseExp * 88.0);
        else if (nLevel == 34)
            nExp =  FloatToInt(nBaseExp * 68.0);
        else if (nLevel == 35)
            nExp =  FloatToInt(nBaseExp * 46.6667);
        else if (nLevel == 36)
            nExp =  FloatToInt(nBaseExp * 36.0);
        else if (nLevel == 37)
            nExp = FloatToInt(nBaseExp * 24.6667);
        else if (nLevel == 38)
            nExp = FloatToInt(nBaseExp * 19.0);
        else if (nLevel == 39)
            nExp = FloatToInt(nBaseExp * 13.0);
        else if (nLevel == 40)
            nExp = FloatToInt(nBaseExp * 10.0);
        else nExp =  0;
      }
      else if (nCR == 37){
        if (nLevel >= 1 &&
            nLevel <= 30)
            nExp =  FloatToInt(nBaseExp * 320.0);
        else if (nLevel == 31)
            nExp =  FloatToInt(nBaseExp * 248.0);
        else if (nLevel == 32)
            nExp =  FloatToInt(nBaseExp * 170.6667);
        else if (nLevel == 33)
            nExp =  FloatToInt(nBaseExp * 132.0);
        else if (nLevel == 34)
            nExp =  FloatToInt(nBaseExp * 90.6667);
        else if (nLevel == 35)
            nExp =  FloatToInt(nBaseExp * 70.0);
        else if (nLevel == 36)
            nExp =  FloatToInt(nBaseExp * 48.0);
        else if (nLevel == 37)
            nExp =  FloatToInt(nBaseExp * 37.0);
        else if (nLevel == 38)
            nExp = FloatToInt(nBaseExp * 25.3333);
        else if (nLevel == 39)
            nExp = FloatToInt(nBaseExp * 19.5);
        else if (nLevel == 40)
            nExp = FloatToInt(nBaseExp * 13.3333);
        else nExp =  0;
      }
      else if (nCR == 38){
        if (nLevel >= 1 &&
            nLevel <= 31)
            nExp =  FloatToInt(nBaseExp * 330.6667);
        else if (nLevel == 32)
            nExp =  FloatToInt(nBaseExp * 256.0);
        else if (nLevel == 33)
            nExp =  FloatToInt(nBaseExp * 176.0);
        else if (nLevel == 34)
            nExp =  FloatToInt(nBaseExp * 136.0);
        else if (nLevel == 35)
            nExp =  FloatToInt(nBaseExp * 93.3333);
        else if (nLevel == 36)
            nExp =  FloatToInt(nBaseExp * 72.0);
        else if (nLevel == 37)
            nExp =  FloatToInt(nBaseExp * 49.3333);
        else if (nLevel == 38)
            nExp =  FloatToInt(nBaseExp * 38.0);
        else if (nLevel == 39)
            nExp = FloatToInt(nBaseExp * 26.0);
        else if (nLevel == 40)
            nExp = FloatToInt(nBaseExp * 20.0);

        else nExp =  0;
      }
      else if (nCR == 39){
        if (nLevel >= 1 &&
            nLevel <= 32)
            nExp =  FloatToInt(nBaseExp * 341.3333);
        else if (nLevel == 33)
            nExp =  FloatToInt(nBaseExp * 264.0);
        else if (nLevel == 34)
            nExp =  FloatToInt(nBaseExp * 181.3333);
        else if (nLevel == 35)
            nExp =  FloatToInt(nBaseExp * 140.0);
        else if (nLevel == 36)
            nExp =  FloatToInt(nBaseExp * 96.0);
        else if (nLevel == 37)
            nExp =  FloatToInt(nBaseExp * 74.0);
        else if (nLevel == 38)
            nExp =  FloatToInt(nBaseExp * 50.6667);
        else if (nLevel == 39)
            nExp =  FloatToInt(nBaseExp * 39.0);
        else if (nLevel == 40)
            nExp = FloatToInt(nBaseExp * 26.6667);


        else nExp =  0;
      }
      else if (nCR == 40){
        if (nLevel >= 1 &&
            nLevel <= 33)
            nExp =  FloatToInt(nBaseExp * 352.0);
        else if (nLevel == 34)
            nExp =  FloatToInt(nBaseExp * 272.0);
        else if (nLevel == 35)
            nExp =  FloatToInt(nBaseExp * 186.6667);
        else if (nLevel == 36)
            nExp =  FloatToInt(nBaseExp * 144.0);
        else if (nLevel == 37)
            nExp =  FloatToInt(nBaseExp * 98.6667);
        else if (nLevel == 38)
            nExp =  FloatToInt(nBaseExp * 76.0);
        else if (nLevel == 39)
            nExp =  FloatToInt(nBaseExp * 52.0);
        else if (nLevel == 40)
            nExp =  FloatToInt(nBaseExp * 40.0);


        else nExp =  0;
      }


      else if (nCR > 40 && IntToFloat(nCR)/2.0 != IntToFloat(nCR/2)){
     if (nLevel >= 1 &&
            nLevel <= 32)
            nExp =  FloatToInt((nBaseExp * 341.3333) * fPow);
        else if (nLevel == 33)
            nExp =  FloatToInt((nBaseExp * 264.0) * fPow);
        else if (nLevel == 34)
            nExp =  FloatToInt((nBaseExp * 181.3333) * fPow);
        else if (nLevel == 35)
            nExp =  FloatToInt((nBaseExp * 140.0) * fPow);
        else if (nLevel == 36)
            nExp =  FloatToInt((nBaseExp * 96.0) * fPow);
        else if (nLevel == 37)
            nExp =  FloatToInt((nBaseExp * 74.0) * fPow);
        else if (nLevel == 38)
            nExp =  FloatToInt((nBaseExp * 50.6667) * fPow);
        else if (nLevel == 39)
            nExp =  FloatToInt((nBaseExp * 39.0) * fPow);
        else if (nLevel == 40)
            nExp = FloatToInt((nBaseExp * 26.6667) * fPow);


        else nExp =  0;
      }
      else if (nCR > 40){
        if (nLevel >= 1 &&
            nLevel <= 33)
            nExp =  FloatToInt((nBaseExp * 352.0) * fPow);
        else if (nLevel == 34)
            nExp =  FloatToInt((nBaseExp * 272.0) * fPow);
        else if (nLevel == 35)
            nExp =  FloatToInt((nBaseExp * 186.6667) * fPow);
        else if (nLevel == 36)
            nExp =  FloatToInt((nBaseExp * 144.0) * fPow);
        else if (nLevel == 37)
            nExp =  FloatToInt((nBaseExp * 98.6667) * fPow);
        else if (nLevel == 38)
            nExp =  FloatToInt((nBaseExp * 76.0) * fPow);
        else if (nLevel == 39)
            nExp =  FloatToInt((nBaseExp * 52.0) * fPow);
        else if (nLevel == 40)
            nExp =  FloatToInt((nBaseExp * 40.0) * fPow);


        else nExp =  0;
      }
      else nExp = 0;

   return nExp;
}
//::////////////////////////////////////////////////////////////////////////////
//void main(){}
