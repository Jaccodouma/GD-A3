#include "script_component.hpp"

// Largely looked copied this: 
// https://gist.github.com/dedmen/3fa5f648631dd14a4173edea7580045e

if (!isServer) exitWith {
	systemChat format ["%1 needs to be executed on the server.", QFUNC(command_zeus)];
}; 

params ["_UID"]; 
_target = [_UID] call BIS_fnc_getUnitByUID;

// Delete old zeus
// TODO: 

// Create new zeus 
systemChat "Creating Zeus..."; 

// Create group 
if (isNil QGVAR(CuratorGroup)) then {
	GVAR(CuratorGroup) = createGroup sideLogic; 
};

// Create curator object
_curObj = GVAR(CuratorGroup) createUnit ["ModuleCurator_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_curObj setVariable ["showNotification", false]; 

// Set vars etc
missionNameSpace setVariable [format ["%1_%2", QGVAR(curator), name _target], _curObj, true];
publicVariable QGVAR(CuratorGroup); 
unassignCurator _curObj; 

// Assign all things ? (For now just assume zeus enh)


// Finalize
_curObj setcuratorcoef["place", 0];
_curObj setcuratorcoef["delete", 0];

_target assignCurator _curObj;