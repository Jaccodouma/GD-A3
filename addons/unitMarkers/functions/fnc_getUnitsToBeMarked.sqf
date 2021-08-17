#include "script_component.hpp"
_units = []; 

// Return empty if turned off  
if !(GVAR(unitMarkers_enabled)) exitWith {[]};

if (GVAR(unitMarkers_otherGroups)) then {
	// Mark other groups
	{
		if (side group _x != side player) then {continue;};
		if ((isPlayer _x || GVAR(unitMarkers_markAI)) && _x getVariable ["BFT_playerMarker_visible", true]) then {
			_units pushBack _x; 
		};
	} forEach allUnits;
} else {
	// Only mark own group
	{
		if ((isPlayer _x || GVAR(unitMarkers_markAI)) && _x getVariable ["BFT_playerMarker_visible", true]) then {
			_units pushBack _x; 
		};
	} forEach units group player;
};

_units