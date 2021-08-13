#include "script_component.hpp"

params ["_group"]; 

// If it's not automatic just return the shape
if (GVAR(groupMarkers_markerShape) != "a") exitWith {GVAR(groupMarkers_markerShape)};

private _markerSide = "b"; 
if (side _group == opfor) then {_markerSide = "o"};
if (side _group == independent) then {_markerSide = "n"};

_markerSide