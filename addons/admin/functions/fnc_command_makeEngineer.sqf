#include "script_component.hpp"
params ["_UID"]; 
_target = [_UID] call BIS_fnc_getUnitByUID;

systemChat format ["Making %1 Engineer", name _target];

_target setVariable ["ace_isengineer", 1, true];

