#include "script_component.hpp"
#include "XEH_PREP.hpp"

[
	QGVAR(showSpeedLimiterOptions),
	"CHECKBOX",
	"Show speed limiter options", 
	["[TCA] Miscellaneous", "Vehicles"],
	true
] call CBA_fnc_addSetting; 

[
	QGVAR(showSpeedLimiterWaitTime),
	"Slider",
	"Speed limiter wait time", 
	["[TCA] Miscellaneous", "Vehicles"],
	[1,60,10,0]
] call CBA_fnc_addSetting; 