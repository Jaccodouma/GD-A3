
#include "script_component.hpp"

params ["_target", "_player", "_params"];

private _actions = []; 
{
	_statement = {
		params ["_target", "_player", "_params"];
		(group player) setGroupIdGlobal [_params];
	};

	_icon = getText(configfile >> "TCA_BFT_Interact_Icons" >> "letter" >> toUpper _x select [0,1]);
	
	// Get icon colour in CfgMarkerColors, convert to RGB array, then convert to HTML string
	_iconColour = group player getVariable ["BFT_groupMarker_color", [playerSide, true] call BIS_fnc_sideColor];
	_iconColour = (getArray (configfile >> "CfgMarkerColors" >> _iconColour >> "color")) call BIS_fnc_colorConfigToRGBA;
	_iconColour = _iconColour call BIS_fnc_colorRGBtoHTML;

	_action = [
		format ["Jacco_BFT_Names_%1", _x],
		_x, 
		[_icon, _iconColour], 
		_statement, 
		{true}, 
		{}, 
		_x
	] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _target];
} forEach ([GVAR(groupMarkers_nameOptions)] call EFUNC(main,stringToTrimmedArray));

// Return created actions
_actions