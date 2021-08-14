#include "script_component.hpp"

// Add settings to ACE interact menu 
// [] execVM "BFT\groups\BFT_fnc_addGroupSettings.sqf";

// Global variable for all group markers 
BFT_GroupMarkers = [];

// Set enabled variable for player group if not set yet 
if ((group player getVariable ["BFT_groupMarker_visible", objNull]) isEqualTo objNull) then {
	group player setVariable ["BFT_groupMarker_visible", true, true];
};

// Encryption codes are used to 'encrypt' the group markers signal.
if ((group player getVariable ["BFT_groupMarker_encryptCodes", objNull]) isEqualTo objNull) then {
	group player setVariable ["BFT_groupMarker_encryptCodes", [str side group player], true];
};
// Decryption codes are used to 'decrypt' the group markers signal. 
// To see a specific group marker, a group must have a decryption code which matches at least one of the specific groups encryption codes
if ((group player getVariable ["BFT_groupMarker_decryptCodes", objNull]) isEqualTo objNull) then {
	group player setVariable ["BFT_groupMarker_decryptCodes", [], true];
};

fnc_loop = {
	// Remove old markers
	[] call FUNC(groupMarkers_remove);

	// Leave loop after removing markers
	if !(GVAR(groupMarkers_enabled)) exitWith {};

	// Create new markers 
	[] call FUNC(groupMarkers_draw);

	private _sleepTime = GVAR(groupMarkers_updateDelay);
	if (isMultiplayer) then {
		_sleepTime = round GVAR(groupMarkers_updateDelay) - (serverTime % round GVAR(groupMarkers_updateDelay));
	};

	[fnc_loop, [], _sleepTime] call CBA_fnc_waitAndExecute;
};

[] call fnc_loop;

// Add settings to map 
[] call FUNC(groupMarkers_addSettings);