/*
This function exists to enable removing an observer from a network.

The group will no longer be a member of that network,

Example Usage:

In a groups init field:
[_this, "network-name"] call tca_bft_fnc_remove_from_network


*/
#include "script_component.hpp"
params ["_group",["_netName","*", [""]]];

if(typeName _group != "GROUP") exitWith {
	systemChat "add_to_network requires group as first parameter";
};

_currentCodes = (_group) getVariable ["BFT_groupMarker_decryptCodes", []];
if(_netName == "*") then {
	// wildcard clear all
	_currentCodes = [];
	(_group) setVariable ["BFT_groupMarker_decryptCodes", _currentCodes, true];
} else {
	_index = _currentCodes find _netName;
	if(_index > -1) then {
		_currentCodes deleteAt _index;
	};
	(_group) setVariable ["BFT_groupMarker_decryptCodes", _currentCodes, true];
};

_currentCodes;