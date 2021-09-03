#include "script_component.hpp"

GVAR(ClearBuildingMarkerID) = 0;
GVAR(ClearBuildingMarkers) = [];

// Add "Mark building cleared" action 
_addMarker = {
	_marker = createMarker [
		format [
			"_USER_DEFINED  #%1/%2/%3", 
			getPlayerID player, 
			format ["%1_%2", getPlayerID player, GVAR(ClearBuildingMarkerID)],
			GVAR(ClearBuildingMarkers_Channel)
		], 
		player, 0, player
	];
	_marker setMarkerType "hd_dot";
	_marker setMarkerColor GVAR(ClearBuildingMarkers_Color);

	INC(GVAR(ClearBuildingMarkerID));
	GVAR(ClearBuildingMarkers) pushBack _marker; 
};

_action_mark = [
	QGVAR(Action_BuildingCleared), 
	"Mark building cleared", 
	[
		"a3\ui_f\data\map\markers\handdrawn\dot_ca.paa", 
		(getArray (configfile >> "CfgMarkerColors" >> GVAR(ClearBuildingMarkers_Color) >> "color")) call BIS_fnc_colorRGBtoHTML
	], 
	_addMarker, 
	{player == vehicle player && GVAR(ClearBuildingMarkers_Enabled)}
] call ace_interact_menu_fnc_createAction; 

[player, 1, ["ACE_SelfActions"], _action_mark] call ace_interact_menu_fnc_addActionToObject;

// Add "Remove all" action 
_removeAll = {
	{
		deleteMarker _x;
	} forEach GVAR(ClearBuildingMarkers);
	GVAR(ClearBuildingMarkers) = [];
};

_action_clear = [
	QGVAR(Action_RemoveBuildingCleared), 
	"Remove all", 
	[
		"a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_cancel_ca.paa", 
		(getArray (configfile >> "CfgMarkerColors" >> "ColorRed" >> "color")) call BIS_fnc_colorRGBtoHTML
	], 
	_removeAll, 
	{player == vehicle player && count GVAR(ClearBuildingMarkers) > 0}
] call ace_interact_menu_fnc_createAction; 

[player, 1, ["ACE_SelfActions", QGVAR(Action_BuildingCleared)], _action_clear] call ace_interact_menu_fnc_addActionToObject;