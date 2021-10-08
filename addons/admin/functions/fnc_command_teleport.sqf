#include "script_component.hpp"

params ["_UID"]; 
_target = [_UID] call BIS_fnc_getUnitByUID;

systemChat format ["Teleporting %1", name _target];

hintSilent format ["Click on the map to teleport %1", name _target];

GVAR(ADMIN_TP_TARGET) = _target;

GVAR(ADMIN_TP_EH_CLICK) = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];

	GVAR(ADMIN_TP_TARGET) setPos _pos; 
	GVAR(ADMIN_TP_TARGET) = objNull;

	// Remove event handlers
	removeMissionEventHandler ["MapSingleClick", GVAR(ADMIN_TP_EH_CLICK)];
	removeMissionEventHandler ["MapSingleClick", GVAR(ADMIN_TP_EH_MAP)];
}];

GVAR(ADMIN_TP_EH_MAP) = addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];

	// Remove event handlers
	removeMissionEventHandler ["MapSingleClick", GVAR(ADMIN_TP_EH_CLICK)];
	removeMissionEventHandler ["MapSingleClick", GVAR(ADMIN_TP_EH_MAP)];
}];