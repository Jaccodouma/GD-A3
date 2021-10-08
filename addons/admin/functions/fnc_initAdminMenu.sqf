#include "script_component.hpp"

addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];


	if (_mapIsOpened) then {
		if (IS_ADMIN_LOGGED || isServer) then {
			// Update admin menu 
			[] call FUNC(updateAdminMenu); 
		} else {
			// Remove admin menu
			[] call FUNC(removeAdminMenu); 
		};
	};
}];