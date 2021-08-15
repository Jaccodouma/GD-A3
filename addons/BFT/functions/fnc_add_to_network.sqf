/*
This function exists to enable adding a group to a network.

The group will be a full member of that network, meaning:
- Transimission of their position to the network: Yes
- Reception of positions of other groups in the network: Yes

To avoid transmission, use add_network_observor

Example Usage:

In a groups init field:
[_this, "network-name"] call add_to_network


*/
#include "script_component.hpp"

params ["_unit","_netName"];


_currentCodes = (group _unit) getVariable ["BFT_groupMarker_encryptCodes", []];
_currentCodes pushBackUnique _netName;
_currentCodes = (group _unit) setVariable ["BFT_groupMarker_encryptCodes", _currentCodes, true];

_netName;
