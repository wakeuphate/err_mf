err_utils_fnc_addActionWithConfirmation = {
	params ["_unit", "_title", "_code", "_condition", "_distance"];

	private _initialActionCode = {
		params ["_unit", "_caller", "_actionId", "_initialArgs"];
		_initialArgs params ["_unit", "_title", "_code", "_condition", "_distance"];

		// Add confirmation action.
		private _confirmActionId = _unit addAction ["<t color='#485946'>Confirm</t>", {
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