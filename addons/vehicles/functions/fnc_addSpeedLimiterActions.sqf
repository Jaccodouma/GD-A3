#include "script_component.hpp"

params ["_target", "_player"];

_speeds = [
	[5.34, "Walk"], 	// Walk
	[10.93, "Gun up"], 	// Gun up
	[14, "Jog"],		// Jog
	[18.26, "Sprint"],	// Sprint
	[40, "Slow convoy"],
	[60, "Normal convoy"],
	[80, "Fast convoy"]
];

// Array with actions to add
_actions = [];

_disableSpeedLimiterAction = [
	"TCA_SpeedLimiter_Disable",
	"Disable",
	getText(configfile >> "TCA_BFT_Interact_Icons" >> "off"),
	{
		vehicle player setCruiseControl [0, false];
	},
	{
		(getCruiseControl vehicle player)#0 != 0; 
	}
] call ace_interact_menu_fnc_createAction;

_actions pushBack [_disableSpeedLimiterAction, [], _target];

{
	_speed = _x#0;

	// Continue if already set at this speed.
	if ((getCruiseControl vehicle player)#0 == _speed) then {continue;};

	_name = format ["%1 (%2)", _x#1, _x#0];
	_icon = "";
	_statement = {
		params ["_target", "_player", "_speed"];
		(vehicle player) setCruiseControl [_speed, false];
	};
	_params = _speed;

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
} forEach _speeds;

// Actions
_actions