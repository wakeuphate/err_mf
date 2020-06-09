err_utils_fnc_addActionWithConfirmation = {
	params ["_unit", "_title", "_code", "_condition", "_distance"];

	private _initialActionCode = {
		params ["_unit", "_caller", "_actionId", "_initialArgs"];
		_initialArgs params ["_unit", "_title", "_code", "_condition", "_distance"];

		// Add confirmation action.
		private _confirmActionId = _unit addAction ["<t color='#F2E205'>Confirm</t>", {
			params ["_unit", "_caller", "_actionId", "_code"];

			_unit removeAction _actionId;

			// Run the user code.
			call _code;
		}, _code, 1, false, false, "", _condition, _distance];

		// Add cancel action.
		private _cancelActionId = _unit addAction ["<t color='#F20505'>Cancel</t>", {
			params ["_unit", "_caller", "_actionId", "_initialArgs"];

			_unit removeAction _actionId;

			// Recurse with the initial user provided args.
			_initialArgs call err_utils_fnc_addActionWithConfirmation;
		}, _initialArgs, 1, false, false, "", _condition, _distance];

		_unit removeAction _actionId;

		// Actions are scheduled, so we can just wait for the user to select an option and then remove all remaining actions.
		// All of this awkwardness is done to avoid any globals / unit variables.
		waitUntil{!(_confirmActionId in (actionIDs _unit)) || !(_cancelActionId in (actionIDs _unit))};

		// Remove any leftover actions.
		_unit removeAction _confirmActionId;
		_unit removeAction _cancelActionId;
	};

	_unit addAction [_title, _initialActionCode, _this, 1, false, false, "", _condition, _distance];
};

err_utils_fnc_getUnitGearInfo = {
	params ["_unit"];

	private _text = [
		format["primaryWeapon: %1", primaryWeapon _unit],
		format["secondaryWeapon: %1", secondaryWeapon _unit],
		format["handgunWeapon: %1", handgunWeapon _unit],
		format["Uniform: %1", uniform _unit],
		format["uniformItems: %1", uniformItems _unit],
		format["Vest: %1", vest _unit],
		format["vestItems: %1", vestItems _unit],
		format["Backpack: %1", backpack _unit],
		format["backpackItems: %1", backpackItems _unit],
		format["Items: %1", items _unit]
	];

	hintC _text;

_text
};

err_utils_audio_client_fnc_stopPlaying = {
	params ["_object"];

	private _sound = nearestObject [position _object, "#soundonvehicle"];
	deleteVehicle _sound;
};

err_utils_audio_client_fnc_startPlaying = {
	params ["_object", "_sound"];

	_object say3D _sound;
};

err_utils_audio_client_fnc_addActionsToObject = {
	params ["_object", "_sound", ["_condition", "true"]];

	_object addAction [
		"Play",
		{
			params ["_target", "_caller", "_actionId", "_sound"];

			[_target, _sound] remoteExec ["err_audio_client_fnc_startPlaying", 0];
			_target setVariable ["err_audio_playing", true, true];
		},
		_sound,
		1,
		false,
		true,
		"",
		format["!(_target getVariable ['err_audio_playing', false]) && (%1)", _condition],
		3
	];

	_object addAction [
		"Stop",
		{
			params ["_target", "_caller", "_actionId"];

			[_target] remoteExec ["err_audio_client_fnc_stopPlaying", 0];
			_target setVariable ["err_audio_playing", false, true];
		},
		[],
		1,
		false,
		true,
		"",
		format["(_target getVariable ['err_audio_playing', false]) && (%1)", _condition],
		3
	];
};