// Allows admin to access debug console.
enableDebugConsole = 1;

// No respawning.
respawn = 1;

// Disables AI for playable units, and prevents AI from taking control of disconnected players.
// Fixes JIP, for some reason.
disabledAI = 1;

// Show AI kills on the scoreboard.
aiKills = 1;

// Disable teamSwitch.
enableTeamSwitch = 0;

// Disable saving.
saving = 0;

// Allow function recompilation in case of need to hotfix.
allowFunctionsRecompile = 1;

// Custom gear configs.
class Gear {
	#define SHORT_RANGE_RADIO "tf_anprc148jem"
	#define RIFLEMAN_RADIO "tf_anprc154"

	#include "gear\configs\RU.h"
	#include "gear\configs\USMC_WD.h"
	#include "gear\configs\USMC_D.h"
};

// Functions in cfgFunctions are loaded before the game begins, and can be used in unit init fields.
class cfgFunctions {
	class err_gear {
		class Assign {
			file = "err\gear";
			class assignGear {};
		};
	};
};
