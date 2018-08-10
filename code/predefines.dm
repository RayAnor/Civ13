#define DEBUG

#define GAME_STATE_PREGAME		1
#define GAME_STATE_SETTING_UP	2
#define GAME_STATE_PLAYING		3
#define GAME_STATE_FINISHED		4

// Math constants.
#define M_E     2.71828183
#define M_PI    3.14159265
#define M_SQRT2 1.41421356

#define R_IDEAL_GAS_EQUATION       8.31    // kPa*L/(K*mol).
#define ONE_ATMOSPHERE             101.325 // kPa.
#define IDEAL_GAS_ENTROPY_CONSTANT 1164    // (mol^3 * s^3) / (kg^3 * L).

// Radiation constants.
#define STEFAN_BOLTZMANN_CONSTANT    5.6704e-8 // W/(m^2*K^4).
#define COSMIC_RADIATION_TEMPERATURE 3.15      // K.
#define AVERAGE_SOLAR_RADIATION      200       // W/m^2. Kind of arbitrary. Really this should depend on the sun position much like solars.
#define RADIATOR_OPTIMUM_PRESSURE    3771      // kPa at 20 C. This should be higher as gases aren't great conductors until they are dense. Used the critical pressure for air.
#define GAS_CRITICAL_TEMPERATURE     132.65    // K. The critical point temperature for air.

/*
	The pipe looks to be thin vertically and wide horizontally, so we'll assume that it's
	three centimeters thick, one meter wide, and only explosed to the sun 3 degrees off of edge-on.
	Since the radiatior is uniform along it's length, the ratio of surface area touched by sunlight
	to the total surface area is the same as the ratio of the perimeter of the cross-section.
*/
#define RADIATOR_EXPOSED_SURFACE_AREA_RATIO 0.04 // (3 cm + 100 cm * sin(3deg))/(2*(3+100 cm)). Unitless ratio.

#define CELL_VOLUME        2500 // Liters in a cell.
#define MOLES_CELLSTANDARD (ONE_ATMOSPHERE*CELL_VOLUME/(T20C*R_IDEAL_GAS_EQUATION)) // Moles in a 2.5 m^3 cell at 101.325 kPa and 20 C.

#define O2STANDARD 0.21 // Percentage.
#define N2STANDARD 0.79

#define MOLES_PHORON_VISIBLE 0.7 // Moles in a standard cell after which phoron is visible.
#define MOLES_O2STANDARD     (MOLES_CELLSTANDARD * O2STANDARD) // O2 standard value (21%)
#define MOLES_N2STANDARD     (MOLES_CELLSTANDARD * N2STANDARD) // N2 standard value (79%)

// These are for when a mob breathes poisonous air.
#define MIN_TOXIN_DAMAGE TRUE
#define MAX_TOXIN_DAMAGE 10

#define BREATH_VOLUME       0.5 // Liters in a normal breath.
#define BREATH_MOLES        (ONE_ATMOSPHERE * BREATH_VOLUME / (T20C * R_IDEAL_GAS_EQUATION)) // Amount of air to take a from a tile
#define BREATH_PERCENTAGE   (BREATH_VOLUME / CELL_VOLUME)                                    // Amount of air needed before pass out/suffocation commences.
#define HUMAN_NEEDED_OXYGEN (MOLES_CELLSTANDARD * BREATH_PERCENTAGE * 0.16)

#define SOUND_MINIMUM_PRESSURE 10

// Pressure limits.
#define  HAZARD_HIGH_PRESSURE 550 // This determines at what pressure the ultra-high pressure red icon is displayed. (This one is set as a constant)
#define WARNING_HIGH_PRESSURE 325 // This determines when the orange pressure icon is displayed (it is 0.7 * HAZARD_HIGH_PRESSURE)
#define NORMAL_PRESSURE  100
#define WARNING_LOW_PRESSURE  50  // This is when the gray low pressure icon is displayed. (it is 2.5 * HAZARD_LOW_PRESSURE)
#define  HAZARD_LOW_PRESSURE  20  // This is when the black ultra-low pressure icon is displayed. (This one is set as a constant)

#define TEMPERATURE_DAMAGE_COEFFICIENT  1.5 // This is used in handle_temperature_damage() for humans, and in reagents that affect body temperature. Temperature damage is multiplied by this amount.
#define BODYTEMP_AUTORECOVERY_DIVISOR   12  // This is the divisor which handles how much of the temperature difference between the current body temperature and 310.15K (optimal temperature) humans auto-regenerate each tick. The higher the number, the slower the recovery. This is applied each tick, so long as the mob is alive.
#define BODYTEMP_AUTORECOVERY_MINIMUM   TRUE   // Minimum amount of kelvin moved toward 310.15K per tick. So long as abs(310.15 - bodytemp) is more than 50.
#define BODYTEMP_COLD_DIVISOR           6   // Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is lower than their body temperature. Make it lower to lose bodytemp faster.
#define BODYTEMP_HEAT_DIVISOR           6   // Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is higher than their body temperature. Make it lower to gain bodytemp faster.
#define BODYTEMP_COOLING_MAX           -30  // The maximum number of degrees that your body can cool down in TRUE tick, when in a cold area.
#define BODYTEMP_HEATING_MAX            30  // The maximum number of degrees that your body can heat up in TRUE tick,   when in a hot  area.

#define BODYTEMP_HEAT_DAMAGE_LIMIT 360.15 // The limit the human body can take before it starts taking damage from heat.
#define BODYTEMP_COLD_DAMAGE_LIMIT 260.15 // The limit the human body can take before it starts taking damage from coldness.

#define SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // What min_cold_protection_temperature is set to for space-helmet quality headwear. MUST NOT BE 0.
#define   SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // What min_cold_protection_temperature is set to for space-suit quality jumpsuits or suits. MUST NOT BE 0.
#define       HELMET_MIN_COLD_PROTECTION_TEMPERATURE 160 // For normal helmets.
#define        ARMOR_MIN_COLD_PROTECTION_TEMPERATURE 160 // For armor.
#define       GLOVES_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // For some gloves.
#define         SHOE_MIN_COLD_PROTECTION_TEMPERATURE 2.0 // For shoes.

#define  SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE 5000  // These need better heat protect, but not as good heat protect as firesuits.
#define    FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE 30000 // What max_heat_protection_temperature is set to for firesuit quality headwear. MUST NOT BE 0.
#define FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE 30000 // For fire-helmet quality items. (Red and white hardhats)
#define      HELMET_MAX_HEAT_PROTECTION_TEMPERATURE 600   // For normal helmets.
#define       ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE 600   // For armor.
#define      GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE 1500  // For some gloves.
#define        SHOE_MAX_HEAT_PROTECTION_TEMPERATURE 1500  // For shoes.

// Fire.
#define FIRE_MIN_STACKS          -20
#define FIRE_MAX_STACKS           25
#define FIRE_MAX_FIRESUIT_STACKS  20 // If the number of stacks goes above this firesuits won't protect you anymore. If not, you can walk around while on fire like a badass.

#define THROWFORCE_SPEED_DIVISOR    5  // The throwing speed value at which the throwforce multiplier is exactly 1.
#define THROWNOBJ_KNOCKBACK_SPEED   15 // The minumum speed of a w_class 2 thrown object that will cause living mobs it hits to be knocked back. Heavier objects can cause knockback at lower speeds.
#define THROWNOBJ_KNOCKBACK_DIVISOR 2  // Affects how much speed the mob is knocked back with.

#define PRESSURE_DAMAGE_COEFFICIENT 4 // The amount of pressure damage someone takes is equal to (pressure / HAZARD_HIGH_PRESSURE)*PRESSURE_DAMAGE_COEFFICIENT, with the maximum of MAX_PRESSURE_DAMAGE.
#define    MAX_HIGH_PRESSURE_DAMAGE 4 // This used to be 20... I got this much random rage for some retarded decision by polymorph?! Polymorph now lies in a pool of blood with a katana jammed in his spleen. ~Errorage --PS: The katana did less than 20 damage to him :(
#define         LOW_PRESSURE_DAMAGE 2 // The amount of damage someone takes when in a low pressure area. (The pressure threshold is so low that it doesn't make sense to do any calculations, so it just applies this flat value).

// Doors!
#define DOOR_CRUSH_DAMAGE 10

#define HUNGER_FACTOR              0.05 // Factor of how fast mob nutrition decreases
#define REM 0.2 // Means 'Reagent Effect Multiplier'. This is how many units of reagent are consumed per tick
#define CHEM_TOUCH TRUE
#define CHEM_INGEST 2
#define CHEM_BLOOD 3
#define MINIMUM_CHEMICAL_VOLUME 0.01
#define SOLID TRUE
#define LIQUID 2
#define GAS 3
#define REAGENTS_OVERDOSE 30

#define MINIMUM_AIR_RATIO_TO_SUSPEND 0.05 // Minimum ratio of air that must move to/from a tile to suspend group processing
#define MINIMUM_AIR_TO_SUSPEND       (MOLES_CELLSTANDARD * MINIMUM_AIR_RATIO_TO_SUSPEND) // Minimum amount of air that has to move before a group processing can be suspended
#define MINIMUM_MOLES_DELTA_TO_MOVE  (MOLES_CELLSTANDARD * MINIMUM_AIR_RATIO_TO_SUSPEND) // Either this must be active
#define MINIMUM_TEMPERATURE_TO_MOVE  (T20C + 100)                                        // or this (or both, obviously)

#define MINIMUM_TEMPERATURE_RATIO_TO_SUSPEND      0.012        // Minimum temperature difference before group processing is suspended.
#define MINIMUM_TEMPERATURE_DELTA_TO_SUSPEND      4
#define MINIMUM_TEMPERATURE_DELTA_TO_CONSIDER     0.5          // Minimum temperature difference before the gas temperatures are just set to be equal.
#define MINIMUM_TEMPERATURE_FOR_SUPERCONDUCTION   (T20C + 10)
#define MINIMUM_TEMPERATURE_START_SUPERCONDUCTION (T20C + 200)

// Must be between FALSE and 1. Values closer to TRUE equalize temperature faster. Should not exceed 0.4, else strange heat flow occurs.
#define  FLOOR_HEAT_TRANSFER_COEFFICIENT 0.4
#define   WALL_HEAT_TRANSFER_COEFFICIENT 0.0
#define   DOOR_HEAT_TRANSFER_COEFFICIENT 0.0
#define  SPACE_HEAT_TRANSFER_COEFFICIENT 0.2 // A hack to partly simulate radiative heat.
#define   OPEN_HEAT_TRANSFER_COEFFICIENT 0.4
#define WINDOW_HEAT_TRANSFER_COEFFICIENT 0.1 // A hack for now.

// Fire damage.
#define CARBON_LIFEFORM_FIRE_RESISTANCE (T0C + 200)
#define CARBON_LIFEFORM_FIRE_DAMAGE     4

// Phoron fire properties.
#define PHORON_MINIMUM_BURN_TEMPERATURE    (T0C +  126) //400 K - autoignite temperature in tanks and canisters - enclosed environments I guess
#define PHORON_FLASHPOINT                  (T0C +  246) //519 K - autoignite temperature in air if that ever gets implemented.

//These control the mole ratio of oxidizer and fuel used in the combustion reaction
#define FIRE_REACTION_OXIDIZER_AMOUNT	3 //should be greater than the fuel amount if fires are going to spread much
#define FIRE_REACTION_FUEL_AMOUNT		2

//These control the speed at which fire burns
#define FIRE_GAS_BURNRATE_MULT			1
#define FIRE_LIQUID_BURNRATE_MULT		1

//If the fire is burning slower than this rate then the reaction is going too slow to be self sustaining and the fire burns itself out.
//This ensures that fires don't grind to a near-halt while still remaining active forever.
#define FIRE_GAS_MIN_BURNRATE			0.01
#define FIRE_LIQUD_MIN_BURNRATE			0.01

//How many moles of fuel are contained within one solid/liquid fuel volume unit
#define LIQUIDFUEL_AMOUNT_TO_MOL		1  //mol/volume unit

#define T0C  273.15 //    0.0 degrees celcius
#define T20C 293.15 //   20.0 degrees celcius
#define TCMB 2.7    // -270.3 degrees celcius

// XGM gas flags.
#define XGM_GAS_FUEL        TRUE
#define XGM_GAS_OXIDIZER    2
#define XGM_GAS_CONTAMINANT 4

#define TANK_LEAK_PRESSURE     (30.*ONE_ATMOSPHERE) // Tank starts leaking.
#define TANK_RUPTURE_PRESSURE  (40.*ONE_ATMOSPHERE) // Tank spills all contents into atmosphere.
#define TANK_FRAGMENT_PRESSURE (50.*ONE_ATMOSPHERE) // Boom 3x3 base explosion.
#define TANK_FRAGMENT_SCALE    (10.*ONE_ATMOSPHERE) // +1 for each SCALE kPa above threshold. Was 2 atm.

#define HUMAN_STRIP_DELAY        40   // Takes 40ds = 4s to strip someone.
#define ALIEN_SELECT_AFK_BUFFER  TRUE    // How many minutes that a person can be AFK before not being allowed to be an alien.
#define NORMPIPERATE             30   // Pipe-insulation rate divisor.
#define HEATPIPERATE             8    // Heat-exchange pipe insulation.
#define FLOWFRAC                 0.99 // Fraction of gas transfered per process.
#define SHOES_SLOWDOWN          -1.0  // How much shoes slow you down by default. Negative values speed you up.

// Item inventory slot bitmasks.
#define SLOT_OCLOTHING  TRUE
#define SLOT_ICLOTHING  2
#define SLOT_GLOVES     4
#define SLOT_EYES       8
#define SLOT_EARS       16
#define SLOT_MASK       32
#define SLOT_HEAD       64
#define SLOT_FEET       128
#define SLOT_ID         256
#define SLOT_BELT       512
#define SLOT_BACK       1024
#define SLOT_POCKET     2048  // This is to allow items with a w_class of 3 or 4 to fit in pockets.
#define SLOT_DENYPOCKET 4096  // This is to  deny items with a w_class of 2 or TRUE from fitting in pockets.
#define SLOT_TWOEARS    8192
#define SLOT_TIE        16384
#define SLOT_HOLSTER	32768 //16th bit

// Flags bitmasks.
#define STOPPRESSUREDAMAGE TRUE // This flag is used on the flags variable for SUIT and HEAD items which stop pressure damage. Note that the flag TRUE was previous used as ONBACK, so it is possible for some code to use (flags & TRUE) when checking if something can be put on your back. Replace this code with (inv_flags & SLOT_BACK) if you see it anywhere
                             // To successfully stop you taking all pressure damage you must have both a suit and head item with this flag.
#define NOBLUDGEON         2    // When an item has this it produces no "X has been hit by Y with Z" message with the default handler.
#define AIRTIGHT           4    // Functions with internals.
#define USEDELAY           8    // TRUE second extra delay on use. (Can be used once every 2s)
#define NOSHIELD           16   // Weapon not affected by shield.
#define CONDUCT            32   // Conducts electricity. (metal etc.)
#define ON_BORDER          64   // Item has priority to check when entering or leaving.
#define NOBLOODY           512  // Used for items if they don't want to get a blood overlay.
#define NODELAY            8192 // TRUE second attack-by delay skipped (Can be used once every 0.2s). Most objects have a TRUEs attack-by delay, which doesn't require a flag.

//Use these flags to indicate if an item obscures the specified slots from view, whereas body_parts_covered seems to be used to indicate what body parts the item protects.
#define GLASSESCOVERSEYES 256
#define    MASKCOVERSEYES 256 // Get rid of some of the other retardation in these flags.
#define    HEADCOVERSEYES 256 // Feel free to reallocate these numbers for other purposes.
#define   MASKCOVERSMOUTH 512 // On other items, these are just for mask/head.
#define   HEADCOVERSMOUTH 512

#define THICKMATERIAL          256  // From /tg/station: prevents syringes, parapens and hyposprays if the external suit or helmet (if targeting head) has this flag. Example: space suits, biosuit, bombsuits, thick suits that cover your body. (NOTE: flag shared with NOSLIP for shoes)
#define NOSLIP                 256  // Prevents from slipping on wet floors, in space, etc.
#define OPENCONTAINER          1024 // Is an open container for chemistry purposes.
#define BLOCK_GAS_SMOKE_EFFECT 2048 // Blocks the effect that chemical clouds would have on a mob -- glasses, mask and helmets ONLY! (NOTE: flag shared with ONESIZEFITSALL)
#define ONESIZEFITSALL         2048
#define PHORONGUARD            4096 // Does not get contaminated by phoron.
#define	NOREACT                4096 // Reagents don't react inside this container.
#define BLOCKHEADHAIR          4    // Temporarily removes the user's hair overlay. Leaves facial hair.
#define BLOCKHAIR              8192 // Temporarily removes the user's hair, facial and otherwise.

// Flags for pass_flags.
#define PASSTABLE  TRUE
#define PASSGLASS  2
#define PASSGRILLE 4
#define PASSBLOB   8

// Turf-only flags.
#define NOJAUNT TRUE // This is used in literally one place, turf.dm, to block ethereal jaunt.

// Bitmasks for the flags_inv variable. These determine when a piece of clothing hides another, i.e. a helmet hiding glasses.
// WARNING: The following flags apply only to the external suit!
#define HIDEGLOVES      TRUE
#define HIDESUITSTORAGE 2
#define HIDEJUMPSUIT    4
#define HIDESHOES       8
#define HIDETAIL        16

// WARNING: The following flags apply only to the helmets and masks!
#define HIDEMASK 1
#define HIDEEARS 2 // Headsets and such.
#define HIDEEYES 4 // Glasses.
#define HIDEFACE 8 // Dictates whether we appear as "Unknown".

// Slots.
#define slot_back        TRUE
#define slot_wear_mask   2
#define slot_handcuffed  3
#define slot_l_hand      4
#define slot_r_hand      5
#define slot_belt        6
#define slot_wear_id     7
#define slot_l_ear       8
#define slot_glasses     9
#define slot_gloves      10
#define slot_head        11
#define slot_shoes       12
#define slot_wear_suit   13
#define slot_w_uniform   14
#define slot_l_store     15
#define slot_r_store     16
#define slot_s_store     17
#define slot_in_backpack 18
#define slot_legcuffed   19
#define slot_r_ear       20
#define slot_legs        21
#define slot_tie         22
#define slot_l_arm       23
#define slot_r_arm       24

#define	R_HAND	0
#define L_HAND	1
#define R_ARM	2
#define L_ARM	3

// Inventory slot strings.
// since numbers cannot be used as associative list keys.
#define slot_back_str		"back"
#define slot_l_hand_str		"slot_l_hand"
#define slot_r_hand_str		"slot_r_hand"
#define slot_w_uniform_str	"w_uniform"
#define icon_head		"slot_head"

// Bitflags for clothing parts.
#define HEAD        TRUE
#define FACE        2
#define EYES        4
#define UPPER_TORSO 8
#define LOWER_TORSO 16
#define LEG_LEFT    32
#define LEG_RIGHT   64
#define LEGS        96   //  LEG_LEFT | LEG_RIGHT
#define FOOT_LEFT   128
#define FOOT_RIGHT  256
#define FEET        384  // FOOT_LEFT | FOOT_RIGHT
#define ARM_LEFT    512
#define ARM_RIGHT   1024
#define ARMS        1536 //  ARM_LEFT | ARM_RIGHT
#define HAND_LEFT   2048
#define HAND_RIGHT  4096
#define HANDS       6144 // HAND_LEFT | HAND_RIGHT
#define FULL_BODY   8191

// Bitflags for the percentual amount of protection a piece of clothing which covers the body part offers.
// Used with human/proc/get_heat_protection() and human/proc/get_cold_protection().
// The values here should add up to TRUE, e.g., the head has 30% protection.
#define THERMAL_PROTECTION_HEAD        0.3
#define THERMAL_PROTECTION_UPPER_TORSO 0.15
#define THERMAL_PROTECTION_LOWER_TORSO 0.15
#define THERMAL_PROTECTION_LEG_LEFT    0.075
#define THERMAL_PROTECTION_LEG_RIGHT   0.075
#define THERMAL_PROTECTION_FOOT_LEFT   0.025
#define THERMAL_PROTECTION_FOOT_RIGHT  0.025
#define THERMAL_PROTECTION_ARM_LEFT    0.075
#define THERMAL_PROTECTION_ARM_RIGHT   0.075
#define THERMAL_PROTECTION_HAND_LEFT   0.025
#define THERMAL_PROTECTION_HAND_RIGHT  0.025

// Bitflags for mutations.
#define STRUCDNASIZE 27
#define   UNIDNASIZE 13

// Generic mutations:
#define TK              TRUE
#define COLD_RESISTANCE 2
#define XRAY            3
#define HULK            4
#define CLUMSY          5
#define FAT             6
#define HUSK            7
#define NOCLONE         8
#define LASER           9  // Harm intent - click anywhere to shoot lasers from eyes.
#define HEAL            10 // Healing people with hands.

#define SKELETON      29
#define PLANT         30

// Other Mutations:
#define mNobreath      100 // No need to breathe.
#define mRemote        101 // Remote viewing.
#define mRegen         102 // Health regeneration.
#define mRun           103 // No slowdown.
#define mRemotetalk    104 // Remote talking.
#define mMorph         105 // Hanging appearance.
#define mBlend         106 // Nothing. (seriously nothing)
#define mHallucination 107 // Hallucinations.
#define mFingerprints  108 // No fingerprints.
#define mShock         109 // Insulated hands.
#define mSmallsize     110 // Table climbing.

// disabilities
#define NEARSIGHTED TRUE
#define EPILEPSY    2
#define COUGHING    4
#define TOURETTES   8
#define NERVOUS     16

// sdisabilities
#define BLIND TRUE
#define MUTE  2
#define DEAF  4

// /mob/var/stat things.
#define CONSCIOUS   0
#define UNCONSCIOUS 1
#define DEAD        2

// Channel numbers for power.
#define EQUIP   1
#define LIGHT   2
#define ENVIRON 3
#define TOTAL   4 // For total power used only.

// Bitflags for machine stat variable.
#define BROKEN   1
#define NOPOWER  2
#define POWEROFF 4  // TBD.
#define MAINT    8  // Under maintenance.
#define EMPED    16 // Temporary broken by EMP pulse.

// Bitmasks for door switches.
#define OPEN   1
#define IDSCAN 2
#define BOLTS  4
#define SHOCK  8
#define SAFE   16

// Metal sheets, glass sheets, and rod stacks.
#define MAX_STACK_AMOUNT_METAL 50
#define MAX_STACK_AMOUNT_GLASS 50
#define MAX_STACK_AMOUNT_RODS  60

#define GAS_O2  (1 << 0)
#define GAS_N2  (1 << 1)
#define GAS_PL  (1 << 2)
#define GAS_CO2 (1 << 3)
#define GAS_N2O (1 << 4)

#define IS_MODE_COMPILED(MODE) (ispath(text2path("/datum/game_mode/"+(MODE))))

// Damage things. TODO: Merge these down to reduce on defines.
// Way to waste perfectly good damage-type names (BRUTE) on this... If you were really worried about case sensitivity, you could have just used lowertext(damagetype) in the proc.
#define BRUTE     "brute"
#define BURN      "fire"
#define TOX       "tox"
#define OXY       "oxy"
#define CLONE     "clone"
#define HALLOSS   "halloss"

#define CUT       "cut"
#define BRUISE    "bruise"

#define STUN      "stun"
#define WEAKEN    "weaken"
#define PARALYZE  "paralize"
#define IRRADIATE "irradiate"
#define AGONY     "agony"     // Added in PAIN!
#define SLUR      "slur"
#define STUTTER   "stutter"
#define EYE_BLUR  "eye_blur"
#define DROWSY    "drowsy"

// I hate adding defines like this but I'd much rather deal with bitflags than lists and string searches.
#define BRUTELOSS TRUE
#define FIRELOSS  2
#define TOXLOSS   4
#define OXYLOSS   8

// Bitflags defining which status effects could be or are inflicted on a mob.
#define CANSTUN     TRUE
#define CANWEAKEN   2
#define CANPARALYSE 4
#define CANPUSH     8
#define LEAPING     16
#define PASSEMOTES  32    // Mob has a cortical borer or holders inside of it that need to see emotes.
#define GODMODE     4096
#define FAKEDEATH   8192  // Replaces stuff like changeling.changeling_fakedeath.
#define DISFIGURED  16384 // I'll probably move this elsewhere if I ever get wround to writing a bitflag mob-damage system.

// Grab levels.
#define GRAB_PASSIVE    TRUE
#define GRAB_AGGRESSIVE 2
#define GRAB_NECK       3
#define GRAB_UPGRADING  4
#define GRAB_KILL       5

// Security levels.
#define SEC_LEVEL_GREEN FALSE
#define SEC_LEVEL_BLUE  TRUE
#define SEC_LEVEL_RED   2
#define SEC_LEVEL_DELTA 3

#define TRANSITIONEDGE 7 // Distance from edge to move to another z-level.

// A set of constants used to determine which type of mute an admin wishes to apply.
// Please read and understand the muting/automuting stuff before changing these. MUTE_IC_AUTO, etc. = (MUTE_IC << 1)
// Therefore there needs to be a gap between the flags for the automute flags.
#define MUTE_IC        TRUE
#define MUTE_OOC       2
#define MUTE_PRAY      4
#define MUTE_ADMINHELP 8
#define MUTE_DEADCHAT  16
#define MUTE_MENTORHELP 32
#define MUTE_ALL       33

// Number of identical messages required to get the spam-prevention auto-mute thing to trigger warnings and automutes.
#define SPAM_TRIGGER_WARNING  5
#define SPAM_TRIGGER_AUTOMUTE 10

// Some constants for DB_Ban
#define BANTYPE_PERMA       TRUE
#define BANTYPE_TEMP        2
#define BANTYPE_JOB_PERMA   3
#define BANTYPE_JOB_TEMP    4
#define BANTYPE_ANY_FULLBAN 5 // Used to locate stuff to unban.

// Invisibility constants.
#define INVISIBILITY_LIGHTING             20
#define INVISIBILITY_LEVEL_ONE            35
#define INVISIBILITY_LEVEL_TWO            45
#define INVISIBILITY_OBSERVER             60
#define INVISIBILITY_EYE		          61

#define SEE_INVISIBLE_LIVING              25
#define SEE_INVISIBLE_OBSERVER_NOLIGHTING 45
#define SEE_INVISIBLE_LEVEL_ONE           35
#define SEE_INVISIBLE_LEVEL_TWO           45
#define SEE_INVISIBLE_OBSERVER            25

#define SEE_INVISIBLE_MINIMUM 5
#define INVISIBILITY_MAXIMUM 100

// Object specific defines.
#define CANDLE_LUM 3 // For how bright candles are.

//Some mob defines below
#define AI_CAMERA_LUMINOSITY 6

#define BORGMESON TRUE
#define BORGTHERM 2
#define BORGXRAY  4

// Some arbitrary defines to be used by self-pruning global lists. (see master_controller)
#define PROCESS_KILL 26 // Used to trigger removal from a processing list.

#define HOSTILE_STANCE_IDLE      TRUE
#define HOSTILE_STANCE_ALERT     2
#define HOSTILE_STANCE_ATTACK    3
#define HOSTILE_STANCE_ATTACKING 4
#define HOSTILE_STANCE_TIRED     5

#define ROUNDSTART_LOGOUT_REPORT_TIME 6000 // Amount of time (in deciseconds) after the rounds starts, that the player disconnect report is issued.

// Organ defines.
#define ORGAN_CUT_AWAY   TRUE
#define ORGAN_GAUZED     2
#define ORGAN_ATTACHABLE 4
#define ORGAN_BLEEDING   8
#define ORGAN_BROKEN     32
#define ORGAN_DESTROYED  64
#define ORGAN_ROBOT      128
#define ORGAN_SPLINTED   256
#define SALVED           512
#define ORGAN_DEAD       1024
#define ORGAN_MUTATED    2048
#define ORGAN_ASSISTED   4096

// Admin permissions. Please don't edit these values without speaking to Errorage first. ~Carn
#define R_BUILDMODE     TRUE
#define R_ADMIN         2
#define R_BAN           4
#define R_FUN           8
#define R_SERVER        16
#define R_DEBUG         32
#define R_POSSESS       64
#define R_PERMISSIONS   128
#define R_STEALTH       256
#define R_REJUVINATE    512
#define R_VAREDIT       1024
#define R_SOUNDS        2048
#define R_SPAWN         4096
#define R_MOD           8192
#define R_MENTOR        16384
#define R_HOST          32768

#define R_MAXPERMISSION 32768 // This holds the maximum value for a permission. It is used in iteration, so keep it updated.

// Preference toggles: these are no longer bitflags, but list items
#define SOUND_ADMINHELP TRUE
#define SOUND_MIDI      2
#define SOUND_AMBIENCE  4
#define SOUND_LOBBY     8
#define CHAT_OOC        16
#define CHAT_DEAD       32
#define CHAT_GHOSTEARS  64
#define CHAT_GHOSTSIGHT 128
#define CHAT_PRAYER     256
#define CHAT_RADIO      512
#define CHAT_ATTACKLOGS 1024
#define CHAT_DEBUGLOGS  2048
#define CHAT_LOOC       4096
#define CHAT_GHOSTRADIO 8192
#define SHOW_TYPING     16384
#define CHAT_NOICONS    32768

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|CHAT_OOC|CHAT_DEAD|CHAT_GHOSTEARS|CHAT_GHOSTSIGHT|CHAT_PRAYER|CHAT_RADIO|CHAT_ATTACKLOGS|CHAT_LOOC)


// Age limits on a character.
#define AGE_MIN 12
#define AGE_MAX 75

// Languages.
#define LANGUAGE_HUMAN  TRUE
#define LANGUAGE_DOG    2
#define LANGUAGE_CAT    4
#define LANGUAGE_BINARY 8
#define LANGUAGE_OTHER  32768

#define LANGUAGE_UNIVERSAL 65535

#define LEFT  TRUE
#define RIGHT 2

// Pulse levels, very simplified.
#define PULSE_NONE    FALSE // So !M.pulse checks would be possible.
#define PULSE_SLOW    TRUE // <60     bpm
#define PULSE_NORM    2 //  60-90  bpm
#define PULSE_FAST    3 //  90-120 bpm
#define PULSE_2FAST   4 // >120    bpm
#define PULSE_THREADY 5 // Occurs during hypovolemic shock
#define GETPULSE_HAND FALSE // Less accurate. (hand)
#define GETPULSE_TOOL TRUE // More accurate. (med scanner, sleeper, etc.)

// Species flags.
#define NO_BLOOD          TRUE     // Vessel var is not filled with blood, cannot bleed out.
#define NO_BREATHE        2     // Cannot suffocate or take oxygen loss.
#define NO_SCAN           4     // Cannot be scanned in a DNA machine/genome-stolen.
#define NO_PAIN           8     // Cannot suffer halloss/recieves deceptive health indicator.
#define NO_SLIP           16    // Cannot fall over.
#define NO_POISON         32    // Cannot not suffer toxloss.
#define HAS_SKIN_TONE     64    // Skin tone selectable in chargen. (0-255)
#define HAS_SKIN_COLOR    128   // Skin colour selectable in chargen. (RGB)
#define HAS_LIPS          256   // Lips are drawn onto the mob icon. (lipstick)
#define HAS_UNDERWEAR     512   // Underwear is drawn onto the mob icon.
#define IS_PLANT          1024  // Is a treeperson.
#define IS_WHITELISTED    2048  // Must be whitelisted to play.
#define IS_SYNTHETIC      4096  // Is a machine race.
#define HAS_EYE_COLOR     8192  // Eye colour selectable in chargen. (RGB)
#define CAN_JOIN          16384 // Species is selectable in chargen.
#define IS_RESTRICTED     32768 // Is not a core/normally playable species. (castes, mutantraces)
#define REGENERATES_LIMBS 65536 // Attempts to regenerate unamputated limbs.

// Language flags.
#define WHITELISTED TRUE   // Language is available if the speaker is whitelisted.
#define RESTRICTED  2   // Language can only be accquired by spawning or an admin.
#define NONVERBAL   4   // Language has a significant non-verbal component. Speech is garbled without line-of-sight.
#define SIGNLANG    8   // Language is completely non-verbal. Speech is displayed through emotes for those who can understand.
#define HIVEMIND    16  // Broadcast to all mobs with this language.
#define NONGLOBAL   32  // Do not add to general languages list.
#define INNATE      64  // All mobs can be assumed to speak and understand this language. (audible emotes)
#define NO_TALK_MSG 128 // Do not show the "\The [speaker] talks into \the [radio]" message
#define NO_STUTTER  256 // No stuttering, slurring, or other speech problems
#define COMMON_VERBS 512 // Robots will apply regular verbs to this.
//Flags for zone sleeping
#define ZONE_ACTIVE   TRUE
#define ZONE_SLEEPING FALSE

//some colors
#define COLOR_RED    "#FF0000"
#define COLOR_GREEN  "#00FF00"
#define COLOR_BLUE   "#0000FF"
#define COLOR_CYAN   "#00FFFF"
#define COLOR_PINK   "#FF00FF"
#define COLOR_YELLOW "#FFFF00"
#define COLOR_ORANGE "#FF9900"
#define COLOR_WHITE  "#FFFFFF"
#define COLOR_BLACK  "#000000"
#define COLOR_LIGHT_BLUE "#4242F0"

/*
 *	Germs and infections.
*/

#define GERM_LEVEL_AMBIENT  110 // Maximum germ level you can reach by standing still.
#define GERM_LEVEL_MOVE_CAP 200 // Maximum germ level you can reach by running around.

#define INFECTION_LEVEL_ONE   100
#define INFECTION_LEVEL_TWO   500
#define INFECTION_LEVEL_THREE 1000

// Special return values from bullet_act(). Positive return values are already used to indicate the blocked level of the projectile.
#define PROJECTILE_CONTINUE   -1 //if the projectile should continue flying after calling bullet_act()
#define PROJECTILE_FORCE_MISS -2 //if the projectile should treat the attack as a miss (suppresses attack and admin logs) - only applies to mobs.

#define MAX_GEAR_COST 5 // Used in chargen for accessory loadout limit.

/*
 *	Atmospherics Machinery.
*/
#define MAX_SIPHON_FLOWRATE   2500 // L/s. This can be used to balance how fast a room is siphoned. Anything higher than CELL_VOLUME has no effect.
#define MAX_SCRUBBER_FLOWRATE 200  // L/s. Max flow rate when scrubbing from a turf.

// These balance how easy or hard it is to create huge pressure gradients with pumps and filters.
// Lower values means it takes longer to create large pressures differences.
// Has no effect on pumping gasses from high pressure to low, only from low to high.
#define ATMOS_PUMP_EFFICIENCY   2.5
#define ATMOS_FILTER_EFFICIENCY 2.5

// Will not bother pumping or filtering if the gas source as fewer than this amount of moles, to help with performance.
#define MINIMUM_MOLES_TO_PUMP   0.01
#define MINIMUM_MOLES_TO_FILTER 0.1

// The flow rate/effectiveness of various atmos devices is limited by their internal volume,
// so for many atmos devices these will control maximum flow rates in L/s.
#define ATMOS_DEFAULT_VOLUME_PUMP   200 // Liters.
#define ATMOS_DEFAULT_VOLUME_FILTER 200 // L.
#define ATMOS_DEFAULT_VOLUME_MIXER  200 // L.
#define ATMOS_DEFAULT_VOLUME_PIPE   70  // L.

// Chemistry.
#define CHEM_SYNTH_ENERGY 500 // How much energy does it take to synthesize TRUE unit of chemical, in Joules.

#define SPEED_OF_LIGHT       3e8    // Approximate.
#define SPEED_OF_LIGHT_SQ    9e16
#define FIRE_DAMAGE_MODIFIER 0.0215 // Higher values result in more external fire damage to the skin. (default 0.0215)
#define  AIR_DAMAGE_MODIFIER 2.025  // More means less damage from hot air scalding lungs, less = more damage. (default 2.025)
#define INFINITY             1.#INF
#define BACKGROUND_ENABLED   FALSE      // The default value for all uses of set background. Set background can
                                    // cause gradual lag and is recommended you only turn this on if necessary.
                                    // TRUE will enable set background. FALSE will disable set background.

// Setting this much higher than 1024 could allow spammers to DOS the server easily.
#define MAX_MESSAGE_LEN       1024
#define MAX_PAPER_MESSAGE_LEN 3072
#define MAX_BOOK_MESSAGE_LEN  9216
#define MAX_LNAME_LEN         64
#define MAX_NAME_LEN          45 // long german names and stuff

// Event defines.
#define EVENT_LEVEL_MUNDANE  TRUE
#define EVENT_LEVEL_MODERATE 2
#define EVENT_LEVEL_MAJOR    3

// NanoUI flags
#define STATUS_INTERACTIVE 2 // GREEN Visability
#define STATUS_UPDATE TRUE // ORANGE Visability
#define STATUS_DISABLED FALSE // RED Visability
#define STATUS_CLOSE -1 // Close the interface

//General-purpose life speed define for plants.
#define HYDRO_SPEED_MULTIPLIER TRUE
/*

#define BOMBCAP_DVSTN_RADIUS (max_explosion_range/4)
#define BOMBCAP_HEAVY_RADIUS (max_explosion_range/2)
#define BOMBCAP_LIGHT_RADIUS max_explosion_range
#define BOMBCAP_FLASH_RADIUS (max_explosion_range*1.5)
*/
#define DEFAULT_JOB_TYPE /datum/job/civilian

// Appearance change flags
#define APPEARANCE_UPDATE_DNA TRUE
#define APPEARANCE_RACE	(2|APPEARANCE_UPDATE_DNA)
#define APPEARANCE_GENDER (4|APPEARANCE_UPDATE_DNA)
#define APPEARANCE_SKIN 8
#define APPEARANCE_HAIR 16
#define APPEARANCE_HAIR_COLOR 32
#define APPEARANCE_FACIAL_HAIR 64
#define APPEARANCE_FACIAL_HAIR_COLOR 128
#define APPEARANCE_EYE_COLOR 256
#define APPEARANCE_ALL_HAIR (APPEARANCE_HAIR|APPEARANCE_HAIR_COLOR|APPEARANCE_FACIAL_HAIR|APPEARANCE_FACIAL_HAIR_COLOR)
#define APPEARANCE_ALL 511


#define MIN_SUPPLIED_LAW_NUMBER 15
#define MAX_SUPPLIED_LAW_NUMBER 50

//Area flags, possibly more to come
#define RAD_SHIELDED TRUE //shielded from radiation, clearly

//intent flags, why wasn't this done the first time?
#define I_HELP		"help"
#define I_DISARM	"disarm"
#define I_GRAB		"grab"
#define I_HURT		"hurt"
#define I_DODGE		"dodge"
#define I_PARRY		"parry"

/*
	These are used Bump() code for living mobs, in the mob_bump_flag, mob_swap_flags, and mob_push_flags vars to determine whom can bump/swap with whom.
*/

#define HUMAN TRUE
#define MONKEY 2
#define SIMPLE_ANIMAL 4


#define ALLMOBS (HUMAN|MONKEY|SIMPLE_ANIMAL)

#define NEXT_MOVE_DELAY 8

#define DROPLIMB_EDGE TRUE
#define DROPLIMB_BLUNT TRUE
#define DROPLIMB_BURN 2


#define WALL_CAN_OPEN TRUE
#define WALL_OPENING 2

//#define Clamp(x, y, z) 	(x <= y ? y : (x >= z ? z : x))

//#define CLAMP01(x) 		(Clamp(x, 0, 1))

#define DEFAULT_WALL_MATERIAL "steel"
#define DEFAULT_TABLE_MATERIAL "plastic"

// Convoluted setup so defines can be supplied by Bay12 main server compile script.
// Should still work fine for people jamming the icons into their repo.
#ifndef CUSTOM_ITEM_OBJ
#define CUSTOM_ITEM_OBJ 'icons/obj/custom_items_obj.dmi'
#endif
#ifndef CUSTOM_ITEM_MOB
#define CUSTOM_ITEM_MOB 'icons/mob/custom_items_mob.dmi'
#endif
/*
#ifndef CUSTOM_ITEM_ROBOT
#define CUSTOM_ITEM_ROBOT 'icons/mob/custom_synthetic.dmi'
#endif*/

//default item on-mob icons
#define INV_HEAD_DEF_ICON 'icons/mob/head.dmi'
#define INV_BACK_DEF_ICON 'icons/mob/back.dmi'
#define INV_L_HAND_DEF_ICON 'icons/mob/items/lefthand.dmi'
#define INV_R_HAND_DEF_ICON 'icons/mob/items/righthand.dmi'
#define INV_W_UNIFORM_DEF_ICON 'icons/mob/uniform.dmi'
#define INV_ACCESSORIES_DEF_ICON 'icons/mob/ties.dmi'

#define SHARD_SHARD "shard"
#define SHARD_SHRAPNEL "shrapnel"
#define SHARD_STONE_PIECE "piece"
#define SHARD_SPLINTER "splinters"
#define SHARD_NONE ""

#define MATERIAL_UNMELTABLE TRUE
#define MATERIAL_BRITTLE 2
#define MATERIAL_PADDING 4

#define TABLE_BRITTLE_MATERIAL_MULTIPLIER 4 // Amount table damage is multiplied by if it is made of a brittle material (e.g. glass)

#define FOR_DVIEW(type, range, center, invis_flags) \
	dview_mob.loc = center; \
	dview_mob.see_invisible = invis_flags; \
	for (type in view(range, dview_mob))
#define END_FOR_DVIEW dview_mob.loc = null