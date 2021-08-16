/*
This function exists to enable adding a group to a network.

The group will be an observor member of that network, meaning:
- Transimission of their position to the network: No
- Reception of positions of other groups in the network: Yes

To include transmission, use add_to_net

Example Usage:

In a groups init field:
[_this, "network-name"] call tca_bft_fnc_add_to_network


*/
#include "script_component.hpp"

params ["_group","_netName"];

if(typeName _group != "GROUP") exitWith {
	systemChat "add_network_observer requires group as first parameter";
};

_currentCodes = (_group) getVariable ["BFT_groupMarker_decryptCodes", []];
_currentCodes pushBackUnique _netName;
_currentCodes = (_group) setVariable ["BFT_groupMarker_decryptCodes", _currentCodes, true];

_netName;

