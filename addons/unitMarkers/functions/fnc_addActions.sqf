#include "script_component.hpp"

// Add ACE options to map 
_action_unitMarkers_On = 
	[
		"BFT_unitMarkers_On", 
		"Enable unit marker", 
		getText(configfile >> "TCA_BFT_Interact_Icons" >> "on"), 
		{player setVariable ["BFT_playerMarker_visible", true, true]}, 
		{
			GVAR(unitMarkers_showToggle) && 
			visibleMap && 
			!(player getVariable ["BFT_playerMarker_visible", true])
		}
	] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action_unitMarkers_On] call ace_interact_menu_fnc_addActionToObject;

_action_unitMarkers_Off = ["BFT_unitMarkers_Off", "Disable unit marker", getText(configfile >> "TCA_BFT_Interact_Icons" >> "off"), {player setVariable ["BFT_playerMarker_visible", false, true]}, {GVAR(unitMarkers_showToggle) && visibleMap && player getVariable ["BFT_playerMarker_visible", true]}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action_unitMarkers_Off] call ace_interact_menu_fnc_addActionToObject;