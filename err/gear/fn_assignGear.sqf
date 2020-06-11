params ["_unit", "_faction", "_type"];

if (!local _unit) exitWith {};

err_gear_fnc_clearContainer = {
	params ["_unit", "_container"];

	private _items = call compile format["%1Items _unit;", _container];

	{
		call compile format["_unit removeItemFrom%1 _x;", _container];
	} forEach _items;
};

err_gear_fnc_getMagazineWeight = {
	params ["_className"];
	
(configfile >> "CfgMagazines" >> _className >> 'mass') call BIS_fnc_getCfgData
};

err_gear_fnc_selectRandomFromConfig = {
	params ["_config"];
	
selectRandom (_config call BIS_fnc_getCfgData)
};

err_gear_fnc_addItemsTo = {
	params ["_unit", "_maxLoad", "_list", "_container"];

	{
		_x params ["_magazine", "_amount"];
		
		private _numberOfItems = 0;
		if (typeName _amount == "STRING" && {_amount find "%" > -1}) then {
			private _percentage = parseNumber ((_amount splitString "%") select 0);
			_numberOfItems = floor ((_percentage / 100) * (_maxLoad / ([_magazine] call err_gear_fnc_getMagazineWeight)));
		} else {
			_numberOfItems = _amount;
		};

		for "_i" from 1 to _numberOfItems do {
			// Hacky bullshit because there's no addItem command with a param for container.
			call compile format["_unit addItemTo%1 _magazine", _container];
		};
	} forEach _list;
};

private _gearConfig = missionConfigFile >> "Gear" >> _faction >> _type;

// Remove any existing gear.
_unit setUnitLoadout [[],[],[],[],[],[],"","",[],["","","","","",""]];

// NVGs

private _nvgs = (_gearConfig >> 'nvg') call BIS_fnc_getCfgData;
if (_nvgs != "") then {
	_unit addWeapon _nvgs;
};

// RADIO

private _radio = [(_gearConfig >> 'radio')] call BIS_fnc_getCfgData;
private _tfrRadioClass = [side _unit, _radio] call TFAR_fnc_getSideRadio;

_unit linkItem _tfrRadioClass;

// WEAPONS

private _primaryWeapon = (_gearConfig >> "primaryWeapon") call BIS_fnc_getCfgData;
private _primaryWeaponItems = (_gearConfig >> "primaryWeaponItems") call BIS_fnc_getCfgData;

private _secondaryWeapon = (_gearConfig >> "secondaryWeapon") call BIS_fnc_getCfgData;
private _secondaryWeaponItems = (_gearConfig >> "secondaryWeaponItems") call BIS_fnc_getCfgData;

private _handgun = (_gearConfig >> "handgun") call BIS_fnc_getCfgData;
private _handgunItems = (_gearConfig >> "handgunItems") call BIS_fnc_getCfgData;

if (_primaryWeapon != "") then {
	_unit addWeapon _primaryWeapon;
	{ _unit addPrimaryWeaponItem _x } forEach _primaryWeaponItems;
};

if (_secondaryWeapon != "") then {
	_unit addWeapon _secondaryWeapon;
	{ _unit addSecondaryWeaponItem _x } forEach _secondaryWeaponItems;
};

if (_handgun != "") then {
	_unit addWeapon _handgun;
	{ _unit addHandgunItem _x } forEach _handgunItems;
};

// BINOCULARS

private _binoculars = (_gearConfig >> "binoculars") call BIS_fnc_getCfgData;
if (_binoculars != "") then {
	_unit addWeapon _binoculars;
};

// ITEMS

private _items = [(_gearConfig >> 'items')] call BIS_fnc_getCfgData;

{
	_unit linkItem _x;
} forEach _items;

// HEAD / FACEGEAR

private _facewear = [(_gearConfig >> "facewear")] call err_gear_fnc_selectRandomFromConfig;
_unit addGoggles _facewear;

private _headgear = [(_gearConfig >> "headgear")] call err_gear_fnc_selectRandomFromConfig;
_unit addHeadgear _headgear;

// UNIFORM

private _uniform = [(_gearConfig >> "uniforms")] call err_gear_fnc_selectRandomFromConfig;
_unit forceAddUniform _uniform;
[_unit, "Uniform"] call err_gear_fnc_clearContainer;

// Earplugs
_unit addItem "ACE_EarPlugs";

private _maxUniformLoad = getContainerMaxLoad _uniform;

private _uniformItems = (_gearConfig >> "uniformItems") call BIS_fnc_getCfgData;

[_unit, _maxUniformLoad, _uniformItems, "Uniform"] call err_gear_fnc_addItemsTo;

// VEST

private _vest = [(_gearConfig >> "vests")] call err_gear_fnc_selectRandomFromConfig;
_unit addVest _vest;
[_unit, "Vest"] call err_gear_fnc_clearContainer;

private _maxVestLoad = getContainerMaxLoad _vest;

private _vestItems = (_gearConfig >> "vestItems") call BIS_fnc_getCfgData;

[_unit, _maxVestLoad, _vestItems, "Vest"] call err_gear_fnc_addItemsTo;

// BACKPACK

private _backpack = [(_gearConfig >> "backpacks")] call err_gear_fnc_selectRandomFromConfig;
_unit addBackpack _backpack;
[_unit, "Backpack"] call err_gear_fnc_clearContainer;

private _maxBackpackLoad = getContainerMaxLoad _backpack;

private _backpackItems = (_gearConfig >> "backpackItems") call BIS_fnc_getCfgData;

[_unit, _maxBackpackLoad, _backpackItems, "Backpack"] call err_gear_fnc_addItemsTo;
