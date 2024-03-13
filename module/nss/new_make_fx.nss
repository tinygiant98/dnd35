// sr6.0
// modded for hcr.
// spell effect can be dispelled.
//:://////////////////////////////////////////////
//  EASY EFFECTS VERSION 3.0
//  March 16, 2003
//:://////////////////////////////////////////////

/*
Modified From Rob Bartel's Witch Wake module which was located by Hrun
the Barbarian.   Glendale Nights from the Bioware forums was a great help in
creating an initial framework for this script to work in.  Peter Poe
improved the original design and made it much, much more robust.  This last
update adds over 150 Fire N Forget effects.

Limitations:

These are are all technically spell effects so they can be dispelled.

Future Enhancements?

Alter the dispell spell scripts so that they do not dispell these effects?
I'm not sure if this is possible.

------------------

Standard FX (by Lost Dragon):

Give the "FX Maker" creature (found in custom creatures under Special Custom 1)
an FX number (listed below) for its tag.  As an example if you wanted to see
green circles, you'd give the creature a tag of 3.   Place the creature on your
map where you want the effect to show up.

------------------

Area FX Addon (by Peter Poe):

Give the "FX Maker" creature an Area FX number (listed below) for its tag,
preceded by an "a". By default, these area effects will be only decorative,
but you can change the event scripts (OnEnter,Heartbeat,OnExit) in the
EffectAreaOfEffect function below to make fire hurt, bugs bug, etc...
Example: for an AOE_PER_WALLFIRE (flames on the ground) effect, the tag
would be a5.

Waypoint usage:

If you want to create you FX on a different location than this creature's, create
a waypoint with a tag of "FXWP_" + the tag of this creature. The nearest waypoint
with the same tag will be chosen.

This is expecially useful to create effects on "non-walkable" locations.
Even though Visual FX work fine everywhere, Area FX seem to be "cut" around
non-walkable locations. Play with them anyway!
Example: to create green plants on a roof, give the FX Maker a tag of "2",
put a waypoint on the roof (or wherever you want), and give it a tag of "FXWP_2".

------------------

Fire N Forget FX Addon  (By Lost Dragon):

Fire N Forget FX are called from a trigger called FNF FX Maker.  The effects
are targeted at an invisible object called target_FNF_fx.  To use a Fire N Forget
FX, draw your FNF FX Maker trigger and place a target_FNF_fx placeable close
to it.  The tag of the FNF FX Maker trigger should be one of the FNF values
listed below (or see the trigger's comment tab).  As an example, to make a
lightning bolt I would use f75 as the trigger's tag.

------------------

List of standard effects that work with this script:

Standard FX NAME           FX Number (TAG)        Description

VFX_DUR_BLUR                    = 0               shimmer on floor
VFX_DUR_DARKNESS                = 1               blob of sheer darkness
VFX_DUR_ENTANGLE                = 2               green plant on floor
VFX_DUR_FREEDOM_OF_MOVEMENT     = 3               green intricate glowy circle
VFX_DUR_GLOBE_INVULNERABILITY   = 4               sphere with wiggly texture
VFX_DUR_MIND_AFFECTING_NEGATIVE = 7               3d spherical purple and white whirly flying dots
VFX_DUR_MIND_AFFECTING_POSITIVE = 8               white and blue twirling cone
VFX_DUR_GHOSTLY_VISAGE          = 9               slight blue shimmer on floor
VFX_DUR_ETHEREAL_VISAGE         = 10              purple shimmer on floor
VFX_DUR_PROT_BARKSKIN           = 11              sound but no graphic
VFX_DUR_PROT_GREATER_STONESKIN  = 12              sound but no graphic
VFX_DUR_PROT_PREMONITION        = 13              cloud of blue and purple dots and eyeballs
VFX_DUR_PROT_SHADOW_ARMOR       = 14              sound but no graphic
VFX_DUR_PROT_STONESKIN          = 15              sound but no graphic
VFX_DUR_SANCTUARY               = 16              dancing blue dots in cylindrical formation
VFX_DUR_WEB                     = 17              3d spider web formations
VFX_BEAM_LIGHTNING              = 73              plays sound but not graphic
VFX_DUR_PARALYZE_HOLD           = 82              field of white dots and white dancing cylinders
VFX_DUR_SPELLTURNING            = 138             circular lightning effect on floor
VFX_DUR_ELEMENTAL_SHIELD        = 147             circle of fire
VFX_DUR_LIGHT_BLUE_5            = 153             faint blue light
VFX_DUR_LIGHT_BLUE_10           = 154             faint xxxx light
VFX_DUR_LIGHT_BLUE_15           = 155                         "
VFX_DUR_LIGHT_BLUE_20           = 156                         "
VFX_DUR_LIGHT_YELLOW_5          = 157                         "
VFX_DUR_LIGHT_YELLOW_10         = 158                         "
VFX_DUR_LIGHT_YELLOW_15         = 159                         "
VFX_DUR_LIGHT_YELLOW_20         = 160                         "
VFX_DUR_LIGHT_PURPLE_5          = 161                         "
VFX_DUR_LIGHT_PURPLE_10         = 162                         "
VFX_DUR_LIGHT_PURPLE_15         = 163                         "
VFX_DUR_LIGHT_PURPLE_20         = 164                         "
VFX_DUR_LIGHT_RED_5             = 165                         "
VFX_DUR_LIGHT_RED_10            = 166                         "
VFX_DUR_LIGHT_RED_15            = 167                         "
VFX_DUR_LIGHT_RED_20            = 168                         "
VFX_DUR_LIGHT_ORANGE_5          = 169                         "
VFX_DUR_LIGHT_ORANGE_10         = 170                         "
VFX_DUR_LIGHT_ORANGE_15         = 171                         "
VFX_DUR_LIGHT_ORANGE_20         = 172                         "
VFX_DUR_LIGHT_WHITE_5           = 173                         "
VFX_DUR_LIGHT_WHITE_10          = 174                         "
VFX_DUR_LIGHT_WHITE_15          = 175                         "
VFX_DUR_LIGHT_WHITE_20          = 176                         "
VFX_DUR_LIGHT_GREY_5            = 177                         "
VFX_DUR_LIGHT_GREY_10           = 178                         "
VFX_DUR_LIGHT_GREY_15           = 179                         "
VFX_DUR_LIGHT_GREY_20           = 180                         "
VFX_DUR_MIND_AFFECTING_DISABLED = 208              blue and white floaty dots
VFX_DUR_MIND_AFFECTING_DOMINATED= 209              cylindrical blue, purple, & white rings that dance
VFX_BEAM_FIRE                   = 210              plays sound but not graphic
VFX_BEAM_COLD                   = 211                         "
VFX_BEAM_HOLY                   = 212                         "
VFX_BEAM_MIND                   = 213                         "
VFX_BEAM_EVIL                   = 214                         "
VFX_BEAM_ODD                    = 215                         "
VFX_BEAM_FIRE_LASH              = 216                         "
VFX_DUR_MIND_AFFECTING_FEAR     = 218              flaming flying skulls
VFX_DUR_GLOBE_MINOR             = 220              faint sphere - slightly pink
VFX_DUR_PROTECTION_ELEMENTS     = 224              ascending gold and white dots
VFX_DUR_PROTECTION_GOOD_MINOR   = 225              ascending gold dots
VFX_DUR_PROTECTION_GOOD_MAJOR   = 226              ascending gold streaks
VFX_DUR_PROTECTION_EVIL_MINOR   = 227              ascending red dots
VFX_DUR_PROTECTION_EVIL_MAJOR   = 228              ascending red streaks
VFX_DUR_MAGICAL_SIGHT           = 229              multi-colored floaty eyeballs
VFX_DUR_WEB_MASS                = 230              big spider webs on floor
VFX_DUR_PARALYZED               = 232              red and white glow on floor
VFX_DUR_ANTI_LIGHT_10           = 248              area darker & somewhat green
VFX_DUR_MAGIC_RESISTANCE        = 249              3d rings of spherical runes
VFX_DUR_AURA_COLD               = 267              big circle of dots in various colors
VFX_DUR_AURA_FIRE               = 268                       "
VFX_DUR_AURA_POISON             = 269                       "
VFX_DUR_AURA_DISEASE            = 270                       "
VFX_DUR_AURA_ODD                = 271                       "
VFX_DUR_AURA_SILENCE            = 272                       "
VFX_DUR_AURA_DRAGON_FEAR        = 291                       "
VFX_DUR_BARD_SONG               = 277              floaty music notes & song
VFX_DUR_FLAG_RED                = 303              flag model in colors
VFX_DUR_FLAG_BLUE               = 304                       "
VFX_DUR_FLAG_GOLD               = 305                       "
VFX_DUR_FLAG_PURPLE             = 306                       "
VFX_DUR_TENTACLE                = 346              dark thrashing tentacles

Area FX (note that a10 doesn't exist):

Constant:                       Tag:    Description:
AOE_PER_FOGACID                  a0     bright green fog
AOE_PER_FOGFIRE                  a1     fire fog
AOE_PER_FOGSTINK                 a2     dark green fog
AOE_PER_FOGKILL                  a3     red fog
AOE_PER_FOGMIND                  a4     blue fog
AOE_PER_WALLFIRE                 a5     flames from ground
AOE_PER_WALLWIND                 a6     no visible effect
AOE_PER_WALLBLADE                a7     spikes from ground
AOE_PER_WEB                      a8     webs
AOE_PER_ENTANGLE                 a9     green tentacles
AOE_PER_DARKNESS                 a11    complete darkness
AOE_MOB_CIRCEVIL                 a12    small circle of pink dots
AOE_MOB_CIRCGOOD                 a13    small circle of yellow dots
AOE_MOB_CIRCLAW                  a14    no visible effect
AOE_MOB_CIRCCHAOS                a15    no visible effect
AOE_MOB_FEAR                     a16    small circle of green dots
AOE_MOB_BLINDING                 a17    small circle of pink dots
AOE_MOB_UNEARTHLY                a18    small circle of green dots
AOE_MOB_MENACE                   a19    small circle of pink dots
AOE_MOB_UNNATURAL                a20    small circle of green dots
AOE_MOB_STUN                     a21    small circle of white dots
AOE_MOB_PROTECTION               a22    small circle of yellow dots
AOE_MOB_FIRE                     a23    small circle of orange dots
AOE_MOB_FROST                    a24    small circle light blue dots
AOE_MOB_ELECTRICAL               a25    small circle light blue dots
AOE_PER_FOGGHOUL                 a26    small area green fog
AOE_MOB_TYRANT_FOG               a27    medium area green fog
AOE_PER_STORM                    a28    green rain
AOE_PER_INVIS_SPHERE             a29    no visible effect
AOE_MOB_SILENCE                  a30    small circle of white dots
AOE_PER_DELAY_BLAST_FIREBALL     a31    yellow sparkles
AOE_PER_GREASE                   a32    black mist
AOE_PER_CREEPING_DOOM            a33    lots of bugs
AOE_PER_EVARDS_BLACK_TENTACLES   a34    black tentacles
AOE_MOB_INVISIBILITY_PURGE       a35    no visible effect
AOE_MOB_DRAGON_FEAR              a36    big circle of green dots

---------

Fire N Forget FX NAME         FX Number (TAG)      Description

VFX_FNF_BLINDDEAF               = f18              big cloud of white sparkles
VFX_FNF_DISPEL                  = f19              blue-white magic spiral
VFX_FNF_DISPEL_DISJUNCTION      = f20              purple-blue magic spiral
VFX_FNF_DISPEL_GREATER          = f21              cloudy white starburst
VFX_FNF_FIREBALL                = f22              fireball explosion
VFX_FNF_FIRESTORM               = f23              giant ring of fire
VFX_FNF_IMPLOSION               = f24              smaller ring of fire converges
VFX_FNF_METEOR_SWARM            = f28              meteor shower
VFX_FNF_NATURES_BALANCE         = f29              big green design - birds sing
VFX_FNF_PWKILL                  = f30              lightning and arcane symbol
VFX_FNF_PWSTUN                  = f31              purple spiral dots with white
VFX_FNF_SUMMON_GATE             = f32              3 rocks pop up with firey center
VFX_FNF_SUMMON_MONSTER_1        = f33              explosive white-grey cloud
VFX_FNF_SUMMON_MONSTER_2        = f34              purple symbol with spiral white things
VFX_FNF_SUMMON_MONSTER_3        = f35              white symbol with flames and purple stuff
VFX_FNF_SUMMON_UNDEAD           = f36              white plasma condensate
VFX_FNF_SUNBEAM                 = f37              great yellow sunbeam
VFX_FNF_TIME_STOP               = f38              big clocks
VFX_FNF_WAIL_O_BANSHEES         = f39              ghost woman pops out of ground and screams
VFX_FNF_WEIRD                   = f40              3 headed thing comes out of ground
VFX_FNF_WORD                    = f41              big yellow thing with rune strips
VFX_IMP_AC_BONUS                = f42              columnar cylindrical strips
VFX_IMP_ACID_L                  = f43              small green cloud (clipped on ground)
VFX_IMP_ACID_S                  = f44              smaller green cloud (ok on ground)
VFX_IMP_BLIND_DEAF_M            = f46              small spinny circle
VFX_IMP_BREACH                  = f47              small sparkly things
VFX_IMP_CONFUSION_S             = f48              very small sparkle
VFX_IMP_DAZED_S                 = f49              small white hemispheres with dots
VFX_IMP_DEATH                   = f50              glowy white ascension death
VFX_IMP_DISEASE_S               = f51              dark blob of bugs
VFX_IMP_DISPEL                  = f52              light blue sparkly cloud
VFX_IMP_DIVINE_STRIKE_FIRE      = f54              stream of fire from above
VFX_IMP_DIVINE_STRIKE_HOLY      = f55              white spiral downward
VFX_IMP_DOMINATE_S              = f56              small white hemispheres
VFX_IMP_DOOM                    = f57              small dark cloud with lightning
VFX_IMP_FLAME_M                 = f60              flame effect the size of a PC
VFX_IMP_FLAME_S                 = f61              tiny flash explosion with smoke
VFX_IMP_FROST_L                 = f62              blue explosion with freezy fx
VFX_IMP_FROST_S                 = f63              small white explosion with freezy
VFX_IMP_HASTE                   = f65              small blue star contracts
VFX_IMP_HEALING_G               = f66              yellow white and blue lines
VFX_IMP_HEALING_L               = f67              blue-n-white spiral cylinders
VFX_IMP_HEALING_M               = f68              white ball drips down to floor
VFX_IMP_HEALING_S               = f69              small blue-n-white cylinders
VFX_IMP_HEALING_X               = f70              big blue shaft of light
VFX_IMP_HOLY_AID                = f71              white spindle-star contracts
VFX_IMP_KNOCK                   = f72              spikey spindle star contracts
VFX_IMP_LIGHTNING_M             = f74              big bolt of lightning
VFX_IMP_LIGHTNING_S             = f75              small white spikey
VFX_IMP_MAGBLUE                 = f76              small white cloud blast
VFX_IMP_MAGBLUE2                = f77              bigger white cloud blast
VFX_IMP_MAGBLUE3                = f78               "
VFX_IMP_MAGBLUE4                = f79               "
VFX_IMP_MAGBLUE5                = f80               "
VFX_IMP_NEGATIVE_ENERGY         = f81              red ball and gas
VFX_IMP_POISON_L                = f83              green gas and squishy sound
VFX_IMP_POISON_S                = f84               "
VFX_IMP_POLYMORPH               = f85              green rays and clouds
VFX_IMP_PULSE_COLD              = f86              blue ring wave - fast
VFX_IMP_PULSE_FIRE              = f87              red     "
VFX_IMP_PULSE_HOLY              = f88               "
VFX_IMP_PULSE_NEGATIVE          = f89               "
VFX_IMP_RAISE_DEAD              = f90              skeleton arises from white cloud
VFX_IMP_REDUCE_ABILITY_SCORE    = f91              red contracting black aura
VFX_IMP_REMOVE_CONDITION        = f92              colorful confetti sparkles
VFX_IMP_SILENCE                 = f93              white contracting circles
VFX_IMP_SLEEP                   = f94              sleepy floaty Zzz's
VFX_IMP_SLOW                    = f95              purple contracting round star
VFX_IMP_SONIC                   = f96              rapidly contracting white rings
VFX_IMP_STUN                    = f97              sparkly white ball
VFX_IMP_SUNSTRIKE               = f98              explosive sun ball
VFX_IMP_UNSUMMON                = f99              pillar of light
VFX_COM_BLOOD_REG_WIMP          = f106             blinky red dot
VFX_COM_BLOOD_LRG_WIMP          = f107             bigger "
VFX_COM_BLOOD_CRT_WIMP          = f108             bigger still "
VFX_COM_BLOOD_REG_RED           = f109             small red dot
VFX_COM_BLOOD_REG_GREEN         = f110              "    xxx  "
VFX_COM_BLOOD_REG_YELLOW        = f111              "
VFX_COM_BLOOD_LRG_RED           = f112             dot
VFX_COM_BLOOD_LRG_GREEN         = f113              "
VFX_COM_BLOOD_LRG_YELLOW        = f114              "
VFX_COM_BLOOD_CRT_RED           = f115              "
VFX_COM_BLOOD_CRT_GREEN         = f116              "
VFX_COM_BLOOD_CRT_YELLOW        = f117              "
VFX_COM_SPARKS_PARRY            = f118             tiny spark
VFX_COM_CHUNK_RED_SMALL         = f121             small body chunk spew
VFX_COM_CHUNK_RED_MEDIUM        = f122             med "
VFX_COM_CHUNK_GREEN_SMALL       = f123             small green chunk spew
VFX_COM_CHUNK_GREEN_MEDIUM      = f124             med "
VFX_COM_CHUNK_YELLOW_SMALL      = f125             small yellow chunk spew
VFX_COM_CHUNK_YELLOW_MEDIUM     = f126             med "
VFX_IMP_IMPROVE_ABILITY_SCORE   = f139             small colorful upward spiral
VFX_IMP_CHARM                   = f140             small purple cloud
VFX_IMP_MAGICAL_VISION          = f141             small spiral with some dots
VFX_IMP_DEATH_WARD              = f146             purple flowy cylinder
VFX_IMP_MAGIC_PROTECTION        = f149             blue particle cloud that flows
VFX_IMP_SUPER_HEROISM           = f150             spikes of white light from ground
VFX_IMP_ELEMENTAL_PROTECTION    = f152             fire turns to green
VFX_FNF_SOUND_BURST             = f183             concussive blast with waves
VFX_FNF_STRIKE_HOLY             = f184             yellow shaft of light
VFX_FNF_LOS_EVIL_10             = f185             red and purple shaft goes up
VFX_FNF_LOS_EVIL_20             = f186             med red circle and shaft up
VFX_FNF_LOS_EVIL_30             = f187             big red circle and shaft up
VFX_FNF_LOS_HOLY_10             = f188             golden circle and shaft up
VFX_FNF_LOS_HOLY_20             = f189             med.  "
VFX_FNF_LOS_HOLY_30             = f190             big   "
VFX_FNF_LOS_NORMAL_10           = f191             fast white ring outward
VFX_FNF_LOS_NORMAL_20           = f192              "
VFX_FNF_LOS_NORMAL_30           = f193              "
VFX_IMP_HEAD_ACID               = f194             4 green blobs upward
VFX_IMP_HEAD_FIRE               = f195             4 red blobs upward
VFX_IMP_HEAD_SONIC              = f196             4 white blobs upward
VFX_IMP_HEAD_ELECTRICITY        = f197             4 electrical blobs
VFX_IMP_HEAD_COLD               = f198             4 xxx         "
VFX_IMP_HEAD_HOLY               = f199             4 "
VFX_IMP_HEAD_NATURE             = f200             4 "
VFX_IMP_HEAD_HEAL               = f201             4 "
VFX_IMP_HEAD_MIND               = f202             4 "
VFX_IMP_HEAD_EVIL               = f203             4 "
VFX_IMP_HEAD_ODD                = f204             4 "
VFX_IMP_DEATH_L                 = f217             white blob strained upwards
VFX_FNF_SUMMON_CELESTIAL        = f219             3 rocks from ground, light in middle
VFX_IMP_RESTORATION_LESSER      = f221             4 whispy white blobs
VFX_IMP_RESTORATION             = f222             blob disintegrates to particles
VFX_IMP_RESTORATION_GREATER     = f223             yellow and blue circling spiral
VFX_FNF_ICESTORM                = f231             great blue icycles from above
VFX_IMP_DESTRUCTION             = f234             screen bump, purple dot
VFX_COM_CHUNK_RED_LARGE         = f235             big red chunk spew
VFX_COM_CHUNK_BONE_MEDIUM       = f236             dusty bone spew
VFX_COM_BLOOD_SPARK_SMALL       = f237             small electrical spark
VFX_COM_BLOOD_SPARK_MEDIUM      = f238             med   "
VFX_COM_BLOOD_SPARK_LARGE       = f239             big   "
VFX_FNF_HORRID_WILTING          = f241             bog with firey spewers
VFX_IMP_HARM                    = f246             red light shaft from above
VFX_IMP_MAGIC_RESISTANCE_USE    = f250             small puff of smoke
VFX_IMP_GLOBE_USE               = f251             globe of white symbols
VFX_IMP_WILL_SAVING_THROW_USE   = f252             small blue dot flows up
VFX_IMP_SPIKE_TRAP              = f253             spikes from the ground
VFX_IMP_SPELL_MANTLE_USE        = f254             blue grid enclosure
VFX_IMP_FORTITUDE_SAVING_THROW_USE = f255          purple dot flows upward
VFX_IMP_REFLEX_SAVE_THROW_USE      = f256          green dot flows upward
VFX_FNF_GAS_EXPLOSION_ACID         = f257          green explosion and gas
VFX_FNF_GAS_EXPLOSION_EVIL         = f258          xxx explosion and gas
VFX_FNF_GAS_EXPLOSION_NATURE       = f259           "
VFX_FNF_GAS_EXPLOSION_FIRE         = f260           "
VFX_FNF_GAS_EXPLOSION_GREASE       = f261          black smoke upwards
VFX_FNF_GAS_EXPLOSION_MIND         = f262          blue explosion and gas
VFX_FNF_SMOKE_PUFF                 = f263          puff of grey smoke
VFX_IMP_PULSE_WATER                = f264          fast blue expand ring out
VFX_IMP_PULSE_WIND                 = f265           "   xxx
VFX_IMP_PULSE_NATURE               = f266           "   xxx
VFX_FNF_HOWL_MIND                  = f278          big expanding blue ring
VFX_FNF_HOWL_ODD                   = f279          expanding ring
VFX_COM_HIT_FIRE                   = f280          small fire effect
VFX_COM_HIT_FROST                  = f281          small ice effect
VFX_COM_HIT_ELECTRICAL             = f282           "     xxx "
VFX_COM_HIT_ACID                   = f283           "
VFX_COM_HIT_SONIC                  = f284           "
VFX_FNF_HOWL_WAR_CRY               = f285         expanding ring
VFX_FNF_SCREEN_SHAKE               = f286         screen shakes around(earthquake)
VFX_FNF_SCREEN_BUMP                = f287         screen bumps once
VFX_COM_HIT_NEGATIVE               = f288         small red dot
VFX_COM_HIT_DIVINE                 = f289         small yellow dot
VFX_FNF_HOWL_WAR_CRY_FEMALE        = f290         exploding large white ring out
*/


void main()
{
string sTag = GetTag(OBJECT_SELF);
int nEffect;
object oFXTarget;
effect eVisualFX;
location lFXLocation;

if (GetIsObjectValid(GetNearestObjectByTag("FXWP_" + sTag,OBJECT_SELF,1)) == TRUE) //Checks if FX has to be applied elsewhere (at the nearest waypoint with FXWP_*** tag)
    lFXLocation = GetLocation(GetNearestObjectByTag("FXWP_" + sTag,OBJECT_SELF,1));
else
    lFXLocation = GetLocation(OBJECT_SELF);

if (GetStringLeft(sTag, 1) == "a")  //Is this an Area FX...
     {
        if (GetStringLength(sTag) == 2)
            nEffect = StringToInt(GetStringRight(sTag,1));
        else
            nEffect = StringToInt(GetStringRight(sTag,2));
        //Remove "null","null","null" if you want the specified effect's default OnEnter, Heartbeat and OnExit scripts to run.
        eVisualFX = EffectAreaOfEffect(nEffect,"null","null","null");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eVisualFX,lFXLocation);
     }

else if (GetStringLeft(sTag, 1) == "f") //Is this a Fire-n-Forget FX...
     {
        if (GetStringLength(sTag) == 3)  // if tag is only 3 characters, just get the last two
            nEffect = StringToInt(GetStringRight(sTag,2));
        else
            nEffect = StringToInt(GetStringRight(sTag,3)); // otherwise it must be 3 numbers long so get all 3
        eVisualFX = EffectVisualEffect(nEffect);
        oFXTarget = GetNearestObjectByTag("target_FNF_fx");
        ApplyEffectToObject (DURATION_TYPE_TEMPORARY, eVisualFX, oFXTarget);
     }

     else // is it a standard Visual FX?
     {
        nEffect = StringToInt(sTag);
        eVisualFX = EffectVisualEffect(nEffect);
        oFXTarget = CreateObject(OBJECT_TYPE_PLACEABLE, "fxbox", lFXLocation);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisualFX,oFXTarget);
     }

DelayCommand(1.0, DestroyObject(OBJECT_SELF));  // leave this here if you want the npc/creature destroyed and the effect on the trigger to play only once
}

