/*
This function exists to enable adding a group to a network.

The group will be an observor member of that network, meaning:
- Transimission of their position to the network: No
- Reception of positions of other groups in the network: Yes

To include transmission, use add_to_net

Example Usage:

In a groups init field:
[_this, "network-name"] call add_to_network


*/

params ["_unit","_netName"];


_currentCodes = (group _unit) getVariable ["BFT_groupMarker_decryptCodes", []];
_currentCodes pushBackUnique _netName;
_currentCodes = (group _unit) setVariable ["BFT_groupMarker_decryptCodes", _currentCodes, true];

_netName;
