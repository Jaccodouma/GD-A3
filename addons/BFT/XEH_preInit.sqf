#include "script_component.hpp"
#include "XEH_PREP.hpp"

// Group markers 
[
	"BFT_groupMarkers_enable", // enabled?
	"CHECKBOX",
	"Enable group markers", 
	"[TCA] BFT - Group markers",
	true, 
	0, 
	{
        params ["_value"];
		if (_value) then {
			// Enable markers
			[] call FUNC(groupMarkers_init);
		};
	}
] call CBA_fnc_addSetting; 

[
	"BFT_groupMarkers_updateDelay",
	"SLIDER",
	["Update delay", "Delay between group marker updates."], 
	"[TCA] BFT - Group markers",
	[1, 60, 5, 0]
] call CBA_fnc_addSetting; 

[
	"BFT_groupMarkers_nameOptions",
	"EDITBOX",
	["Group Name Options", "Names available in ACE BFT Settings, separated by comma."], 
	"[TCA] BFT - Group markers",
	["Zulu,Lima,Uniform,Echo,Whisky,Tango"]
] call CBA_fnc_addSetting; // maybe a server setting?

[
	"BFT_groupMarkers_trackingMode",
	"LIST",
	["Tracking mode", "The way a group's position is calculated"], 
	["[TCA] BFT - Group markers", "Position"],
	[["Leader", "weightedAverage"], ["Leader", "Weighted average"],1]
] call CBA_fnc_addSetting; 

[
	"BFT_groupMarkers_trailing",
	"LIST",
	["Trailing mode", "Lets a group's position trail behind its actual position."], 
	["[TCA] BFT - Group markers", "Position"],
	[["none", "weightedAverage", "delayed"], ["None", "Weighted Average", "Delayed"], 1]
] call CBA_fnc_addSetting; 

[
	"BFT_groupMarkers_trailing_count",
	"SLIDER",
	["Trailing count", "Amount of recent positions considered."], 
	["[TCA] BFT - Group markers", "Position"],
	[1, 25, 5, 0]
] call CBA_fnc_addSetting; 

[
	"BFT_groupMarkers_trailing_weight",
	"SLIDER",
	["Trailing weight", "Factor with which the weight decreases with per position."], 
	["[TCA] BFT - Group markers", "Position"],
	[0, 1, 0.75, 2]
] call CBA_fnc_addSetting; 

// Player markers 
[
	"BFT_playerMarkers_enable", 
	"CHECKBOX",
	"Enable player markers", 
	"[TCA] BFT - Player markers",
	true // Default is true
] call CBA_fnc_addSetting; 

[
	"BFT_playerMarkers_otherGroups",
	"CHECKBOX",
	"Mark other groups", 
	"[TCA] BFT - Player markers",
	true, 
	0, 
	{
        params ["_value"];
		if (_value) then {
			// Enable markers
			[] call FUNC(playerMarkers_init);
		};
	}
] call CBA_fnc_addSetting; 

[
	"BFT_playerMarkers_AI",
	"CHECKBOX",
	"Mark AI", 
	"[TCA] BFT - Player markers",
	true
] call CBA_fnc_addSetting; 

[
	"BFT_playerMarkers_ShowToggle",
	"CHECKBOX",
	"Show unit marker toggle ", 
	"[TCA] BFT - Player markers",
	false
] call CBA_fnc_addSetting; 
