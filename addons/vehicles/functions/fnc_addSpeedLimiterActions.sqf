#include "script_component.hpp"

params ["_target", "_player"];

_speeds = [
	5.34, 	// Walk
	10.93, 	// Gun up
	12, 	// Gun down 
	14,		// Jog
	18.26,	// Sprint
	60, 
	80, 
	100
]; 

// Array with actions to add
_actions = [];

{
	_name = format ["%1", _x]; 
	_icon = "";
	_statement = {
		params ["_target", "_player", "_params"];
		[_params] call FUNC(waitAndLimitSpeed);
	};
	_params = _x; 

	private _action = [
		format ["TCA_SpeedLimiter_Action_%1", _x], 
		_name, 
		_icon, 
		_statement, 
		{true}, 
		{}, 
		_params
	] call ace_interact_menu_fnc_createAction; 
	_actions pushBack [_action, [], _target]; 
} forEach [60,80,100];

// Actions
_actions