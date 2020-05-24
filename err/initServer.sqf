[] call compile preProcessFileLineNumbers "err\utils.sqf";
[] call compile preProcessFileLineNumbers "err\aiSkills.sqf";

// Disable mission saving.
enableSaving [false, false];

// Modify skills on any spawned AI groups.
[] spawn err_ai_fnc_aiSkillLoop;