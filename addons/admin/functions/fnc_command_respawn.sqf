#include "script_component.hpp"

// Add ticket
if ([player,0,true] call BIS_fnc_respawnTickets <= 0) then {
	[player, 1, true] call BIS_fnc_respawnTickets;

	player allowDamage false; 
	[{
		player allowDamage true; 
		hintSilent "Respawn invulnerability ended.";
	}, [], 5] call CBA_fnc_waitAndExecute;
}; 