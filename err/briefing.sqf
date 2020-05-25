err_briefing_fnc_getBriefingForUnit = {
	params ["_unit"];

format["err\briefings\%1.sqf", str (side _unit)]
};

err_briefing_fnc_playerInit = {
	private _briefingFile = [player] call err_briefing_fnc_getBriefingForUnit;
	call compile preProcessFileLineNumbers _briefingFile;
};