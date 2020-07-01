#include "HAL.h"

overviewPicture = "x\err\addons\err_main\data\loadscreen.paa";
loadScreen = "x\err\addons\err_main\data\loadscreen.paa";

// No respawning. Use err_spectator template for ACE/TFAR spectator.
respawn = 0;
respawnTemplates[] = {"err_spectator"};

// Disable all VON channels and certain text channels.
disableChannels[] = {
	{ 0, false, true },
	{ 1, false, true },
	{ 2, true, true },
	{ 3, false, true },
	{ 4, true, true },
	{ 5, true, true },
	{ 6, false, true },
};

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

// By default, corpses are not removed, they must be added using addToRemainsCollector.
// This is done automatically by HAL.
corpseManagerMode = 0;
corpseLimit = 30;
corpseRemovalMinTime = 120;
corpseRemovalMaxTime = 3600;
minPlayerDistance = 25;

// Wrecks are never removed.
wreckManagerMode = 0;
