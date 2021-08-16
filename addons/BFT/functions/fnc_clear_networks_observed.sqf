/*
This function exists to enable removing the observable networks from a given group.

The group will no longer an observer member of any network,

Example Usage:

In a groups init field:
[_this, "network-name"] call tca_bft_fnc_remove_from_network


*/
#include "script_component.hpp"
params ["_group"];

if(typeName _group != "GROUP") exitWith {
	systemChat "add_to_network requires group as first parameter";
};

[(_group),"*"] call FUNC(fnc_remove_network_observer);