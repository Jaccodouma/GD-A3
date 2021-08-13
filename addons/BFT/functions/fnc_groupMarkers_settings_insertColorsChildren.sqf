#include "script_component.hpp"
// Practically a copy of insertIconsChildren modified for colours

params ["_target", "_player", "_params"];

_params params [["_showPreferred", false, [true]]];

_actions = [];

{
	_isBlacklisted = _x in (GVAR(groupMarkers_colorsBlacklist) call EFUNC(main,stringToTrimmedArrayUpper));
	_isPreferred = _x in (GVAR(groupMarkers_preferredColors) call EFUNC(main,stringToTrimmedArrayUpper));

	if (_isBlacklisted) then {continue;};

	// Exit if we dont want to show current marker
	// _isPreferred XOR !_showPreferred (A3 doesn't have XOR)
	// https://community.bistudio.com/wiki/Operators#Logical_Operators 
	_xor = (_isPreferred||_showPreferred)&&!(_isPreferred&&_showPreferred);
	if (_xor) then {continue;};

	_color = _x; 
	_name = getText (configfile >> "CfgMarkerColors" >> _color >> "name"); 

	private _markerSide = "b"; 
	if (playerSide == opfor) then {_markerSide = "o"};
	if (playerSide == independent) then {_markerSide = "n"};
	_markerType = (group player) getVariable ["BFT_groupMarker_type", "inf"];

	_interactIcon = getText (configfile >> "CfgMarkers" >> _markerSide + "_" + _markerType >> "icon"); 

	_iconColour = (getArray (configfile >> "CfgMarkerColors" >> _color >> "color")) call BIS_fnc_colorConfigToRGBA call BIS_fnc_colorRGBtoHTML; 

	_statement = {
		params ["_target", "_player", "_params"];
		(group player) setVariable ["BFT_groupMarker_color", _params, true];
	};

	_actions pushBack [
		[
			("Jacco_BFT_Colors_"+_name), 
			_name, 
			[_interactIcon, _iconColour], 
			_statement, 
			{true}, 
			{}, 
			_color
		] call ace_interact_menu_fnc_createAction,
		[], 
		_target
	];
} forEach GVAR(availableMarkerColors);

_actions