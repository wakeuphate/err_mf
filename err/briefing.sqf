err_briefing_fnc_getBriefingForUnit = {
	params ["_unit"];

format["err\briefing\%1.sqf", str (side _unit)]
};

err_briefing_fnc_playerInit = {
	private _briefingFile = [player] call err_briefing_fnc_getBriefingForUnit;
	call compile _briefingFile;
};