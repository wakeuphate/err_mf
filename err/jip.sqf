err_jip_fnc_getClosestPlayer = {
	params ["_unit"];

	private _closestDistance = 999999;
	private _closestPlayer = objNull;
	{
		private _distanceToPlayer = _unit distance _x;
		if (_distanceToPlayer < _closestDistance) then {
			_closestDistance = _distanceToPlayer;
			_closestPlayer = _x;
		};
	} forEach (playableUnits - [_unit]);

[_closestDistance, _closestPlayer]
};

err_jip_fnc_playerInit = {
	// Ignore all non-JIP players.
	if (!didJip) exitWith {};

	// Get the closest friendly player.
	private _closest = [player] call err_jip_fnc_getClosestPlayer;
	_closest params ["_closestDistance", "_closestPlayer"];

	// Otherwise, give the JIP some warnings.
	hintSilent composeText [
		parseText "<t font='RobotoCondensed' align='center'>You have <t color='#F2E205'>JIP'd</t>.</t>",
		lineBreak,
		lineBreak,
		parseText format["<t font='RobotoCondensed' valign='bottom'>Your nearest friendly player (<t color='#F2E205'>%1</t>) is <t color='#F2E205'>%2m</t> away. If this is more than 500m, please use the scroll-menu option to enter spectator mode.</t>", name _closestPlayer, round(_closestDistance)]
	];

	// Then, add a spectator addAction.
	private _spectatorAction = [
		player,
		"<t color='#F2E205'>JIP: Spectator Mode</t>",
		{
			params ["_target", "_caller", "_actionId"];

			_target removeAction _actionId;
			_target setDamage 1;
		},
		"_target == _this",
		1
	] call err_utils_fnc_addActionWithConfirmation;

	// Remove the spectator action after 2 minutes.
	_spectatorAction spawn {
		sleep 120;
		player removeAction _this;
	};
};