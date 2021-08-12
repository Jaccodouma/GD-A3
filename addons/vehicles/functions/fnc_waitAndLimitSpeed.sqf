#include "script_component.hpp"
params ["_speed"];

tca_vehicles_limitSpeed_waitTime = 10; 
GVAR(waitAndLimitSpeed_startTime) = time; 

if ((speed player) < _speed) exitWith {
	[_speed] call FUNC(limitSpeed);
};

["Slow down to desired speed."] call ace_common_fnc_displayTextStructured;

_eh = [
	{
		params ["_speed", "_eh"];

		// Exit conditions 
		if (
			isNull objectParent player // Player not in vehicle
		 || time > (GVAR(waitAndLimitSpeed_startTime) + tca_vehicles_limitSpeed_waitTime)
		) then {
			// Remove event handler
			["Speed limiter deactivated."] call ace_common_fnc_displayTextStructured; 
			[_eh] call CBA_fnc_removePerFrameHandler;
		} else {
			// Limit speed 
			if ((speed player) < _speed) then {
				[_speed] call FUNC(limitSpeed);
				[_eh] call CBA_fnc_removePerFrameHandler;
			};
		};
	}, 
	0.1,
	_speed
] call CBA_fnc_addPerFrameHandler; 