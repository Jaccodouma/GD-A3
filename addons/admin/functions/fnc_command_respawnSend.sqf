#include "script_component.hpp"

params ["_UID"]; 
_target = [_UID] call BIS_fnc_getUnitByUID;

systemChat format ["Respawning %1", name _target];

[] remoteExec [QFUNC(command_respawn), _target];