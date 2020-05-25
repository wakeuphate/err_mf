// Compile clientside functions.
[] call compile preProcessFileLineNumbers "err\briefing.sqf";
[] call compile preprocessFileLineNumbers "err\markers.sqf";
[] call compile preprocessFileLineNumbers "err\safety.sqf";
[] call compile preprocessFileLineNumbers "err\utils.sqf";

// Disable all voice channels and some text channels (Command, Vehicle, Direct, System).
0 enableChannel [true, false];
1 enableChannel [true, false];
2 enableChannel [false, false];
3 enableChannel [true, false];
4 enableChannel [false, false];
5 enableChannel [false, false];
6 enableChannel [false, false];

// Start the group marker loop.
[] spawn err_markers_fnc_playerInit;

// Start the safety phase.
[] spawn err_safety_fnc_playerInit;
