//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
//
int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//

int getroll(int n) {
  int r = Random(n + 1);
  if (r == 0 )
    return 1;
  else
    return r ;
}


string GetTemplateByCR(int nCR, string sGroupType)
{
  string sRetTemplate;

  if (sGroupType == "outdoor")
    {
      switch (nCR)
	{
	case 1:
	  switch(d6(1))
	    {
	    case 1: sRetTemplate = "NW_SKELETON"; break;
	    case 2: sRetTemplate = "NW_ZOMBIE01"; break;
	    case 3: sRetTemplate = "NW_NIXIE"; break;
	    case 4: sRetTemplate = "NW_ORCA"; break;
	    case 5: sRetTemplate = "NW_ORCB"; break;
	    case 6: sRetTemplate = "NW_BTLFIRE"; break;
	    }
	  break;
	case 2:
	  switch(d4(1))
	    {
	    case 1: sRetTemplate = "NW_KOBOLD004"; break;
	    case 2: sRetTemplate = "NW_KOBOLD005"; break;
	    case 3: sRetTemplate = "NW_KOBOLD003"; break;
	    case 4: sRetTemplate = "NW_PIXIE"; break;
	    }
	  break;
	case 3:
	  switch(d4(1))
	    {
	    case 1: sRetTemplate = "NW_BTLBOMB"; break;
	    case 2: sRetTemplate = "NW_BTLFIRE002"; break;
	    case 3: sRetTemplate = "NW_BTLSTINK"; break;
	    case 4: sRetTemplate = "NW_NYMPH"; break;
	    }
	  break;
	default:
	  sRetTemplate = "";
	  break;
	}
    }

  else if (sGroupType == "crypt")
    {
      switch (nCR)
	{
	case 1:
	  switch(Random(5) + 1)
	    {
	    case 1:
	    case 2: sRetTemplate = "NW_SKELETON"; break;
	    case 3: sRetTemplate = "NW_ZOMBIE01"; break;
	    case 4: sRetTemplate = "NW_ZOMBIE02"; break;
	    case 5: sRetTemplate = "NW_ZOMBIE02"; break;
	    }
	  break;
	case 2:
	  sRetTemplate = "NW_GHOUL";
	  break;
	case 3:
	  sRetTemplate = "NW_SHADOW";
	  break;
	case 4:
	  sRetTemplate = "zep_ghostf_003";
	  break;
    case 5: 
		sRetTemplate = "zep_flvampf_001";
		 break;
	default:
	  sRetTemplate = "";
	  break;
	}
    } 
else if (sGroupType == "blood") {

	  switch(d2(1)) 
	  {
		case 1: sRetTemplate = "zep_ghostf_012"; break; 
		case 2: sRetTemplate = "zep_ghostf_017"; break; 
	    case 3:sRetTemplate = "zep_ghostf_003"; break;
	  }

}	else if (sGroupType == "forest") {
    switch (nCR) {
    case 1:
      switch (getroll(35)) {
      case 1: sRetTemplate = "ks_small_spider"; break;
      case 2: sRetTemplate = "nw_badger" ;break;
      case 3: sRetTemplate = "nw_ratdire001" ;break;
      case 4: sRetTemplate = "nw_rat001"              ;break;
      case 5: sRetTemplate = "nw_goblina"             ;break;
      case 6: sRetTemplate = "nw_goblinb"             ;break;
      case 7: sRetTemplate = "nw_hobgoblin001"        ;break;
      case 8: sRetTemplate = "nw_kobold001"           ;break;
      case 9: sRetTemplate = "nw_kobold002"           ;break;
      case 10: sRetTemplate = "nw_orca"                ;break;
      case 11: sRetTemplate = "nw_orcb"                ;break;
      case 12: sRetTemplate = "nw_btlfire"             ;break;
      case 13: sRetTemplate = "nw_stirge"              ;break;
      case 14: sRetTemplate = "nw_tiefling02"          ;break;
      case 15: sRetTemplate = "nw_werecat001"          ;break;
      case 16: sRetTemplate = "nw_wererat001"          ;break;
      case 17: sRetTemplate = "nw_werewolf001"         ;break;
      case 18: sRetTemplate = "nw_bandit001"           ;break;
      case 19: sRetTemplate = "x3_antoine"             ;break;
      case 20: sRetTemplate = "nw_wererat"             ;break;
      case 21: sRetTemplate = "nw_skeleton"            ;break;
      case 22: sRetTemplate = "nw_dwarfmerc001"        ;break;
      case 23: sRetTemplate = "nw_elfranger001"        ;break;
      case 24: sRetTemplate = "x3_elfmount001"         ;break;
      case 25: sRetTemplate = "nw_bandit002"           ;break;
      case 26: sRetTemplate = "nw_gypsy002"            ;break;
      case 27: sRetTemplate = "nw_gypsy001"            ;break;
      case 28: sRetTemplate = "nw_gypfemale"           ;break;
      case 29: sRetTemplate = "nw_gypmale"             ;break;
      case 30: sRetTemplate = "nw_guard"               ;break;
      case 31: sRetTemplate = "nw_kurthsold"           ;break;
      case 32: sRetTemplate = "nw_luskanite"           ;break;
      case 33: sRetTemplate = "nw_noblmale"            ;break;
      case 34: sRetTemplate = "nw_noblfemale"          ;break;
      case 35: sRetTemplate = "nw_plagmale"            ;break;
      }
      break;
    case 2:
    case 3:
      switch (getroll(55))
	{
	case 1: sRetTemplate =  "lizardfolkscaven"        ;break;
	case 2: sRetTemplate =  "nw_cougar"               ;break;
	case 3: sRetTemplate =  "nw_cragcat"              ;break;
	case 4: sRetTemplate =  "nw_cat"                  ;break;
	case 5: sRetTemplate =  "nw_panther"              ;break;
	case 6: sRetTemplate =  "x3_blckcobra001"         ;break;
	case 7: sRetTemplate =  "nw_boar"                 ;break;
	case 8: sRetTemplate =  "nw_sharkgoblin"          ;break;
	case 9: sRetTemplate =  "nw_sharkhammer"           ;break;
	case 10: sRetTemplate = "x3_hybcobra001"           ;break;
	case 11: sRetTemplate = "nw_sharkmako"             ;break;
	case 12: sRetTemplate = "nw_bugbeara"              ;break;
	case 13: sRetTemplate = "nw_bugbearb"             ;break;
	case 14: sRetTemplate = "nw_grig"                  ;break;
	case 15: sRetTemplate = "nw_pixie"                 ;break;
	case 16: sRetTemplate = "nw_hobgoblin002"          ;break;
	case 17: sRetTemplate = "x0_asabi_warrior"         ;break;
	case 18: sRetTemplate = "nw_kobold004"             ;break;
	case 19: sRetTemplate = "nw_kobold006"             ;break;
	case 20: sRetTemplate = "nw_kobold005"             ;break;
	case 21: sRetTemplate = "nw_kobold003"             ;break;
	case 22: sRetTemplate =  "nw_oldwarb"                ;break;
	case 23: sRetTemplate =  "nw_oldwarra"               ;break;
	case 24: sRetTemplate =  "nw_sahuagin"               ;break;
	case 25: sRetTemplate =  "nw_sahuaginclr"            ;break;
	case 26: sRetTemplate =  "nw_krenshar"              ; break;
	case 27: sRetTemplate =  "nw_werewolf"               ;break;
	case 28: sRetTemplate =  "nw_ghoul"                  ;break;
	case 29: sRetTemplate =  "nw_dwarfmerc002"           ;break;
	case 30: sRetTemplate =  "nw_elfmerc001"              ;break;
	case 31: sRetTemplate = "nw_humanmerc001"            ;break;
	case 32: sRetTemplate = "x3_hummount001"             ;break;
	case 33: sRetTemplate = "nw_wolf"                ;break;
	case 34: sRetTemplate = "nw_trog001"             ;break;
	case 35: sRetTemplate = "nw_gnoll001"            ;break;
	case 36: sRetTemplate = "x2_deeprothe001"        ;break;
	case 37: sRetTemplate = "nw_ochrejellysml"       ;break;
	case 38: sRetTemplate = "x0_form_worker"         ;break;
	case 39: sRetTemplate = "nw_zombie01"            ;break;
	case 40: sRetTemplate = "nw_zombie02"            ;break;
	case 41: sRetTemplate = "nw_duecler001"           ;break;
	case 42: sRetTemplate ="nw_duemage001"           ;break;
	case 43: sRetTemplate ="nw_duerogue001"          ;break;
	case 44: sRetTemplate ="nw_duefight001"          ;break;
	case 45: sRetTemplate ="x3_dwarfmount001"        ;break;
	case 46: sRetTemplate ="nw_drowrogue001"         ;break;
	case 47: sRetTemplate ="nw_drowmage001"          ;break;
	case 48: sRetTemplate ="nw_drowfight001"         ;break;
	case 49: sRetTemplate ="nw_drowcler001"          ;break;
	case 50: sRetTemplate ="nw_halfmerc001"          ;break;
	case 51: sRetTemplate ="nw_bandit003"            ;break;
	case 52: sRetTemplate ="nw_uthgard01"            ;break;
	case 53: sRetTemplate = "nw_uthgard02"           ;break;
	case 54: sRetTemplate = "nw_noblfemale"          ;break;
	case 55: sRetTemplate = "nw_plagmale"            ;break;
	}
      break;
    case 4:
    case 5:
      switch (getroll(50)) {
      case 1: sRetTemplate =   "x2_beholder002"           ;break;
      case 2: sRetTemplate =   "nw_worg"                  ;break;
      case 3: sRetTemplate =   "nw_jaguar"                ;break;
      case 4: sRetTemplate =   "nw_lion"                  ;break;
      case 5: sRetTemplate =   "nw_direbadg"            ;  break;
      case 6: sRetTemplate =   "x3_spitcobra001"          ;break;
      case 7: sRetTemplate =   "x0_wyrmling_blk"          ;break;
      case 8: sRetTemplate =   "x0_wyrmling_wht"          ;break;
      case 9: sRetTemplate =   "nw_fire"                   ;break;
      case 10: sRetTemplate =  "nw_ogre01"                 ;break;
      case 11: sRetTemplate =  "nw_ogre02"                 ;break;
      case 12: sRetTemplate =  "nw_gobchiefb"              ;break;
      case 13: sRetTemplate =  "nw_gobwiza"               ;break;
      case 14: sRetTemplate =  "nw_gobwizb"                ;break;
      case 15: sRetTemplate =  "nw_sahuaginldr"            ;break;
      case 16: sRetTemplate =  "nw_trog002"               ;break;
      case 17: sRetTemplate =  "nw_orcchiefa"             ;break;
      case 18: sRetTemplate =  "nw_orcchiefb"             ;break;
      case 19: sRetTemplate =  "nw_gnoll002"              ;break;
      case 20: sRetTemplate =  "x0_stinger"               ;break;
      case 21: sRetTemplate =  "nw_btlbomb"               ;break;
      case 22: sRetTemplate =   "nw_btlfire02"            ;break;
      case 23: sRetTemplate =   "nw_btlstink"             ;break;
      case 24: sRetTemplate =   "nw_spidgiant"            ;break;
      case 25: sRetTemplate =   "nw_spidphase"            ;break;
      case 26: sRetTemplate =   "nw_gargoyle"            ; break;
      case 27: sRetTemplate =   "x2_gelcube"              ;break;
      case 28: sRetTemplate =   "nw_grayooze"             ;break;
      case 29: sRetTemplate =   "nw_ochrejellymed"        ;break;
      case 30: sRetTemplate =   "nw_mepair"                ;break;
      case 31: sRetTemplate =  "nw_mepdust"               ;break;
      case 32: sRetTemplate =  "nw_mepearth"              ;break;
      case 33: sRetTemplate =  "nw_mepfire"               ;break;
      case 34: sRetTemplate =  "nw_mepice"               ;break;
      case 35: sRetTemplate =  "nw_imp"                   ;break;
      case 36: sRetTemplate =  "nw_mepmagma"              ;break;
      case 37: sRetTemplate =  "nw_mepooze"               ;break;
      case 38: sRetTemplate =  "nw_dmquasit"              ;break;
      case 39: sRetTemplate =  "nw_mepsalt"               ;break;
      case 40: sRetTemplate =  "nw_mepsteam"              ;break;
      case 41: sRetTemplate =  "nw_mepwater"              ;break;
      case 42: sRetTemplate =  "nw_aranea"                ;break;
      case 43: sRetTemplate =   "nw_vampire_shad"          ;break;
      case 44: sRetTemplate =   "nw_shadow"                ;break;
      case 45: sRetTemplate =   "nw_allip"                 ;break;
      case 46: sRetTemplate =   "nw_zombtyrant"            ;break;
      case 47: sRetTemplate =   "nw_drowrogue005"          ;break;
      case 48: sRetTemplate =   "nw_halfmerc002"           ;break;
      case 49: sRetTemplate =   "nw_bandit004"             ;break;
      case 50: sRetTemplate =   "nw_humanmerc002"          ;break;
      }
      break;
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
      switch (getroll(76))
	{
	case 1: sRetTemplate =   "x3_goldcobra001"          ;break;
	case 2: sRetTemplate =   "x0_wyrmling_grn"          ;break;
	case 3: sRetTemplate =   "x3_wyvern004"             ;break;
	case 4: sRetTemplate =   "nw_air"                   ;break;
	case 5: sRetTemplate =   "nw_earth"                 ;break;
	case 6: sRetTemplate =   "nw_water"                 ;break;
	case 7: sRetTemplate =   "nw_bugwiza"               ;break;
	case 8: sRetTemplate =   "nw_bugwizb"               ;break;
	case 9: sRetTemplate =   "nw_gobchiefa"             ;break;
	case 10: sRetTemplate =  "nw_oldchiefa"             ;break;
	case 11: sRetTemplate =  "nw_oldchiefb"             ;break;
	case 12: sRetTemplate =  "nw_oldmagea"              ;break;
	case 13: sRetTemplate =  "nw_oldmageb"              ;break;
	case 14: sRetTemplate =  "nw_minotaur"              ;break;
	case 15: sRetTemplate =  "nw_orcwiza"               ;break;
	case 16: sRetTemplate =  "nw_orcwizb"               ;break;
	case 17: sRetTemplate =  "nw_seahag"                ;break;
	case 18: sRetTemplate =  "nw_spidswrd"              ;break;
	case 19: sRetTemplate =  "nw_spidwra"               ;break;
	case 20: sRetTemplate =  "nw_hellhound"             ;break;
	case 21: sRetTemplate =  "nw_shmastif"              ;break;
	case 22: sRetTemplate =   "x0_form_warrior"          ;break;
	case 23: sRetTemplate =   "nw_ghast"                 ;break;
	case 24: sRetTemplate =   "nw_wight"                 ;break;
	case 25: sRetTemplate =   "nw_skelmage"              ;break;
	case 26: sRetTemplate =   "nw_skelpriest"            ;break;
	case 27: sRetTemplate =   "nw_zombwarr01"            ;break;
	case 28: sRetTemplate =   "nw_zombwarr02"            ;break;
	case 29: sRetTemplate =   "x2_duergar002"            ;break;
	case 30: sRetTemplate =   "nw_duecler005"            ;break;
	case 31: sRetTemplate =  "nw_duemage005"            ;break;
	case 32: sRetTemplate =  "nw_duerogue005"           ;break;
	case 33: sRetTemplate =  "nw_duefight005"           ;break;
	case 34: sRetTemplate =  "nw_dwarfmerc003"          ;break;
	case 35: sRetTemplate =  "nw_drowmage005"           ;break;
	case 36: sRetTemplate =  "nw_drowfight005"          ;break;
	case 37: sRetTemplate =  "nw_drowcler005"           ;break;
	case 38: sRetTemplate =  "x2_drow002"               ;break;
	case 39: sRetTemplate =  "nw_elfmerc002"            ;break;
	case 40: sRetTemplate =  "nw_elfranger005"          ;break;
	case 41: sRetTemplate =  "nw_bandit005"             ;break;
	case 42: sRetTemplate =  "nw_gypsy004"              ;break;
	case 43: sRetTemplate =  "nw_gypsy003"               ;break;
	case 44: sRetTemplate =  "nw_ettercap"            ;break;
	case 45: sRetTemplate =  "nw_horror"              ;break;
	case 46: sRetTemplate =  "nw_bearbrwn"            ;break;
	case 47: sRetTemplate =  "tanarukk"               ;break;
	case 48: sRetTemplate =  "nw_direwolf"            ;break;
	case 49: sRetTemplate =  "nw_wolfwint"            ;break;
	case 50: sRetTemplate =  "nw_boardire"            ;break;
	case 51: sRetTemplate =  "x3_grtcobra001"         ;break;
	case 52: sRetTemplate =  "x0_wyrmling_blu"        ;break;
	case 53: sRetTemplate = "x0_wyrmling_red"        ;break;
	case 54: sRetTemplate = "nw_ogremage01"          ;break;
	case 55: sRetTemplate = "nw_ogremage02"          ;break;
	case 56: sRetTemplate = "nw_troll"               ;break;
	case 57: sRetTemplate = "nw_bugchiefa"           ;break;
	case 58: sRetTemplate = "nw_bugchiefb"           ;break;
	case 59: sRetTemplate = "x0_asabi_shaman"        ;break;
	case 60: sRetTemplate = "nw_trog003"             ;break;
	case 61: sRetTemplate = "nw_yuan_ti001"          ;break;
	case 62: sRetTemplate = "nw_yuan_ti002"          ;break;
	case 63: sRetTemplate = "x0_stinger_mage"        ;break;
	case 64: sRetTemplate = "x0_stinger_war"         ;break;
	case 65: sRetTemplate =  "x0_basilisk"            ;break;
	case 66: sRetTemplate =  "x0_cockatrice"          ;break;
	case 67: sRetTemplate =  "x2_harpy001"            ;break;
	case 68: sRetTemplate =  "nw_ochrejellylrg"       ;break;
	case 69: sRetTemplate =  "nw_beastxvim"           ;break;
	case 70: sRetTemplate =  "nw_werecat"             ;break;
	case 71: sRetTemplate =  "nw_ghoullord"           ;break;
	case 72: sRetTemplate =  "nw_mummy"               ;break;
	case 73: sRetTemplate =  "nw_curst003"            ;break;
	case 74: sRetTemplate = "nw_curst001"            ;break;
	case 75: sRetTemplate = "nw_wraith"              ;break;
	case 76: sRetTemplate = "nw_halfmerc003"          ;break;
	}
      break;
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
    default:
      switch (d20())
	{
	case 1: sRetTemplate = "nw_bearkodiak";     break;
	case 2: sRetTemplate = "nw_ogrechief01";    break;
	case 3: sRetTemplate = "nw_ogrechief02";    break;
	case 4: sRetTemplate = "nw_yuan_ti003";     break;
	case 5: sRetTemplate = "nw_direwolf";       break;
	case 6: sRetTemplate = "x0_asabi_chief";    break;
	case 7: sRetTemplate = "nw_curst004";       break;
	case 8: sRetTemplate = "zep_goblinworgr";   break;
	case 9: sRetTemplate = "nw_bugchiefa";      break;
	case 10: sRetTemplate = "x0_manticore";     break;
	case 11: sRetTemplate = "nw_rakshasa";       break;
	case 12: sRetTemplate = "nw_revenant001";    break;
	case 13: sRetTemplate = "nw_bandit006";      break;
	case 14: sRetTemplate = "nw_trollchief";     break;
	case 15: sRetTemplate = "nw_direwolf";       break;
	case 16: sRetTemplate = "nw_btlstag";        break;
	case 17: sRetTemplate = "x0_gorgon";         break;
	case 18: sRetTemplate = "zep_goblinworgr";   break;
	case 19: sRetTemplate = "nw_duerogue010";    break;
	case 20: sRetTemplate ="nw_duefight010";   break;
	}
      break;
    }
      
  } else if (sGroupType == "mercs") {
    switch(nCR)
      {
	//Spawn Something with CR 1
      case 1:
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_BANDIT001"; break;
	  case 2: sRetTemplate = "NW_BANDIT002"; break;
	  case 3: sRetTemplate = "NW_BANDIT003"; break;
	  case 4: sRetTemplate = "NW_GYPSY002";  break;
	  case 5: sRetTemplate = "NW_GYPSY001";  break;
	  case 6: sRetTemplate = "NW_DWARFMERC001"; break;
	  }
	break;

      case 2:
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_HUMANMERC001";  break;
	  case 2: sRetTemplate = "NW_ELFMERC001";    break;
	  case 3: sRetTemplate = "NW_DWARFMERC002";  break;
	  case 4: sRetTemplate = "NW_GYPSY002";      break;
	  case 5: sRetTemplate = "NW_GYPSY001";      break;
	  case 6: sRetTemplate = "NW_DWARFMERC001";  break;
	  }
	break;

      case 3:
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_HALFMERC002";   break;
	  case 2: sRetTemplate = "NW_HUMANMERC002";  break;
	  case 3: sRetTemplate = "NW_HALFMERC002";   break;
	  case 4: sRetTemplate = "NW_BANDIT004";     break;
	  case 5: sRetTemplate = "NW_GYPSY001";      break;
	  case 6: sRetTemplate = "NW_DWARFMERC001";  break;
	  }
	break;


      case 4:
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_ELFMERC002";   break;
	  case 2: sRetTemplate = "NW_DWARFMERC003"; break;
	  case 3: sRetTemplate = "NW_HALFMERC002";  break;
	  case 4: sRetTemplate = "NW_GYPSY003";     break;
	  case 5: sRetTemplate = "NW_HALFMERC003";  break;
	  case 6: sRetTemplate = "NW_DWARFMERC001"; break;
	  }
	break;

      case 5:
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_HALFMERC003"; break;
	  case 2: sRetTemplate = "NW_DWARFMERC003"; break;
	  case 3: sRetTemplate = "NW_HALFMERC002";  break;
	  case 4: sRetTemplate = "NW_GYPSY003";      break;
	  case 5: sRetTemplate = "NW_ELFMERC003";    break;
	  case 6: sRetTemplate = "NW_DWARFMERC001";  break;
	  }
	break;

      case 6:
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_ELFMERC003";   break;
	  case 2: sRetTemplate = "NW_DWARFMERC003"; break;
	  case 3: sRetTemplate = "NW_HUMANMERC003"; break;
	  case 4: sRetTemplate = "NW_HALFMERC003";  break;
	  case 5: sRetTemplate = "NW_HALFMERC004";  break;
	  case 6: sRetTemplate = "NW_HUMANMERC003"; break;
	  }
	break;

      case 7:
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_GYPSY005";   break;
	  case 2: sRetTemplate = "NW_DWARFMERC004";    break;
	  case 3: sRetTemplate = "NW_HUMANMERC003";     break;
	  case 4: sRetTemplate = "NW_HALFMERC004";       break;
	  case 5: sRetTemplate = "NW_HALFMERC004";       break;
	  case 6: sRetTemplate = "NW_ELFMERC003";        break;
	  }
	break;

      default :
	switch (d10())
	  {
	  case 1: sRetTemplate = "NW_DWARFMERC005";  break;
	  case 2: sRetTemplate = "NW_HUMANMERC005";   break;
	  case 3: sRetTemplate = "NW_HUMANMERC004";   break;
	  case 4: sRetTemplate = "NW_HALFMERC004";    break;
	  case 5: sRetTemplate = "NW_ELFMERC005";     break;
	  case 6: sRetTemplate = "NW_DWARFMERC006";   break;
	  case 7: sRetTemplate = "NW_ELFMERC005";     break;
	  case 8: sRetTemplate = "NW_GYPSY007";       break;
	  case 9: sRetTemplate = "NW_GYPSY006";       break;
	  case 10: sRetTemplate = "NW_BANDIT007";     break;
	  }
	break;
      }
  } else if (sGroupType == "rxvars") {
    switch (nCR)
      {
      case 3:
	switch (d3())
	  {
	  case 1: sRetTemplate = "xvar1";   break;
	  case 2: sRetTemplate = "xvar2";   break;
	  case 3: sRetTemplate = "xvar3";   break;

	  }
	break;
      default :
	switch (d6())
	  {
	  case 1: sRetTemplate = "xvar1";   break;
	  case 2: sRetTemplate = "xvar2";   break;
	  case 3: sRetTemplate = "xvar3";    break;
	  case 4: sRetTemplate = "zep_arcticbugb"; break;
	  case 5: sRetTemplate = "zep_arcticbugbch";   break;
	  case 6: sRetTemplate = "zep_arcticbugbsh";   break;

	  }
	break;
      }
  }
  else if (sGroupType == "ogres") {
    switch (nCR)
      {

      case 10:
	switch (d2())
	  {
	  case 1: sRetTemplate = "zep_cyclopsa";   break;
	  case 2: sRetTemplate = "zep_cyclops";     break;
	  }
	break;
      default :
	switch (d6())
	  {
	  case 1: sRetTemplate = "NW_OGRE01";   break;
	  case 2: sRetTemplate = "NW_OGRE02";       break;
	  case 3: sRetTemplate = "NW_OGRECHIEF01";     break;
	  case 4: sRetTemplate = "nw_ogreboss";         break;
	  case 5: sRetTemplate = "NW_OGREMAGE01";      break;
	  case 6: sRetTemplate = "NW_OGRE01";            break;
	  }
	break;
      }
  }
  else if (sGroupType == "planars") {
    switch (nCR)
      {
	// Spawn Something with CR 1
      case 1 :
	switch (d3())
	  {
	  case 1: sRetTemplate = "zep_feyri";   break;
	  case 2: sRetTemplate = "zep_bladeling";    break;
	  case 3: sRetTemplate = "zep_etherscarab";      break;

	  }
	break;



      case 3:
	switch (d3())
	  {

	  case 1: sRetTemplate = "zep_azermale";    break;
	  case 2: sRetTemplate = "zep_halffiendf";     break;
	  case 3: sRetTemplate = "zep_etherscarab";     break;

	  }
	break;
      case 7 :
	switch (d3())
	  {
	  case 1: sRetTemplate = "zep_marilithbg";  break;
	  case 2: sRetTemplate = "zep_succubus";    break;
	  case 3: sRetTemplate = "zep_azerfemale";   break;

	  }
	break;

      case 9 :
	switch (d2())
	  {
	  case 1: sRetTemplate = "zep_slaadgrn"; break;
	  case 2: sRetTemplate = "zep_hamatula";  break;

	  }
	break;

      case 10 :
	switch (d3())
	  {
	  case 1: sRetTemplate = "zep_erinyes";     break;
	  case 2: sRetTemplate = "zep_erinyes2";     break;
	  case 3: sRetTemplate = "zep_spidfiend4";   break;

	  }
	break;

      case 13 :
	switch (d6())
	  {
	  case 1: sRetTemplate = "zep_hamatula_35e";   break;
	  case 2: sRetTemplate = "zep_cornugona";      break;
	  case 3: sRetTemplate = "zep_osyluth1";       break;
	  case 4: sRetTemplate = "zep_demonvorlan";    break;
	  case 5: sRetTemplate = "zep_pitfiend";       break;
	  case 6: sRetTemplate = "zep_balrog";         break;



	  }
	break;

      case 30 :
	switch (d3())
	  {
	  case 1: sRetTemplate = "zep_merilith2";   break;
	  case 2: sRetTemplate = "zep_marilithbg";   break;
	  case 3: sRetTemplate = "zep_marilith";     break;



	  }
	break;


      default  :
	switch (d3())
	  {
	  case 1: sRetTemplate = "zep_bladeling";   break;
	  case 2: sRetTemplate = "zep_halffiend";   break;
	  case 3: sRetTemplate = "zep_azermale";    break;
	  case 4: sRetTemplate = "zep_succubus";     break;
	  case 5: sRetTemplate = "zep_feyri";        break;
	  case 6: sRetTemplate = "zep_succubus";      break;

	  }
	break;
      }
  }
  else if (sGroupType == "drows") {
    switch (nCR)
      {
      case 1:
	switch (d2())
	  {
	  case 1: sRetTemplate = "NW_DROWROGUE001";   break;
	  case 2: sRetTemplate = "X2_DROW001";     break;

	  }
	break;

      default  :
	switch (d12())
	  {
	  case 1: sRetTemplate = "NW_DROWROGUE020";   break;
	  case 2: sRetTemplate = "NW_DROWROGUE015";       break;
	  case 3: sRetTemplate = "NW_DROWFIGHT010";     break;
	  case 4: sRetTemplate = "NW_DROWFIGHT015";         break;
	  case 5: sRetTemplate = "X2_MEPHDROW013";      break;
	  case 6: sRetTemplate = "NW_DROWCLER005";            break;
	  case 7: sRetTemplate = "X2_MEPHDROW004";   break;
	  case 8: sRetTemplate = "X2_DROW004";       break;
	  case 9: sRetTemplate = "X2_MEPHDROW003";     break;
	  case 10: sRetTemplate = "NW_DROWFIGHT001";         break;
	  case 11: sRetTemplate = "NW_DROWFIGHT001";      break;
	  case 12: sRetTemplate = "X2_MEPHDROW003";            break;
	  }
	break;
      }
  }
  else if (sGroupType == "elfs") {
    // Select a Creature to Spawn
    switch (nCR)
      {
      case 1:
	switch (d2())
	  {
	  case 1: sRetTemplate = "NW_ELFMAGE001";   break;
	  case 2: sRetTemplate = "NW_ELFMERC001";     break;
	  }
	break;
      default  :
	switch (d12())
	  {
	  case 1: sRetTemplate = "NW_ELFMERC001";   break;
	  case 2: sRetTemplate = "NW_ELFMAGE001";       break;
	  case 3: sRetTemplate = "NW_ELFMERC002";     break;
	  case 4: sRetTemplate = "NW_ELFMERC002";         break;
	  case 5: sRetTemplate = "NW_ELFMERC003";      break;
	  case 6: sRetTemplate = "NW_ELFMERC005";            break;
	  case 7: sRetTemplate = "NW_ELFRANGER001";   break;
	  case 8: sRetTemplate = "NW_ELFRANGER005";       break;
	  case 9: sRetTemplate = "NW_ELFRANGER005";     break;
	  case 10: sRetTemplate = "NW_ELFRANGER015";         break;
	  case 11: sRetTemplate = "NW_ELFMERC001";      break;
	  case 12: sRetTemplate = "NW_ELFMERC001";            break;

	  }
	break;

      }
  }
  else if (sGroupType == "commoners") {
	switch(Random(4) + 1) {
		case 1: sRetTemplate = "commoner001"; break;
		case 2: sRetTemplate = "commoner002"; break;
		case 3: sRetTemplate = "commoner003"; break;
		case 4: sRetTemplate = "commoner004"; break;
	}
  }
  else if (sGroupType == "plants") {
    switch (nCR)
      {
      case 1:
	switch (d2())
	  {
	  case 1: sRetTemplate = "zep_vegepygmy";   break;
	  case 2: sRetTemplate = "zep_vegepygmy";     break;

	  }
	break;

      default  :
	switch (d12())
	  {
	  case 1: sRetTemplate = "zep_vegepygmy";         break;
	  case 2: sRetTemplate = "zep_vegepygmyb";        break;
	  case 3: sRetTemplate = "zep_vines1";            break;
	  case 4: sRetTemplate = "zep_vines2";            break;
	  case 5: sRetTemplate = "zep_thorny";            break;
	  case 6: sRetTemplate = "zep_thornyrider";       break;
	  case 7: sRetTemplate = "zep_thornyridert";      break;
	  case 8: sRetTemplate = "crp_twigblight";        break;
	  case 9: sRetTemplate = "zep_vegepygmyb";        break;
	  case 10: sRetTemplate = "zep_vegepygmych";      break;
	  case 11: sRetTemplate = "zep_vegepygmysc";      break;
	  case 12: sRetTemplate = "crp_twigblight";       break;

	  }
	break;
      }
  }
  else if (sGroupType == "shapechangers") {
    switch (nCR)
      {

      case 1:
	switch (d2())
	  {
	  case 1: sRetTemplate = "zep_skulkf 2";   break;
	  case 2: sRetTemplate = "zep_skulkm";     break;

	  }
	break;

      default  :
	switch (d8())
	  {
	  case 1: sRetTemplate = "zep_skulkm";         break;
	  case 2: sRetTemplate = "zep_barghest";        break;
	  case 3: sRetTemplate = "zep_doppelganger";            break;
	  case 4: sRetTemplate = "zep_goblinbargh";            break;
	  case 5: sRetTemplate = "zep_barghestg";            break;
	  case 6: sRetTemplate = "zep_goblinbarghg";       break;
	  case 7: sRetTemplate = "zep_thornyridert";      break;
	  case 8: sRetTemplate = "zep_werebat";        break;

	  }
	break;

      }
  } else if (sGroupType == "trolls") {
    // Select a Creature to Spawn
    switch (nCR)
      {

      case 1:
	switch (d2())
	  {
	  case 1: sRetTemplate = "crp_troll02";   break;
	  case 2: sRetTemplate = "crp_troll03";     break;

	  }
	break;

      default  :
	switch (d6())
	  {
	  case 1: sRetTemplate = "crp_troll03";         break;
	  case 2: sRetTemplate = "crp_trollwiz";        break;
	  case 3: sRetTemplate = "crp_troll02";            break;
	  case 4: sRetTemplate = "shadowtroll";            break;
	  case 5: sRetTemplate = "Troll Chieftain";            break;
	  case 6: sRetTemplate = "swamp_troll";       break;


	  }
	break;


      }
  }
  else if (sGroupType == "giants") {
    switch (nCR)
      {

      case 1:
	switch (d2())
	  {
	  case 1: sRetTemplate = "zep_cyclops";   break;
	  case 2: sRetTemplate = "zep_cyclops";     break;

	  }
	break;

      default  :
	switch (d8())
	  {
	  case 1: sRetTemplate = "zep_cyclops";         break;
	  case 2: sRetTemplate = "zep_cyclops";        break;
	  case 3: sRetTemplate = "caverngiant";            break;
	  case 4: sRetTemplate = "caverngiant1";            break;
	  case 5: sRetTemplate = "nw_gntfire";            break;
	  case 6: sRetTemplate = "x0_gntfirefem";       break;
	  case 7: sRetTemplate = "wildogre";      break;
	  case 8: sRetTemplate = "wildogreleader";        break;


	  }
	break;


      }
  }
  else
    {
      // unknown group type
      sRetTemplate = "";
    }

  return sRetTemplate;
}


// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
  float fCR, fEquivSq, fTemp;

  if (fEquiv == 0.0)
    {
      return 0.0;
    }

  fEquivSq = fEquiv * fEquiv;
  fTemp = log(fEquivSq);
  fTemp /= log(2.0);
  fCR = fEncounterLevel + fTemp;

  return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
  if (fCR > fEncounterLevel || fCR < 1.0)
    {
      return 1.;
    }

  float fEquiv, fExponent, fDenom;

  fExponent = fEncounterLevel - fCR;
  fExponent *= 0.5;
  fDenom = pow(2.0, fExponent);
  fEquiv =  1.0 / fDenom;

  return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
  // Initialize
  string sRetTemplate;

  // Initialize Values
  int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
  int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
  int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
  int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
  int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

  //
  // Only Make Modifications Between These Lines
  // -------------------------------------------

  if (GetStringLeft(sTemplate, 7) == "scaled_")
    {
      float fEncounterLevel;
      int nScaledInProgress = GetLocalInt(oSpawn, "ScaledInProgress");
      string sGroupType = GetStringRight(sTemplate,
					 GetStringLength(sTemplate) - 7);

      // First Time in for this encounter?
      if (! nScaledInProgress)
	{

	  // First time in - find the party level
	  int nTotalPCs = 0;
	  int nTotalPCLevel = 0;

	  object oArea = GetArea(OBJECT_SELF);

	  object oPC = GetFirstObjectInArea(oArea);
	  while (oPC != OBJECT_INVALID)
	    {
	      if (GetIsPC(oPC) == TRUE)
		{
		  nTotalPCs++;
		  nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
		}
	      oPC = GetNextObjectInArea(oArea);
	    }
	  if (nTotalPCs == 0)
	    {
	      fEncounterLevel = 0.0;
	    }
	  else
	    {
	      fEncounterLevel = IntToFloat(nTotalPCLevel) / IntToFloat(nTotalPCs);
	    }

	  // Save this for subsequent calls
	  SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);

	  // We're done when the CRs chosen add up to the
	  // desired encounter level
	  SetLocalInt(oSpawn, "ScaledCallCount", 0);
	  SetLocalInt(oSpawn, "ScaledInProgress", TRUE);
	}


      fEncounterLevel = GetLocalFloat(oSpawn, "ScaledEncounterLevel");
      int nScaledCallCount = GetLocalInt(oSpawn, "ScaledCallCount");

      // For simplicity, I'm not supporting creatures with CR < 1.0)
      if (fEncounterLevel < 1.0)
	{
	  // We're done... No creatures have CR low enough to add to this encounter
	  sRetTemplate = "";
	}

      else
	{
	  // randomly choose a CR at or below the remaining (uncovered) encounter
	  // level
	  int nCR = Random(FloatToInt(fEncounterLevel)) + 1;

	  // cap to the largest CR we currently support in GetTemplateByCR
	  if (nCR > 3)
	    {
	      nCR = 3;
	    }

	  sRetTemplate = GetTemplateByCR(nCR, sGroupType);


	  // Convert CR to Encounter Level equivalent so it can be correctly
	  // subtracted.  This does the real scaling work
	  float fELEquiv = ConvertCRToELEquiv(IntToFloat(nCR), fEncounterLevel);
	  float fElRemaining = 1.0 - fELEquiv;

	  fEncounterLevel = ConvertELEquivToCR(fElRemaining, fEncounterLevel);
	  SetLocalFloat(oSpawn, "ScaledEncounterLevel", fEncounterLevel);
	}

      nScaledCallCount++;
      SetLocalInt(oSpawn, "ScaledCallCount", nScaledCallCount);

      nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");

      if (nScaledCallCount >= nSpawnNumber)
	{
	  // reset...
	  SetLocalInt(oSpawn, "ScaledInProgress", FALSE);
	}
    }

  // cr_militia
  if (sTemplate == "cr_militia")
    {
      switch(d2(1))
        {
	case 1:
	  sRetTemplate = "cr_militia_m";
	  break;
	case 2:
	  sRetTemplate = "cr_militia_f";
	  break;
        }
    }
  //

  // pg_guard
  if (sTemplate == "pg_guard")
    {
      switch(d2(1))
        {
	case 1:
	  sRetTemplate = "pg_guard_m";
	  break;
	case 2:
	  sRetTemplate = "pg_guard_f";
	  break;
        }
    }
  //

  // Goblins
  if (sTemplate == "goblins_low")
    {
      if (d2(1) == 1)
        {
	  sRetTemplate = "NW_GOBLINA";
        }
      else
        {
	  sRetTemplate = "NW_GOBLINB";
        }
    }
  //

  // Goblins and Boss
  if (sTemplate == "gobsnboss")
    {
      int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
      if (nIsBossSpawned == TRUE)
        {
	  // Find the Boss
	  object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

	  // Check if Boss is Alive
	  if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
	      // He's alive, spawn a Peon to keep him Company
	      sRetTemplate = "NW_GOBLINA";
            }
	  else
            {
	      // He's dead, Deactivate Camp!
	      SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
      else
        {
	  // No Boss, so Let's Spawn Him
	  sRetTemplate = "NW_GOBCHIEFA";
	  SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
  //

  // Scaled Encounter
  if (sTemplate == "scaledgobs")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {
	  // Spawn Something with CR 1
	case 1:
	  sRetTemplate = "cr1creature";
	  break;
	  //

	  // Spawn Something with CR 5
	case 5:
	  sRetTemplate = "cr5creature";
	  break;
	  //
        }
    }
  //

  // Pirates and Boss
  if (sTemplate == "pirates")
    {
      // Delay the Spawn for 45 Minutes
      if (GetLocalInt(oSpawn, "DelayEnded") == FALSE)
        {
	  if (GetLocalInt(oSpawn, "DelayStarted") == FALSE)
            {
	      // Start the Delay
	      SetLocalInt(oSpawn, "DelayStarted", TRUE);
	      DelayCommand(20.0, SetLocalInt(oSpawn, "DelayEnded", TRUE));
            }
	  sRetTemplate = "";
	  return sRetTemplate;
        }
      int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
      if (nIsBossSpawned == TRUE)
        {
	  // Find the Boss
	  object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

	  // Check if Boss is Alive
	  if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
	      // He's alive, spawn a Peon to keep him Company
	      sRetTemplate = "NW_GOBLINA";
            }
	  else
            {
	      // He's dead, Deactivate Camp!
	      SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
      else
        {
	  // No Boss, so Let's Spawn Him
	  sRetTemplate = "NW_GOBCHIEFA";
	  SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
  //

  
  //

  // Encounters
  if (sTemplate == "encounter")
    {
      // Declare Variables
      int nCounter, nCounterMax;
      string sCurrentTemplate;

      // Retreive and Increment Counter
      nCounter = GetLocalInt(oSpawn, "GroupCounter");
      nCounterMax = GetLocalInt(oSpawn, "CounterMax");
      nCounter++;

      // Retreive CurrentTemplate
      sCurrentTemplate = GetLocalString(oSpawn, "CurrentTemplate");

      // Check CounterMax
      if (nCounter > nCounterMax)
        {
	  sCurrentTemplate = "";
	  nCounter = 1;
        }

      if (sCurrentTemplate != "")
        {
	  // Spawn Another CurrentTemplate
	  sRetTemplate = sCurrentTemplate;
        }
      else
        {
	  // Choose New CurrentTemplate and CounterMax
	  switch (Random(2))
            {
	      // Spawn 1-4 NW_DOGs
	    case 0:
	      sRetTemplate = "NW_DOG";
	      nCounterMax = Random(4) + 1;
	      break;
            }
	  // Record New CurrentTemplate and CounterMax
	  SetLocalString(oSpawn, "CurrentTemplate", sRetTemplate);
	  SetLocalInt(oSpawn, "CounterMax", nCounterMax);
        }

      // Record Counter
      SetLocalInt(oSpawn, "GroupCounter", nCounter);
    }
  //

  //
  if (sTemplate == "kobolds")
    {
      int nKobold = Random(6) + 1;
      sRetTemplate = "NW_KOBOLD00" + IntToString(nKobold);
    }
  //
  //Sily's Groups
  if (sTemplate == "sily_goblin_scout")
    {
      switch(d2(1))
        {
	case 1:
	  sRetTemplate = "an_goblin";
	  break;
	case 2:
	  sRetTemplate = "an_goblin2";
	  break;
        }
    }

  if (sTemplate == "goblins_chantas")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {
	  // Spawn Something with CR 1
	case 1:
	  switch (d3())
	    {
	    case 1: sRetTemplate = "NW_GOBLINA"; break;
	    case 2: sRetTemplate = "NW_GOBLINB"; break;
	    case 3: sRetTemplate = "NW_GOBCHIEFB"; break;


	    }
	  break;
	case 2:
	  switch (d3())
	    {
	    case 1: sRetTemplate = "NW_GOBLINA";  break;
	    case 2: sRetTemplate = "NW_GOBLINB";  break;
	    case 3: sRetTemplate = "NW_GOBCHIEFB"; break;
	    }
	  break;


	case 3:
	  switch (d4())
	    {
	    case 1: sRetTemplate = "goblina001";  break;
	    case 2: sRetTemplate = "trasgofrancotir";  break;
	    case 3: sRetTemplate = "NW_GOBCHIEFA";  break;
	    case 4: sRetTemplate = "NW_GOBLINA";  break;
	    }
	  break;

	case 5 :

	  switch(d2())
	    {

	    case 1 : sRetTemplate = "zep_goblinworgr";  break;
	    case 2: sRetTemplate = "zep_goblinworgg";  break;
	    }

	  break ;

	default :
	  switch (d4())
	    {
	    case 1: sRetTemplate = "NW_GOBLINA";   break;
	    case 2: sRetTemplate = "NW_GOBCHIEFB";  break;
	    case 3: sRetTemplate = "NW_GOBCHIEFA";   break;
	    case 4: sRetTemplate = "NW_GOBLINBOSS";  break;

	    }
	  break;


        }
    }


  if (sTemplate == "scaled_vampires")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "nw_curst003";   break;
	    case 2: sRetTemplate = "nw_curst002";     break;

	    }
	  break;

	default  :
	  switch (d8())
	    {
	    case 1: sRetTemplate = "nw_curst002";         break;
	    case 2: sRetTemplate = "nw_curst003";        break;
	    case 3: sRetTemplate = "nw_revenant001";            break;
	    case 4: sRetTemplate = "nw_vampire002";            break;
	    case 5: sRetTemplate = "nw_vampire001";            break;
	    case 6: sRetTemplate = "nw_vampire003";       break;
	    case 7: sRetTemplate = "nw_vampire004";      break;
	    case 8: sRetTemplate = "nw_curst004";        break;


	    }
	  break;


        }
    }
  //***************************end vampsi**********************************//



  if (sTemplate == "scaled_driders")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "zep_dridmale_e";   break;
	    case 2: sRetTemplate = "zep_dridmale_e";     break;

	    }
	  break;

	default  :
	  switch (d8())
	    {
	    case 1: sRetTemplate = "zep_dridmale_e";         break;
	    case 2: sRetTemplate = "zep_dridmale_e";        break;
	    case 3: sRetTemplate = "zep_dridarmor_c";            break;
	    case 4: sRetTemplate = "zep_dridarmor_c";            break;
	    case 5: sRetTemplate = "zep_dridfem_c";            break;
	    case 6: sRetTemplate = "zep_dridfem_a";       break;
	    case 7: sRetTemplate = "zep_dridfem_b";      break;
	    case 8: sRetTemplate = "zep_dridarmor_c";        break;


	    }
	  break;


        }
    }
  //*******************************end scaled driders ****************************************//



  if (sTemplate == "scaled_nomuertos")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "ghast001";   break;
	    case 2: sRetTemplate = "ghast001";     break;

	    }
	  break;

	default  :
	  switch (d20())
	    {
	    case 1: sRetTemplate = "ghast001";         break;
	    case 2: sRetTemplate = "espiritucous";        break;
	    case 3: sRetTemplate = "zep_batbattle";            break;
	    case 4: sRetTemplate = "zep_batbone";            break;
	    case 5: sRetTemplate = "curstranger";            break;
	    case 6: sRetTemplate = "ghostwarrior";       break;
	    case 7: sRetTemplate = "vampire001";      break;
	    case 8: sRetTemplate = "zep_wendigo";        break;
	    case 9: sRetTemplate = "sharouwharit";        break;
	    case 10: sRetTemplate = "sharoulordadasd";      break;
	    case 11: sRetTemplate = "zep_skelredeyes";      break;
	    case 12: sRetTemplate = "espectrosword";       break;
	    case 13: sRetTemplate = "sharoulordadasd";      break;
	    case 14: sRetTemplate = "zep_skelredeyes";      break;
	    case 15: sRetTemplate = "espectrosword";       break;
	    case 16: sRetTemplate = "hogcalballer";      break;
	    case 17: sRetTemplate = "kr_furiaghost";      break;
	    case 18: sRetTemplate = "espectrosword";       break;
	    case 19: sRetTemplate = "hogcalballer";      break;
	    case 20: sRetTemplate = "sharouwharit";      break;


	    }
	  break;


        }
    }

  //*********************end no muertos *************************************//



  if (sTemplate == "scaled_spiders")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "zep_spidgiant";   break;
	    case 2: sRetTemplate = "zep_spidphase";     break;

	    }
	  break;

	default  :
	  switch (d8())
	    {
	    case 1: sRetTemplate = "zep_spiddire";         break;
	    case 2: sRetTemplate = "zep_spidbloodbak";        break;
	    case 3: sRetTemplate = "spidervorpal";            break;
	    case 4: sRetTemplate = "zep_spidredback";            break;
	    case 5: sRetTemplate = "aranareina";            break;
	    case 6: sRetTemplate = "zep_spiddire";       break;
	    case 7: sRetTemplate = "zep_spiddire";      break;
	    case 8: sRetTemplate = "zep_spiddire";        break;


	    }
	  break;


        }
    }
  //*************************************end spiders **********************************//


  if (sTemplate == "scaled_magicalbeasts")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "nw_krenshar";   break;
	    case 2: sRetTemplate = "nw_krenshar";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "nw_krenshar";         break;
	    case 2: sRetTemplate = "zep_manticore";        break;
	    case 3: sRetTemplate = "zep_manticore";            break;
	    case 4: sRetTemplate = "kr_manticore";            break;
	    case 5: sRetTemplate = "zep_sphinxhier";            break;
	    case 6: sRetTemplate = "x0_gorgon";       break;


	    }
	  break;


        }
    }
  //****************end magicalbeasts **************************//

  if (sTemplate == "scaled_slimes")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "zep_blackpuddl";   break;
	    case 2: sRetTemplate = "zep_blackpuddl";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "zep_blackpuddl";         break;
	    case 2: sRetTemplate = "zep_brownpuddl";        break;
	    case 3: sRetTemplate = "zep_crystaloozel";            break;
	    case 4: sRetTemplate = "zep_greenslimes";            break;
	    case 5: sRetTemplate = "zep_greenslimes";            break;
	    case 6: sRetTemplate = "zep_greenslimes";       break;


	    }
	  break;


        }
    }
  //*************************end calsed_slimes *********************//



  if (sTemplate == "scaled_kobols")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "nw_kobold001";   break;
	    case 2: sRetTemplate = "nw_kobold001";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "nw_kobold004";         break;
	    case 2: sRetTemplate = "nw_kobold004";        break;
	    case 3: sRetTemplate = "nw_kobold005";            break;
	    case 4: sRetTemplate = "nw_kobold005";            break;
	    case 5: sRetTemplate = "nw_kobold001";            break;
	    case 6: sRetTemplate = "nw_kobold001";       break;


	    }
	  break;


        }
    }
  //******************************end scaled_kobolds**************************//






  if (sTemplate == "scaled_saguahin")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "nw_sahuagin";   break;
	    case 2: sRetTemplate = "nw_sahuagin";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "nw_sahuagin";         break;
	    case 2: sRetTemplate = "nw_sahuagin";        break;
	    case 3: sRetTemplate = "nw_sahuagin";            break;
	    case 4: sRetTemplate = "nw_sahuaginclr";            break;
	    case 5: sRetTemplate = "nw_sahuaginclr";            break;
	    case 6: sRetTemplate = "nw_sahuaginldr";       break;


	    }
	  break;


        }
    }

  //******************end saguahin******************//



  if (sTemplate == "scaled_troglo")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "nw_trog001";   break;
	    case 2: sRetTemplate = "nw_trog002";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "nw_trog001";         break;
	    case 2: sRetTemplate = "nw_trog002";        break;
	    case 3: sRetTemplate = "nw_trog003";            break;
	    case 4: sRetTemplate = "nw_trog001";            break;
	    case 5: sRetTemplate = "nw_trog002";            break;
	    case 6: sRetTemplate = "nw_trog001";       break;


	    }
	  break;


        }
    }
  //**********************end troglo*************************************************//




  if (sTemplate == "scaled_moredhel")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "elfo";   break;
	    case 2: sRetTemplate = "elfa";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "elfo";         break;
	    case 2: sRetTemplate = "elfa";        break;
	    case 3: sRetTemplate = "elfo";            break;
	    case 4: sRetTemplate = "elfa";            break;
	    case 5: sRetTemplate = "elfo";            break;
	    case 6: sRetTemplate = "elfa";       break;


	    }
	  break;


        }
    }
  //****end moredhel ********/



  if (sTemplate == "scaled_deathknights")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {
	case 9:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "deathknight002";   break;
	    case 2: sRetTemplate = "deathknight003";     break;

	    }
	  break;

	case 10:
	case 11:
	  switch (d6())
	    {
	    case 1: sRetTemplate = "deathknight002" ;         break;
	    case 2: sRetTemplate = "deathknight002";        break;
	    case 3: sRetTemplate = "deathknight003";            break;
	    case 4: sRetTemplate = "deathknight003";            break;
	    case 5: sRetTemplate = "deathknight002";            break;
	    case 6: sRetTemplate = "deathknight003";       break;
	    }
	  break;
	default:
	  sRetTemplate = ""; break;
	}
      
    }

  //*******************enmd death knights*******************************//


  if (sTemplate == "scaled_formian")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {

	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "x0_form_worker";   break;
	    case 2: sRetTemplate = "x0_form_worker";     break;

	    }
	  break;

	case 4 :
	case 5 :
	case 6 :
	case 7 :
	  
	  switch (d6())
	    {
	    case 1: sRetTemplate = "x0_form_worker" ;         break;
	    case 2: sRetTemplate = "x0_form_warrior";        break;
	    case 3: sRetTemplate = "x0_form_taskmast";            break;
	    case 4: sRetTemplate = "x0_form_mymarch";            break;
	    case 5: sRetTemplate = "x0_form_queen";            break;
	    case 6: sRetTemplate = "x0_form_warrior";       break;

	    }
	  break;
	default:
	  sRetTemplate = "x0_form_worker"; break;


        }
    }

  //*********************************************************************************************************//

  if (sTemplate == "scaled_stingers")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "x0_stinger";   break;
	    case 2: sRetTemplate = "x0_stinger";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "x0_stinger" ;         break;
	    case 2: sRetTemplate = "x0_stinger_war";        break;
	    case 3: sRetTemplate = "x0_stinger_chief";            break;
	    case 4: sRetTemplate = "x0_stinger_mage";            break;
	    case 5: sRetTemplate = "x0_stinger_war";            break;
	    case 6: sRetTemplate = "x0_stinger_war";       break;


	    }
	  break;


        }
    }
  //******************************************************************************************************//




  if (sTemplate == "scaled_mummy")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "nw_mummy";   break;
	    case 2: sRetTemplate = "nw_mummy";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "nw_mummy" ;         break;
	    case 2: sRetTemplate = "nw_mumcleric";        break;
	    case 3: sRetTemplate = "nw_mumfight";            break;
	    case 4: sRetTemplate = "nw_mumfight";            break;
	    case 5: sRetTemplate = "nw_mumfight";            break;
	    case 6: sRetTemplate = "nw_mumcleric";       break;


	    }
	  break;


        }
    }
  //***********************************************************************************************//




  if (sTemplate == "scaled_scorpions")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "zep_scorpg001";   break;
	    case 2: sRetTemplate = "zep_scorpg001";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "zep_scorpg001" ;         break;
	    case 2: sRetTemplate = "zep_scorpg003";        break;
	    case 3: sRetTemplate = "zep_scorph001";            break;
	    case 4: sRetTemplate = "zep_scorph003";            break;
	    case 5: sRetTemplate = "zep_scorph";            break;
	    case 6: sRetTemplate = "zep_scorph";       break;


	    }
	  break;


        }
    }
  //*****************************************************************************************//




  if (sTemplate == "war_goblins")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "trasgofrancot001";   break;
	    case 2: sRetTemplate = "trasgofrancotir";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "trasgofrancotir" ;         break;
	    case 2: sRetTemplate = "trasgofrancotir";        break;
	    case 3: sRetTemplate = "trasgofrancot001";            break;
	    case 4: sRetTemplate = "goblina001";  break;
	    case 5: sRetTemplate = "trasgofrancotir";            break;
	    case 6: sRetTemplate = "trasgofrancot001";       break;


	    }
	  break;


        }
    }
  //***************************************************************************//


  if (sTemplate == "Forest")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "zep_tree020";   break;
	    case 2: sRetTemplate = "zep_tree020";     break;

	    }
	  break;

	default  :
	  switch (d8())
	    {
	    case 1: sRetTemplate = "zep_tree020";         break;
	    case 2: sRetTemplate = "zep_tree024";        break;
	    case 3: sRetTemplate = "zep_tree028";            break;
	    case 4: sRetTemplate = "zep_tree064";            break;
	    case 5: sRetTemplate = "zep_tree023";            break;
	    case 6: sRetTemplate = "zep_tree058";       break;
	    case 7: sRetTemplate = "zep_tree058";      break;
	    case 8: sRetTemplate = "zep_tree023";        break;


	    }
	  break;


        }
    }
  //****************************************************************************//



  if (sTemplate == "shadow_wolf")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "shadowwolf02";   break;
	    case 2: sRetTemplate = "shadowwolf01";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "shadowwolf02" ;         break;
	    case 2: sRetTemplate = "shadowwolf02";        break;
	    case 3: sRetTemplate = "shadowwolf01";            break;
	    case 4: sRetTemplate = "shadowwolf01";            break;
	    case 5: sRetTemplate = "shadowwolf01";            break;
	    case 6: sRetTemplate = "shadowwolf02";       break;


	    }
	  break;


        }
    }


  //***********************************************************************//



  if (sTemplate == "nyla_shadow")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "nw_shadow";   break;
	    case 2: sRetTemplate = "nw_shfiend";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "nw_shfiend" ;         break;
	    case 2: sRetTemplate = "nw_shfiend";        break;
	    case 3: sRetTemplate = "nw_shfiend";            break;
	    case 4: sRetTemplate = "nw_shadow";            break;
	    case 5: sRetTemplate = "nw_shadow";            break;
	    case 6: sRetTemplate = "nw_shadow";       break;


	    }
	  break;


        }
    }
  //*************************************************************************//





  if (sTemplate == "goblin_group")
    {
      // Initialize Variables
      int nTotalPCs;
      int nTotalPCLevel;
      int nAveragePCLevel;
      object oArea = GetArea(OBJECT_SELF);

      // Cycle through PCs in Area
      object oPC = GetFirstObjectInArea(oArea);
      while (oPC != OBJECT_INVALID)
        {
	  if (GetIsPC(oPC) == TRUE)
            {
	      nTotalPCs++;
	      nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
	  oPC = GetNextObjectInArea(oArea);
        }
      if (nTotalPCs == 0)
        {
	  nAveragePCLevel = 0;
        }
      else
        {
	  nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

      // Select a Creature to Spawn
      switch (nAveragePCLevel)
        {



	case 1:
	  switch (d2())
	    {
	    case 1: sRetTemplate = "NW_GOBLINA";   break;
	    case 2: sRetTemplate = "NW_GOBLINB";     break;

	    }
	  break;

	default  :
	  switch (d6())
	    {
	    case 1: sRetTemplate = "NW_GOBLINA" ;         break;
	    case 2: sRetTemplate = "NW_GOBLINBOSS";        break;
	    case 3: sRetTemplate = "goblina001";            break;
	    case 4: sRetTemplate = "NW_GOBLINB";            break;
	    case 5: sRetTemplate = "NW_GOBWIZA";            break;
	    case 6: sRetTemplate = "NW_GOBWIZB";       break;


	    }
	  break;


        }
    }







  //*********************************************************************
  if (sTemplate == "undeadandboss")
    {
      int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
      if (nIsBossSpawned == TRUE)
        {
	  // Find the Boss
	  object oBoss = GetChildByTag(oSpawn, "deathknight001");

	  // Check if Boss is Alive
	  if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
	      // He's alive, spawn a Peon to keep him Company
	      sRetTemplate = "NW_ZOMBIEBOSS";
            }
	  else
            {
	      // He's dead, Deactivate Camp!
	      SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
      else
        {
	  // No Boss, so Let's Spawn Him
	  sRetTemplate = "NW_ZOMBIEBOSS";
	  SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }


  // -------------------------------------------
  // Only Make Modifications Between These Lines
  //
  return sRetTemplate;
}
