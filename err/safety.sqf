err_safety_fnc_addAdminAction = {
	params ["_unit"];

	[
		_unit,
		"<t color='#F2E205'>ADMIN: Disable safety</t>",
		{
			err_safety_disabled = true;
			// JIP safe, run before init.sqf
			publicVariable "err_safety_disabled";
		},
		"_target == _this",
		1
	] call err_utils_fnc_addActionWithConfirmation;
};

err_safety_fnc_playerInit = {
	// In singleplayer, safety should not be enabled.
	if (!isMultiplayer) exitWith {
		hint "Safety was not enabled, as you are not on a dedicated server."
	};

	// Admin should be given a special action to control safestart.
	if (call BIS_fnc_admin > 0 || isServer) then {
		[player] call err_safety_fnc_addAdminAction;
	};

	// Destroy all nearby fired rounds (or grenades) while safety is enabled.
	private _ehHandle = player addEventHandler ["FiredMan", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

		deleteVehicle _projectile;
	}];

	// Wait until safety is disabled.
	private _timeInSafety = 0;
	waitUntil {
		hintSilent format["Safety is enabled. (%1 minutes)", floor(_timeInSafety / 60)];

		sleep 1;
		_timeInSafety = _timeInSafety + 1;

	(!isNil "err_safety_disabled") && {err_safety_disabled}
	};

	// Disable the event handler.
	player removeEventHandler ["FiredMan", _ehHandle];

	hint "Safety has been disabled!";
};