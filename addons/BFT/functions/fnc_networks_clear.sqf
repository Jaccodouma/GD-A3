/*
This function exists to enable removing a group from all of the networks in which that this group is a full member of.

The group will no longer be a full member of any network,

Example Usage:

In a groups init field:
[_this, "network-name"] call tca_bft_fnc_clear_networks


*/
#include "script_component.hpp"
params ["_group"];


[(_group),"*"] call FUNC(networks_remove);