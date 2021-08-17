#include "script_component.hpp"

params ["_vehicle"];

_color = [0,0,0];
{
	if !(_x in units group player) then {continue}; 

	_teamColor = + (_x getVariable "diwako_dui_main_compass_color"); 

	// Set color first time
	if (_color isEqualTo [0,0,0]) then {
		_color = + _teamColor; 
		continue; 
	};

	// Set color to white if the new color is different
	if !(_color isEqualTo _teamColor) then {
		_color = [1,1,1];
		break;
	}
} forEach (crew _vehicle);

if (_color isEqualTo [0,0,0]) then {
	_color = [playerSide, false] call BIS_fnc_sideColor;
};

_color; 