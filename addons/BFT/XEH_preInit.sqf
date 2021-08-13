#include "script_component.hpp"
#include "XEH_PREP.hpp"

// Group markers 
[
	QGVAR(groupMarkers_enabled), // enabled?
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
	QGVAR(groupMarkers_updateDelay),
	"SLIDER",
	["Update delay", "Delay between group marker updates."], 
	"[TCA] BFT - Group markers",
	[1, 60, 5, 0]
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_nameOptions),
	"EDITBOX",
	["Group Name Options", "Names available in ACE BFT Settings, separated by comma."], 
	"[TCA] BFT - Group markers",
	["Zulu,Lima,Uniform,Echo,Whisky,Tango"]
] call CBA_fnc_addSetting; // maybe a server setting?

[
	QGVAR(groupMarkers_trackingMode),
	"LIST",
	["Tracking mode", "The way a group's position is calculated"], 
	["[TCA] BFT - Group markers", "Position"],
	[["Leader", "weightedAverage"], ["Leader", "Weighted average"],1]
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_trailingMode),
	"LIST",
	["Trailing mode", "Lets a group's position trail behind its actual position."], 
	["[TCA] BFT - Group markers", "Position"],
	[["none", "weightedAverage", "delayed"], ["None", "Weighted Average", "Delayed"], 1]
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_trailingCount),
	"SLIDER",
	["Trailing count", "Amount of recent positions considered."], 
	["[TCA] BFT - Group markers", "Position"],
	[1, 25, 5, 0]
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_trailingWeight),
	"SLIDER",
	["Trailing weight", "Factor with which the weight decreases with per position."], 
	["[TCA] BFT - Group markers", "Position"],
	[0, 1, 0.75, 2]
] call CBA_fnc_addSetting; 

// Player markers 
[
	QGVAR(unitMarkers_enabled), 
	"CHECKBOX",
	"Enable unit markers", 
	"[TCA] BFT - Unit markers",
	true // Default is true
] call CBA_fnc_addSetting; 

[
	QGVAR(unitMarkers_otherGroups),
	"CHECKBOX",
	"Mark other groups' units", 
	"[TCA] BFT - Unit markers",
	true, 
	0, 
	{
        params ["_value"];
		if (_value) then {
			// Enable markers
			[] call FUNC(unitMarkers_init);
		};
	}
] call CBA_fnc_addSetting; 

[
	QGVAR(unitMarkers_markAI),
	"CHECKBOX",
	"Mark AI Units", 
	"[TCA] BFT - Unit markers",
	true
] call CBA_fnc_addSetting; 

[
	QGVAR(unitMarkers_showToggle),
	"CHECKBOX",
	"Show unit marker toggle ", 
	"[TCA] BFT - Unit markers",
	false
] call CBA_fnc_addSetting; 
