//HCR v.3.03b updates/fixes to 18th May, 2005 -
/*
 - SCRIPTS
   hc_play_on_rest
   hc_inc_wandering - new
   hc_on_heartbeat
   hc_defaults
   nw_ch_ac1
   nw_ch_ac7
   hc_on_play_death
   hc_fugue_enter

//HCR v.3.03b -

   The listed files/items/areas are the only thing that was added or changed
  between the versions listed, so to upgrade, you only need to copy or import
  those files. This should make upgrading much easier. This list does not
  include new objects or deleted scripts.

 - SCRIPTS
   About_Module
   Changed_Files
   hc_inc
   hc_defaults
   hc_on_cl_enter
   hc_on_equip - new
   hc_on_unequip - new
   hc_on_mod-load
   hc_on_acq_item
   hc_on_unacq_item
   hc_on_act_item
   hc_armor_encum - new - part of Racial and Armor movement speed system
   nw_c2_default9
   _cfg_goldencum - new - part of DoA Gold Encumberance
   gbl_pc_heartbeat - new - part of DoA Gold Encumberance
   doa_goldencum - new - part of DoA Gold Encumberance
   doa_gold_death - new - part of DoA Gold Encumberance
   doa_gold_used - new - part of DoA Gold Encumberance
   inc_givewtgold - new - part of DoA Gold Encumberance
   logmessage - new - part of OMW's Loot Notification
   omw_plns - new - Old Man Whistlers Loot Notification


// HCR v3.2.0 -

HCR 3.2
 - SCRIPTS:
   About_Module
   Changed_Files
   HC_C_ArmorRest
   HC_Defaults
   HC_Inc_DCorpse
   HC_Inc_Exp
   HC_InnRest
   HC_On_Cl_Enter
   HC_On_Mod_Load
   HC_On_Play_Rest
   HC_Open_DBag
   HC_Pal_DetEvil
   HC_Spell_Router
   HC_Take_Level
   HC_Version
   I_TagTests
   NW_C2_Default3
   NW_C2_Default7
   NW_C2_Default9
   NW_C2_StnkBtDie
   NW_CH_AC1
   NW_CH_AC7
   NW_CH_FM_ST_12
   NW_G0_Charm
   NW_G0_Confuse
   NW_G0_Dominate
   NW_G0_Fear
   NW_G0_Sleep
   NW_S0_GrRestore
   NW_S0_Heal
   NW_S0_Light
   NW_S0_MasHeal
   NW_S0_RaisDead
   NW_S0_Ressurec
   NW_S0_Restore
   NW_S0_Summon
   NW_S0_SummShad
   NW_S0_SummShad02
   NW_S1_BarbRage
   NW_S1_BltWeb
   NW_S2_AnimalCom
   NW_S2_Familiar
   NW_S2_TurnDead
   NW_S3_BalorDeth
   st_resetspells
   st_strip_talents
   WM_Include
   X0_I0_Spells
   X0_S0_FleshSto
   X0_S1_PetrBreath
   X0_S1_PetrGaze
   X0_S1_PetrTouch
   X2_Sig_State

HCR 3.1
SCRIPTS:
about_module
changed_files
crr_subrace_hc_i
hc_act_healkit
hc_act_potion
hc_bleeding
hc_db_close
hc_defaults
hc_do_raise
hc_do_respawn
hc_do_ress
hc_do_tress
hc_fugue_enter
hc_fugue_exit
hc_givexp
hc_inc
hc_inc_ability
hc_inc_htf
hc_inc_persist
hc_inc_remeff
hc_inc_remgood
hc_inc_respells
hc_inc_rezpen
hc_innrest
hc_npccorpsehc_npccorpse
hc_on_acq_item hc_on_cl_enter hc_on_heartbeat
hc_on_mod_load hc_on_play_death
hc_on_play_rest
hc_on_ply_dying
hc_on_ply_lvl_up
hc_on_unacq_item
hc_raise_dead
hc_ress
hc_storedbp
hc_strip_talents
hc_text_bleed
hc_trueress
i_tagtests
nw_c2_default1
nw_c2_default2
nw_c2_default3
nw_c2_default6
nw_c2_default7
nw_c2_default8
nw_ch_ac7
nw_ch_aca
nw_s0_aid
nw_s0_animdead
nw_s0_circdoom
nw_s0_curcrwn
nw_s0_curlgtw
nw_s0_curminw
nw_s0_curmodw
nw_s0_curserw
nw_s0_darknessa
nw_s0_darknessb
nw_s0_firestrm
nw_s0_firestrm
nw_s0_grrestore
nw_s0_heal
nw_s0_healcirc
nw_s0_invisib
nw_s0_lsdispel
nw_s0_masheal
nw_s0_mscharm
nw_s0_naturebal
nw_s0_raisdead
nw_s0_resserec
nw_s0_warcry
nw_s0_weird
nw_s2_familiar
nw_s2_layonhand  nw_walk_wp
wm_include
x0_i0_spells
x0_i0_walkway


HCR 3
SCRIPTS:

about_module 8/12/2003
changed_files 8/12/2003
dnd_inc_exp
hc_act_healkit
hc_act_pct
all hc_c_ scripts 8/3/2003
hc_bleeding 7/27/2003
hc_db_close 7/27/2003
hc_defaults 8/12/2003
hc_dmress
hc_do_raise
hc_do_ress
hc_do_ress
hc_do_tress
hc_drop_corpse
hc_drp_on_leave
hc_fugue_enter  7/27/2003
hc_fugue_exit
hc_id
hc_inc 7/27/2003
hc_inc_component
hc_inc_crmatcomp
hc_inc_dbagcheck 7/27/2003 new
hc_inc_dcorpse  8/12/2003
hc_inc_dropbag  8/12/2003
hc_inc_fatigue  7/17/2003
hc_inc_gods
hc_inc_persist  8/12/2003
hc_inc_remeff   8/12/2003
hc_inc_strip    8/12/2003
hc_inc_timecheck 8/12/2003
hc_inc_transfer
hc_npccorpse  7/27/2003
hc_on_act_item
hc_on_cl_enter  8/12/2003
hc_on_mod_load  8/12/2003
hc_on_play_death 8/12/2003
hc_on_ply_dying  8/12/2003
hc_on_play_rest   7/27/2003
hc_on_ply_lvl_up 8/12/2003
hc_on_unacq_item 8/12/2003
hc_on_usr_define 8/12/2003
hc_open_dbag   8/12/2003
hc_raise_dead 7/27/2003
hc_ress   7/27/2003
hc_storedb  8/12/2003
hc_store_bp 7/27/2003 new
hc_takexp
hc_take_level
hc_transfer_cont
hc_trueress 7/27/2003
hc_uneqp_plchest 8/3/2003
hc_version
nw_c2_default7 8/12/2003
nw_c2_default9
nw_c2_stnkbtdie  7/27/2003
nw_ch_ac1
nw_ch_ac7
all nw_s0_ spells 7/27/2003 overwrite all
nw_s0_darknessa 8/12/2003
nw_s0_darknessb 8/12/2003
nw_s0_grrestore 8/12/2003
nw_s0_lsdispel 8/12/2003
nw_s0_lsrestor 8/12/2003
nw_s0_restore 8/12/2003
nw_s3_balordeth  7/27/2003
all sei scripts 8/12/2003
subraces 8/12/2003
x0_i0_spells
x0_s1_petrbreath
x0_s1_petrgaze
x0_s1_petrtouch
all x0_s0_ spells
x0_s2_divshield
x0_s2_divmight



2.0 SR6.1
SCRIPTS:


about_module
dnd_level
hc_allwrest_entr
hc_allwrest_exit
hc_attackpc
hc_bleeding
hc_dc_close
hc_defaults
hc_drop_corpse
hc_drp_on_leave
hc_fugue_exit
hc_heal
hc_inc_component
hc_inc_remgood
hc_inc_transfer
hc_innrest
hc_on_cl_enter
hc_on_play_death
hc_on_play_rest
hc_on_ply_dying
hc_startcombat
hc_text_comp
hc_text_innrest
hc_text_rest
hc_used_dcrpse
nw_c2_default7
nw_i0_generic
nw_s0_animdead
nw_s0_circdeath
nw_s0_crgrund
nw_s0_crundead
nw_s0_delfirebal
nw_s0_grrestore
nw_s0_grstonesk
nw_s0_identify
nw_s0_mordswrd
nw_s0_raisdead
nw_s0_resserec
nw_s0_restore
nw_s0_shapechg
nw_s0_slow
nw_s0_stoneskn
nw_s0_truesee
nw_s2_layonhand
nw_s2_turndead
sei_xp
wm_include


2.0 SR6.0
SCRIPTS:

about_module
changed_files
hc_act_healkit
hc_attackpc
hc_bleeding
hc_do_respawn
hc_inc_exp
hc_inc_heal
hc_inc_rezpen
hc_on_act_item
hc_on_cl_enter
hc_on_play_death
hc_raise_dead
hc_ress
hc_takexp
new_make_fx
new_make_fxnd
nw_c2_default7
nw_s0_raisdead
nw_s0_resserec


2.0 SR5.5
SCRIPTS:

about_module
check_o0_act
hc_act_healkit
hc_act_potion
hc_allwrest_exit
hc_attackpc
hc_bleeding
hc_db_close
hc_defaults
hc_do_respawn
hc_fugue_enter
hc_givexp
hc_hb_trap
hc_hb_trigtrap
hc_heal
hc_inc_ability
hc_inc_death
hc_inc_gods
hc_inc_heal
hc_inc_remeff
hc_innrest
hc_npccorpse
hc_on_acq_item
hc_on_cl_enter
hc_on_mod_load
hc_on_play_death
hc_on_play_rest
hc_on_ply_dying
hc_on_ply_lvl_up
hc_on_unacq_item
hc_raise_dead
hc_rdisabled
hc_respawn
hc_ress
hc_text_ability
hc_text_activate
hc_text_bleed
hc_trueress
i_tagtests
nw_c2_default1
nw_c2_default2
nw_c2_default3
nw_c2_default4
nw_c2_default5
nw_c2_default6
nw_c2_default7
nw_c2_default8
nw_c2_defaultb
nw_ch_ac1
nw_ch_ac2
nw_ch_ac3
nw_ch_ac4
nw_ch_ac5
nw_ch_ac6
nw_ch_ac8
nw_ch_ac9
nw_ch_acb
nw_d1_templeheal
nw_i0_generic
nw_i0_plot
nw_i0_spells
nw_s0_curcrwn
nw_s0_curlgtw
nw_s0_curminw
nw_s0_curmodw
nw_s0_curserw
nw_s0_darknessb
nw_s0_heal
nw_s0_healcirc
nw_s0_light
nw_s0_lsrestor
nw_s0_masheal
nw_s0_raisdead
nw_s0_resserec
nw_s0_restore
nw_s1_bltweb
nw_s2_turndead
nw_s3_balordeth
sei_subraces
sei_subraceslst
sei_xp
subraces
wm_include

2.0 SR5.4
SCRIPTS:
all nw_s0 nw_s1 and nw_s2 scripts
about_module
changed_files
hc_act_healkit
hc_act_oilflask
hc_act_potion
hc_act_skinning
hc_bleeding
hc_close_npccorp
hc_cp_armorrest
hc_cp_rest
hc_c_lpguard
hc_c_plrest
hc_c_prest
hc_defaults
hc_dist_npcorpse
hc_fugue_enter
hc_hb_trap
hc_hb_trigtrap
hc_inc_ability
hc_inc_track
hc_inc_transfer
hc_npccorpse
hc_on_act_item
hc_on_cl_enter
hc_on_play_death
hc_on_play_rest
hc_on_ply_dying
hc_on_ply_respwn
hc_on_unacq_item
hc_raise_dead
hc_rdisabled
hc_respawn
hc_ress
hc_stand_guard
hc_takexp
hc_text_ability
hc_text_activate
hc_text_enter
hc_text_rest
hc_tinderbox
hc_transfer_cont
hc_trueress
hc_uneqp_plchest
hc_uneq_pchest
i_tagtests
jug_o0_spell
nw_c2_default1
nw_c2_default7
nw_ch_ac7
NW_I0_GENERIC
paus_i0_array


2.0 SR5.3
SCRIPTS:
all nw_s0 nw_s1 and nw_s2 scripts from spell addon.
about_spelltrk
changed_files
changed_files
hcrh_banpc
hcrh_resetpcreg
hc_act_healkit
hc_act_others
hc_act_thieftool
hc_allwrest_entr
hc_allwrest_exit
hc_bleeding
hc_clickcompstor
hc_c_armorrest
hc_db_close
hc_defaults
hc_dist_npcorpse
hc_fb_play_rest
hc_fugue_enter
hc_fugue_exit
hc_hb_charsave
hc_inc
hc_inc_ability
hc_inc_death
hc_inc_gods
hc_inc_htf
hc_inc_pwdb_func
hc_inc_rezpen
hc_inc_wandering
hc_innenter
hc_innrest
hc_innroom_enter
hc_npccorpse
hc_on_cl_enter
hc_on_cl_enter
hc_on_heartbeat
hc_on_play_death
hc_on_play_rest
hc_on_ply_dying
hc_on_ply_lvl_up
hc_on_ply_respwn
hc_on_usr_define
hc_raise_dead
hc_ress
hc_setareavars
hc_spell_track
hc_takexp
hc_take_level
hc_talk_lvltrain
hc_text_activate
hc_text_enter
hc_text_htf
hc_trueress
hc_used_lvltrain
inc_spell_track
nw_c2_default7
nw_ch_ac7
nw_s0_grrestore
nw_s0_knock
nw_s0_lsrestor
nw_s0_raisdead
nw_s0_resserec
nw_s0_restore
nw_s0_restore
nw_s1_barbrage
nw_s2_familiar
nw_s2_turndead
sei_subraces
sei_xp
st_resetspells
st_strip_talents
subraces
wm_include

DIALOG: changed hcrf dialog to add new options by Ragnar.

2.0 SR5.2
SCRIPTS:
about_module
changed_files
hchtf_enterwater
hc_act_thieftool
hc_cat_tt_disarm
hc_cat_tt_mark
hc_cat_tt_remove
hc_csc_ttc_dangr
hc_csc_ttc_easy
hc_csc_ttc_risky
hc_csc_ttc_safe
hc_csc_ttc_vdang
hc_c_armorrest
hc_c_rest
hc_defaults
hc_inc_rezpen
hc_on_cl_enter
hc_on_play_death
hc_on_play_rest
hc_on_ply_dying
hc_on_ply_lvl_up
hc_on_ply_respwn
hc_strip_spells
hc_takexp
hc_take_level
hc_text_activate
hc_text_health
hc_text_htf
hc_text_lvl
hc_text_rest
hc_text_traps
hc_unequip_chest
hc_used_dbag
nw_ch_ac7
nw_o2_trapdoor
nw_s0_lsrestor
nw_s0_restore

2.0 SR5.1
SCRIPTS:
about_module
changed_files
hc_bleeding
hc_con_loss
hc_con_loss1
hc_defaults
hc_fugue_enter
hc_inc_take_exp
hc_on_cl_enter
hc_on_play_death
hc_on_play_rest
hc_on_ply_dying

2.0 SR5
SCRIPTS:
about_module
changed_files
hchtf_enterwater
hc_act_others
hc_act_pct
hc_act_potion
hc_con_loss
hc_con_loss1
hc_defaults
hc_hb_charsave
hc_hb_deathcrps
hc_hb_dropbag
hc_inc_htf
hc_inc_rezpen
hc_inc_timecheck
hc_init_raised
hc_init_ress
hc_init_tress
hc_o2_trapdoor
hc_on_acq_item
hc_on_act_item
hc_on_cl_enter
hc_on_play_death
hc_on_play_rest
hc_on_ply_dying
hc_on_ply_lvl_up
hc_on_unacq_item
hc_open_dbag
hc_raise_dead
hc_ress
hc_ress_end
hc_talk_lvltrain
hc_trueress
hc_used_dcrpse
hc_used_lvltrain
hc_version
nw_s0_lsrestor
nw_s0_raisdead
nw_s0_resserec
nw_s0_restore

2.0 SR4
SCRIPT: about_module
SCRIPT: changed_files
SCRIPT: hc_act_thieftool
SCRIPT: hc_bleeding
SCRIPT: hc_cdrop_on_ent
SCRIPT: hc_drp_on_leave
SCRIPT: hc_hb_trigtrap
SCRIPT: hc_on_cl_enter
SCRIPT: hc_on_cl_leave
SCRIPT: hc_on_play_death
SCRIPT: hc_on_ply_dying
SCRIPT: hc_open_dbag
SCRIPT: hc_text_health
SCRIPT: i_tagtests



2.0 SR3
see readme


2.0 SR2
SCRIPT: about_module
SCRIPT: changed_files
SCRIPT: hc_act_others
SCRIPT: hc_act_pct
SCRIPT: hc_fugue_enter
SCRIPT: hc_fugue_exit
SCRIPT: hc_inc_transfer
SCRIPT: hc_on_acq_item
SCRIPT: hc_on_mod_load
SCRIPT: hc_on_unacq_item
SCRIPT: hc_on_usr_define
SCRIPT: hcrh_onconv
SCRIPT: i_tagtests
SCRIPT: nw_ch_ac7
SCRIPT: nw_s0_raisdead
SCRIPT: nw_s0_resserec
SCRIPT: nw_s2_familiar

2.0 SR1
SCRIPT: about_module
SCRIPT: changed_files
SCRIPT: hc_inc_transfer
SCRIPT: dnd_level
SCRIPT: dnd_inc_exp
SCRIPT: hc_on_acq_item
SCRIPT: nw_i0_generic
SCRIPT: hc_text_enter
SCRIPT: i_tagtests (NEW)

2.0.0
ITEM: Deleted all HCR Subrace items (from custom/special/custom 2)
ITEMS: Added 3 sei subrace items
SCRIPT: about_module
SCRIPT: changed_files
SCRIPT: hc_inc_subraces (DELETED)
SCRIPT: hc_inc_remeff
SCRIPT: hc_inc_transfer
SCRIPT: hc_act_pct
SCRIPT: hc_bleeding
SCRIPT: hc_defaults
SCRIPT: hc_on_play_rest
SCRIPT: hc_on_unacq_item
SCRIPT: hc_on_play_death
SCRIPT: hc_on_heartbeat
SCRIPT: hc_on_ply_lvl_up
SCRIPT: hc_on_ply_respwn
SCRIPT: hc_on_cl_enter
SCRIPT: hc_on_mod_load
SCRIPT: hc_used_lvltrain
SCRIPT: nw_c2_default1 (NEW)
SCRIPT: nw_c2_default2 (NEW)
SCRIPT: nw_c2_default3 (NEW)
SCRIPT: nw_c2_default4 (NEW)
SCRIPT: nw_c2_default5 (NEW)
SCRIPT: nw_c2_default6 (NEW)
SCRIPT: nw_c2_default7
SCRIPT: nw_c2_default8 (NEW)
SCRIPT: nw_c2_defaultb (NEW)
SCRIPT: nw_c2_stnkbtdie (NEW)
SCRIPT: nw_s3_balordeth (NEW)
SCRIPT: nw_d1_templeheal (NEW)
SCRIPT: nw_i0_plot (NEW)
SCRIPT: nw_s0_darknessa (NEW)
SCRIPT: nw_s0_darknessb (NEW)
SCRIPT: nw_s0_grrestore (NEW)
SCRIPT: nw_s0_lsrestor (NEW)
SCRIPT: nw_s0_restore (NEW)
SCRIPT: nw_s0_raisdead
SCRIPT: nw_s0_resserec
SCRIPTS: All SEI_ scripts  (NEW)

1.8.7
SCRIPT: about_module
SCRIPT: changed_files
SCRIPT: hc_act_pct
SCRIPT: hc_bleeding
SCRIPT: hc_defaults
SCRIPT: hc_fugue_enter
SCRIPT: hc_fugue_exit
SCRIPT: hc_inc_htf
SCRIPT: hc_inc_remeff
SCRIPT: hc_version (NEW)
SCRIPT: nw_s0_raisdead
SCRIPT: nw_s0_resserec

1.8.6
PLACEABLE: DyingCorpse (NEW)
SCRIPT: about_module
SCRIPT: changed_files
SCRIPT: hc_act_others
SCRIPT: hc_act_pct
SCRIPT: hc_defaults
SCRIPT: hc_inc_death
SCRIPT: hc_inc_htf
SCRIPT: hc_inc_htfvars
SCRIPT: hc_on_cl_enter
SCRIPT: hc_on_play_death
SCRIPT: hc_on_ply_dying
SCRIPT: nw_c2_default7
SCRIPT: nw_s0_raisdead

1.8.5
CONV: hcrhconv
SCRIPT: about_module
SCRIPT: changed_files
SCRIPT: hc_defaults
SCRIPT: hc_on_cl_enter
SCRIPT: hc_track_start
SCRIPT: hcrc_banpc (NEW)
SCRIPT: kcs_readme (DELETED - MOVED TO AN ADD-ON)
SCRIPT: kcs_userdef (DELETED - MOVED TO AN ADD-ON)
SCRIPT: kcs_template (DELETED - MOVED TO AN ADD-ON)


*/
void main(){}
