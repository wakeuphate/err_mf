err_markers_fnc_stringReplace = {
	// Author: Colin J.D. Stewart
    params ["_str", "_find", "_replace"];
    
    if (!(_find isEqualType [])) then {
        _find = [_find];
    };
    
    {
        private _return = "";
        private _len = count _x;        
        private _pos = _str find _x;
        
        while {(_pos != -1) && (count _str > 0)} do {
            _return = _return + (_str select [0, _pos]) + _replace;
            
            _str = (_str select [_pos+_len]);
            _pos = _str find _x;
        };    
        _str = _return + _str;
    } forEach _find;
    
_str
};

err_markers_fnc_getMarkerColorFromId = {
	params ["_id"];

	if (["Command", _id, false] call BIS_fnc_inString) exitWith { "ColorBlack" };
	if (["Alpha", _id, false] call BIS_fnc_inString) exitWith { "ColorEAST" };
	if (["Bravo", _id, false] call BIS_fnc_inString) exitWith { "ColorWEST" };
	if (["Charlie", _id, false] call BIS_fnc_inString) exitWith { "ColorGUER" };
	if (["Delta", _id, false] call BIS_fnc_inString) exitWith { "ColorUNKNOWN" };

	if (["Special Ops", _id, false] call BIS_fnc_inString) exitWith { "ColorOrange" };
	if (["Quillon", _id, false] call BIS_fnc_inString) exitWith { "ColorOrange" };

"ColorYellow"
};

err_markers_fnc_getMarkerTypeFromId = {
	params ["_id"];

	if (["Command", _id, false] call BIS_fnc_inString) exitWith { "b_hq" };
	if (["Alpha", _id, false] call BIS_fnc_inString) exitWith { "b_inf" };
	if (["Bravo", _id, false] call BIS_fnc_inString) exitWith { "b_inf" };
	if (["Charlie", _id, false] call BIS_fnc_inString) exitWith { "b_inf" };
	if (["Delta", _id, false] call BIS_fnc_inString) exitWith { "b_inf" };

	if (["Special Ops", _id, false] call BIS_fnc_inString) exitWith { "b_recon" };
	if (["Quillon", _id, false] call BIS_fnc_inString) exitWith { "b_recon" };

	if (["Air", _id, false] call BIS_fnc_inString) exitWith { "b_air" };
	if (["TH", _id, false] call BIS_fnc_inString) exitWith { "b_air" };
	if (["AH", _id, false] call BIS_fnc_inString) exitWith { "b_air" };
	if (["Valkyrie", _id, false] call BIS_fnc_inString) exitWith  {"b_air" };

	if (["IFV", _id, false] call BIS_fnc_inString) exitWith { "b_mech_inf" };
	if (["Fenrir", _id, false] call BIS_fnc_inString) exitWith { "b_mech_inf" };

	if (["Tank", _id, false] call BIS_fnc_inString) exitWith { "b_armor" };
	if (["Thor", _id, false] call BIS_fnc_inString) exitWith { "b_armor" };

"b_unknown"
};

err_markers_fnc_getMarkerDetailsFromId = {
	params ["_id"];

	private _mkrColor = [_id] call err_markers_fnc_getMarkerColorFromId;
	private _mkrType = [_id] call err_markers_fnc_getMarkerTypeFromId;

	// Replace all squad names with shortened versions.
	// Each short name must be unique.
	_id = [_id, "Command", "CO"] call err_markers_fnc_stringReplace;
	_id = [_id, "Alpha", "A"] call err_markers_fnc_stringReplace;
	_id = [_id, "Bravo", "B"] call err_markers_fnc_stringReplace;
	_id = [_id, "Charlie", "C"] call err_markers_fnc_stringReplace;
	_id = [_id, "Delta", "D"] call err_markers_fnc_stringReplace;

	_id = [_id, "Special Ops", "SPEC"] call err_markers_fnc_stringReplace;
	_id = [_id, "Quillon", "QUIL"] call err_markers_fnc_stringReplace;

	_id = [_id, "Valkyrie", "VALK"] call err_markers_fnc_stringReplace;

	_id = [_id, "Fenrir", "FEN"] call err_markers_fnc_stringReplace;

	_id = [_id, "Mortars", "MORT"] call err_markers_fnc_stringReplace;
	_id = [_id, "Mortar", "MORT"] call err_markers_fnc_stringReplace;

	// Combine into one word.
	_id = toUpper ((_id splitString " ") joinString "");

[_id, _mkrColor, _mkrType]
};

err_markers_fnc_updateGroupMarker = {
	params ["_mkrDetails", "_group"];
	_mkrDetails params ["_mkrText", "_mkrColor", "_mkrType"];

	private _mkrName = format["err_markers_group_%1_%2", faction (leader _group), _mkrText];
	if (getMarkerColor _mkrName == "") then {
		createMarkerLocal [_mkrName, position (leader _group)];
		_mkrName setMarkerTextLocal _mkrText;
		_mkrName setMarkerColorLocal _mkrColor;
		_mkrName setMarkerTypeLocal _mkrType;
		err_markers_list pushBackUnique _mkrName;
	} else {
		_mkrName setMarkerPosLocal (position (leader _group));
	};

_mkrName
};

err_markers_fnc_playerInit = {
	err_markers_list = [];

	waitUntil {
		private _updatedMarkers = [];
		{
			private _groupId = groupId _x;
			private _sameSide = side _x == playerSide;
			private _groupAlive = _groupId != "" && alive (leader _x);
			private _playerGroup = isPlayer(leader _x);

			// Only show markers for alive player groups on same side as the current player.
			if (_sameSide && {_groupAlive} && {_playerGroup}) then {
				private _mkrDetails = [_groupId] call err_markers_fnc_getMarkerDetailsFromId;
				private _mkrName = [_mkrDetails, _x] call err_markers_fnc_updateGroupMarker;
				_updatedMarkers pushBackUnique _mkrName;
			};
		} forEach allGroups;

		// Gradually hide any markers that are no longer being updated.
		private _deadMarkers = err_markers_list - _updatedMarkers;
		{
			// Gradually reduce marker alpha for dead / deleted groups.
			_x setMarkerAlphaLocal ((markerAlpha _x) - 0.01);

			// Delete markers when they get too faint to see.
			if (markerAlpha _x < 0.1) then {
				err_markers_list = err_markers_list - [_x];
				deleteMarkerLocal _x;
			};
		} forEach _deadMarkers;

		sleep 1.5;

	// Exit from the loop when markers are disabled via a global var.
	!isNil "err_markers_disabled"
	};

	// If the above loop ever ends, markers have been disabled, and we should remove any remaining ones.
	{
		deleteMarkerLocal _x;
	} forEach err_markers_list;
};