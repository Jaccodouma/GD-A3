/*
This function exists to enable removing a group from all of its networks.

The group will no longer be a member of that network,

Example Usage:

In a groups init field:
[_this, "network-name"] call remove_from_network


*/

params ["_unit"];


[(group _unit),"*"] call fnc_remove_network_observer;