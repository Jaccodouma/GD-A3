#include "script_component.hpp"
params ["_speed"];

GVAR(waitAndLimitSpeed_startTime) = time; 

if ((speed player) < _speed) exitWith {
	[_speed] call FUNC(limitSpeed);
};

["Slow down to desired speed."] call ace_common_fnc_displayTextStructured;

_eh = [
	{
		params ["_speed", "_eh"];

		// Exit if out of time 
		if (time > (GVAR(waitAndLimitSpeed_startTime) + GVAR(showSpeedLimiterWaitTime))) exitWith {
			["Took too long to decelerate."] call ace_common_fnc_displayTextStructured; 
			[_eh] call CBA_fnc_removePerFrameHandler;
		};

		// Exit if not in vehicle or driver anymore
		if ((isNull objectParent player) || (player != driver vehicle player)) exitWith {
			[_eh] call CBA_fnc_removePerFrameHandler;
		};

		// Limit speed 
		if ((speed player) < _speed) then {
			[_speed] call FUNC(limitSpeed);
			[_eh] call CBA_fnc_removePerFrameHandler;
		};
	}, 
	0.1,
	_speed
] call CBA_fnc_addPerFrameHandler; 