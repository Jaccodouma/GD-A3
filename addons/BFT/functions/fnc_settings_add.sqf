/*
	Author: Jacco Douma 

	Description: 
	Adds BFT settings to ACE interaction menu. 

	Parameter(s): 
		None

	Returns: 
	nothing

	TODO: 
	 - Also add BFT to map interactions
	 - Cusom name
	 - Update own marker whenever you change a setting
*/
#include "script_component.hpp"

// Only add once
if (GVAR(Settings_Set)) exitWith {};
GVAR(Settings_Set) = true; 

// Add options to ACE menu
_action_BFT = ["Jacco_BFT", "BFT", "", {true}, {leader group player == player && visibleMap}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action_BFT] call ace_interact_menu_fnc_addActionToObject;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Colors 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
action_BFT_Colors = [
	"Jacco_BFT_Colors", 
	"Color", 
	getText(configfile >> "TCA_BFT_Interact_Icons" >> "colorWheel"), 
	{true}, 
	{true}, // Condition
	FUNC(settings_insertColorsChildren), 
	[true] // Params to pass to insertChildren
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions", "Jacco_BFT"], action_BFT_Colors] call ace_interact_menu_fnc_addActionToObject;

// Add other colors
_action_BFT_Colors_Other = [
	"Jacco_BFT_Colors_Other", 
	"Other colors", 
	getText(configfile >> "TCA_BFT_Interact_Icons" >> "plus"), 
	{true}, 
	{true}, // Condition
	FUNC(settings_insertColorsChildren)
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions", "Jacco_BFT", "Jacco_BFT_Colors"], _action_BFT_Colors_Other] call ace_interact_menu_fnc_addActionToObject;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Team name
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_action_BFT_Name = [
	"Jacco_BFT_Name", "Name", 
	getText(configfile >> "TCA_BFT_Interact_Icons" >> "pen"), 
	{true},
	{true}, 
	FUNC(settings_insertNameChildren)
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions", "Jacco_BFT"], _action_BFT_Name] call ace_interact_menu_fnc_addActionToObject;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Team icon 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_action_BFT_Icon = [
	"Jacco_BFT_Icons", "Icon", 
	getText(configfile >> "TCA_BFT_Interact_Icons" >> "BFT"),
	{true}, // Statement (breaks if not true for some reason)
	{true}, // Condition
	FUNC(settings_insertIconsChildren), 
	[true] // Params to pass to insertChildren
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions", "Jacco_BFT"], _action_BFT_Icon] call ace_interact_menu_fnc_addActionToObject;


_action_BFT_Icons_Other = [
	"Jacco_BFT_Icons_Other", "Other icons", 
	getText(configfile >> "TCA_BFT_Interact_Icons" >> "plus"), 
	{true}, // Statement (breaks if not true for some reason)
	{true}, // Condition
	FUNC(settings_insertIconsChildren)
] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Jacco_BFT", "Jacco_BFT_Icons"], _action_BFT_Icons_Other] call ace_interact_menu_fnc_addActionToObject;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Enable/Disable team tracker
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_action_BFT_Enable = ["Jacco_BFT_Enable", "Enable tracker", getText(configfile >> "TCA_BFT_Interact_Icons" >> "on"), {(group player) setVariable ["BFT_groupMarker_visible", true, true]}, {!((group player) getVariable ["BFT_groupMarker_visible", false]);}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Jacco_BFT"], _action_BFT_Enable] call ace_interact_menu_fnc_addActionToObject;

_action_BFT_Disable = ["Jacco_BFT_Disable", "Disable tracker", getText(configfile >> "TCA_BFT_Interact_Icons" >> "off"), {(group player) setVariable ["BFT_groupMarker_visible", false, true]}, {((group player) getVariable ["BFT_groupMarker_visible", false]);}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "Jacco_BFT"], _action_BFT_Disable] call ace_interact_menu_fnc_addActionToObject;