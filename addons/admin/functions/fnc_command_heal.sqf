#include "script_component.hpp"
params ["_UID"]; 
_target = [_UID] call BIS_fnc_getUnitByUID;

systemChat format ["Healing %1", name _target];

[_target] call ace_medical_treatment_fnc_fullHealLocal;