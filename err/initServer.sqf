[] call compile preProcessFileLineNumbers "err\utils.sqf";
[] call compile preProcessFileLineNumbers "err\aiSkills.sqf";
[] call compile preProcessFileLineNumbers "err\tfr.sqf";

// Disable mission saving.
enableSaving [false, false];

// Modify skills on any spawned AI groups.
[] spawn err_ai_fnc_aiSkillInit;

// Change frequencies for all players, based on side.
[] call err_tfr_fnc_serverInit;
