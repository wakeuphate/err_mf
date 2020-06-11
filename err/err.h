// Allows admins + listed UUIDs to access debug console.
enableDebugConsole[] = {
	"76561198004407978"
};

// No respawning. Use Err_Spectator template for ACE/TFAR spectator.
respawn = 0;
respawnTemplates[] = {"Err_Spectator"};

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
#include "gear\gear.h"

// Functions in cfgFunctions are loaded before the game begins, and can be used in unit init fields.
class cfgFunctions {
	class err_gear {
		class Assign {
			file = "err\gear";
			class assignGear {};
		};
	};
};
