PWFXP XP Distribution Script V2.0
by Knat

  IMPORTANT: see pwfxp_def modifier definition script...

  check this link in case you want to discuss this script:
    http://www.thefold.org/nuke/modules.php?name=Forums&file=viewforum&f=69

  This is a more sophisticated XP distribution script geared towards PWs.
  It comes with two dozen XP modifiers to fine tune XP output and
  is losely based on the old but solid TTV XP script.

  here is a small example of features, all modifiers are scalable:

  - independent XP modifier for every single level. this breaks nwns linear
    XP progression and enables you to define your own progression function.
    you can give out fast xp early and let players slow down at any rate you want.
    or model your own odd progression function via manipulation of two constants

  - PCs suffer XP reduction if their level is not close enough to the average
    party level. level 1 grouping with level 10 is probably not a good idea...

  - PCs suffer XP reduction if their level is not close enough to the CR of the killed MOB
    (both directions independent now)

  - Adjustable & cached ECL modifiers, easy to sync with any subrace scripts

  - Group bonus. groups receive a small XP bonus (or big, if you wish) to encourage teamplay

  - Groupmembers need to be within minimum distance to the killed MOB if they want to receive XP

  - associates get a share of the xp, but you can set a different divisor for each associate type
    e.g.: henchman soak up more XP then animal companions

  - several counter exploit mechanisms included

  - many more features, see the constants...

  - easy to add new modifiers..

  all in all, this is pushing the nwn XP system more close to what you get in a MMORPG. You can
  make it very hard to level or easy as hell, with good control of group impact and flexible
  boundaries.

  system went through extensive beta tests at www.thefold.org - thanks to all the great
  players and staff there...

  ------------------------------------------------------------------------------------------
  --- USAGE --- --- USAGE --- --- USAGE --- --- USAGE --- --- USAGE ------------------------
  ------------------------------------------------------------------------------------------

  just add the following line to the onDeath script of your creatures (default: nw_c2_default7):

    ExecuteScript("pwfxp",OBJECT_SELF);

  Don't forget to set the XP-Scale slider to 0 (module properties)

  Open pwfxp_def and set the modifiers to your liking. you will also find infos on each
  modifier there...

  ATTENTION: HOW TO REMOVE THE DOUBLE XP MESSAGE !

  put this code above the pwfxp execution in your onDeath script

   // safety mechanism in case creature kills itself
   if(GetLastKiller() == OBJECT_SELF) return;

  put this code near the bottom of your onDeath script to remove the double-xp message
  thanks to spider661/Sotae for this catch...

    // resurrect & self kill to bypass bioware xp message
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10000, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), OBJECT_SELF);

  ------------------------------------------------------------------------------------------

  changelog:

  v2.00
  
  - upgraded version for nwvault release. no changes
    
    thanks for all the feedback via email or on our forums:
    http://www.thefold.org/nuke//modules.php?name=Forums&file=viewforum&f=69
    special thanks to www.thefold.org and its excellent playerbase

  v1.7 update (3/2004)

  - added PWFXP_MAXIMUM_XP constant due to user request...

  v1.62 update (2/2004)

  - fixed documentation error. using the wrong info could lead to divide by zero error

    if you want to eliminate mob CR < PC-Level reduction:
     set PWFXP_CR_LESSTHAN_PCLEVEL_REDUCTION to PWFXP_CR_MAX and
         PWFXP_CR_LESSTHAN_PCLEVEL_NOXP      to PWFXP_CR_MAX + 1

    if you want to eliminate mob CR > PC-Level reduction:
     set PWFXP_CR_GREATERTHAN_PCLEVEL_REDUCTION to PWFXP_CR_MAX and
         PWFXP_CR_GREATERTHAN_PCLEVEL_NOXP      to PWFXP_CR_MAX + 1

    if you want to eliminate Average Party Level reduction:
     set PWFXP_APL_REDUCTION to 40 and
         PWFXP_APL_NOXP to 41

    thanx to tribble for the catch

  v1.61 update(1/2004)

  - fixed minor naming convention error

  v1.6 update(1/2004)

  - improved XP divisor. you can now distinct between animal companion,
    familiar, dominated, summoned and henchman. you can set a different
    xp divisor for each of them. (default: henchman has max reduction impact followed
    by dominated, summoned, familiars, animal companion)

    see PWFXP_XP_DIVISOR_* constants

  - added PWFXP_USE_TOTAL_XP_TO_COMPUTE_PCLEVEL constant
    pc level gets computed based on the total XP instead of
    using GetLevelBy functions if set to TRUE. this way players ready to levelup
    can't bunker XP to gain better XP bonuses/modifiers.

  - removed dumb debug fragments, no more svirfneblin invasions...
    thanks to Beowulf for the catch...

  v1.5 update(12/2003)

  - improved ECL modifier: added caching to decrease cpu use
                           improved parser

  v1.4 update(12/2003)

  - removed constant PWFXP_CR_REDUCTION and PWFXP_CR_NOXP

  - added 4 new constants instead to distinct between..
      PC-Level > CR
      PC-Level < CR
    ..cases:

    PWFXP_CR_LESSTHAN_PCLEVEL_REDUCTION
    PWFXP_CR_LESSTHAN_PCLEVEL_NOXP
    PWFXP_CR_GREATERTHAN_PCLEVEL_REDUCTION
    PWFXP_CR_GREATERTHAN_PCLEVEL_NOXP

  - added PWFXP_USE_SETXP constant

  - split the script up. now all constants are isolated in their own
    definiton file (pwfxp_def). easier to update that way...

  v1.3 update (12/2003)

  - added PWFXP_LEVEL_MODIFIERS. this removes the linear xp output... read more below

  v1.2 update (10/2003)

  - killer gets excluded from distance check now if he *is* a PC.
    he gets XP even if his spell kills something far away (e.g. long range spells,
    damage over time spells. maybe traps, not tested so far. this does not include NPCs)
    every other groupmember gets still checked for distance...
    [thanks to telstar for the report/request...]

  v1.1 initial full release (10/2003)

  - fine tuned and slightly optimized code
  - added debug toggle

  v1.0 beta (8/2003):

  - distance check should now work correctly

  - minimum XP award (see new PWFXP_MINIMUM_XP constant)

  - henchman, familiars, animal companions, summoned creatures and other NPCs in a player
    group now take away XP. see PWFXP_XP_DIVISOR_PC and PWFXP_XP_DIVISOR_NPC constants

  - made it easier to manage ECL modifiers. see PWFXP_ECL_MODIFIERS string constant

