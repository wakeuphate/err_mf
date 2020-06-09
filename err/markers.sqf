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

	if (["Command", _id, false] call BIS_fnc_inString) exitWith { "ColorUNKNOWN" };
	if (["Alpha", _id, false] call BIS_fnc_inString) exitWith { "ColorEAST" };
	if (["Bravo", _id, false] call BIS_fnc_inString) exitWith { "ColorWEST" };
	if (["Charlie", _id, false] call BIS_fnc_inString) exitWith { "ColorGUER" };
	if (["Delta", _id, false] call BIS_fnc_inString) exitWith { "ColorCIV" };

"ColorBlack"
};

err_markers_fnc_getMarkerTypeFromId = {
	params ["_id"];

	if (["Command", _id, false] call BIS_fnc_inString) exitWith {"b_hq" };
	if (["Alpha", _id, false] call BIS_fnc_inString) exitWith {"b_inf" };
	if (["Bravo", _id, false] call BIS_fnc_inString) exitWith {"b_inf" };
	if (["Charlie", _id, false] call BIS_fnc_inString) exitWith {"b_inf" };
	if (["Delta", _id, false] call BIS_fnc_inString) exitWith {"b_inf" };

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

	// Combine into one word.
	_id = (_id splitString " ") joinString "";

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
	} else {
		_mkrName setMarkerPosLocal (position (leader _group));
	};
};

err_markers_fnc_playerInit = {
	waitUntil {
		{
			private _groupId = groupId _x;
			if (side _x == playerSide && _groupId != "" && alive (leader _x)) then {
				private _mkrDetails = [_groupId] call err_markers_fnc_getMarkerDetailsFromId;
				[_mkrDetails, _x] call err_markers_fnc_updateGroupMarker;
			};
		} forEach allGroups;

		sleep 1;

	false
	};
};