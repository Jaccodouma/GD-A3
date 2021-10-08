#include "script_component.hpp"
params ["_UID"]; 
_target = [_UID] call BIS_fnc_getUnitByUID;

systemChat format ["Opening arsenal for %1", name _target];

[player, _target, true] call ace_arsenal_fnc_openBox;