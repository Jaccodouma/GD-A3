#include "script_component.hpp"

// Add settings to ACE interact menu 
// [] execVM "BFT\groups\BFT_fnc_addGroupSettings.sqf";

// Global variable for all group markers 
BFT_GroupMarkers = [];

// Set enabled variable for player group if not set yet 
if ((group player getVariable ["BFT_groupMarker_visible", objNull]) isEqualTo objNull) then {
	group player setVariable ["BFT_groupMarker_visible", true, true];
};

fnc_loop = {
	// Remove old markers
	[] call FUNC(groupMarkers_remove);

	// Leave loop after removing markers
	if !(BFT_groupMarkers_enable) exitWith {};

	// Create new markers 
	[] call FUNC(groupMarkers_draw);

	private _sleepTime = BFT_groupMarkers_updateDelay;
	if (isMultiplayer) then {
		_sleepTime = round BFT_groupMarkers_updateDelay - (serverTime % round BFT_groupMarkers_updateDelay);
	};

	[fnc_loop, [], _sleepTime] call CBA_fnc_waitAndExecute;
};

[] call fnc_loop;

// Add settings to map 
[] call FUNC(groupMarkers_addSettings);