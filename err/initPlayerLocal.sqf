// Compile clientside functions.
[] call compile preProcessFileLineNumbers "err\briefing.sqf";
[] call compile preprocessFileLineNumbers "err\markers.sqf";
[] call compile preprocessFileLineNumbers "err\safety.sqf";
[] call compile preprocessFileLineNumbers "err\utils.sqf";

// Add side-specific briefings.
[] call err_briefing_fnc_playerInit;

// Start the group marker loop.
[] spawn err_markers_fnc_playerInit;

// Start the safety phase.
[] spawn err_safety_fnc_playerInit;
