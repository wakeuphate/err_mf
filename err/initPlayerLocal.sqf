// Compile clientside functions.
[] call compile preProcessFileLineNumbers "err\briefing.sqf";
[] call compile preprocessFileLineNumbers "err\markers.sqf";
[] call compile preprocessFileLineNumbers "err\safety.sqf";
[] call compile preprocessFileLineNumbers "err\utils.sqf";

// Disable mission saving.
enableSaving [false, false];

// Start the group marker loop.
[] spawn err_markers_fnc_playerInit;

// Start the safety phase.
[] spawn err_safety_fnc_playerInit;
