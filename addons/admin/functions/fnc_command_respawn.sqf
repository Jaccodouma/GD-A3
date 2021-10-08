#include "script_component.hpp"

// Add ticket
[player, 1, true] call BIS_fnc_respawnTickets;

player allowDamage false; 
[{
	player allowDamage true; 
}, [], 5] call CBA_fnc_waitAndExecute;