/*
This function exists to enable removing a group from a network.

The group will no longer be a member of that network,

Example Usage:

In a groups init field:
[_this, "network-name"] call remove_from_network


*/

params ["_unit",["_netName","*", [""]]];


_currentCodes = (group _unit) getVariable ["BFT_groupMarker_encryptCodes", []];
if(_netName == "*") then {
	// wildcard clear all
	_currentCodes = [];
	(group _unit) setVariable ["BFT_groupMarker_encryptCodes", _currentCodes, true];
} else {
	_index = _currentCodes find _netName;
	if(_index > -1) then {
		_currentCodes deleteAt _index;
	};
	(group _unit) setVariable ["BFT_groupMarker_encryptCodes", _currentCodes, true];
};

_currentCodes;