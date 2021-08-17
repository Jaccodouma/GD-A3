#include "script_component.hpp"
#include "XEH_PREP.hpp"

GVAR(availableMarkerIcons) = [
	"inf",
	"motor_inf",
	"mech_inf",
	"air",
	"armor",
	"recon",
	"antiair",
	"art",
	"hq",
	"installation",
	"maint",
	"med",
	"mortar",
	"naval",
	"ordnance",
	"plane",
	"service",
	"support",
	"uav",
	"unknown"
];

GVAR(availableMarkerColors) = [ 
  "true" configClasses (configfile >> "CfgMarkerColors"),  
  {toUpper configName _x} 
] call CBA_fnc_filter;

[
	QGVAR(groupMarkers_enabled),
	"CHECKBOX",
	"Enable group markers", 
	"[TCA] BFT",
	true, 
	0, 
	{
        params ["_value"];
		if (_value) then {
			// Enable markers
			[] call FUNC(init);
		};
	}
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_updateDelay),
	"SLIDER",
	["Update delay", "Delay between group marker updates."], 
	"[TCA] BFT",
	[1, 60, 5, 0]
] call CBA_fnc_addSetting; 

// Position
[
	QGVAR(groupMarkers_markerShape),
	"LIST",
	["Marker shape", "Warning! Taking this off automatic will also affect enemy groups."], 
	"[TCA] BFT",
	[["a", "b", "o", "n"], ["Automatic", "Blufor", "Opfor", "Independent"],0]
] call CBA_fnc_addSetting; 

// Position
[
	QGVAR(groupMarkers_trackingMode),
	"LIST",
	["Tracking mode", "The way a group's position is calculated"], 
	["[TCA] BFT", "Position"],
	[["Leader", "weightedAverage"], ["Leader", "Weighted average"],1]
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_trailingMode),
	"LIST",
	["Trailing mode", "Lets a group's position trail behind its actual position."], 
	["[TCA] BFT", "Position"],
	[["none", "weightedAverage", "delayed"], ["None", "Weighted Average", "Delayed"], 1]
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_trailingCount),
	"SLIDER",
	["Trailing count", "Amount of recent positions considered."], 
	["[TCA] BFT", "Position"],
	[1, 25, 5, 0]
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_trailingWeight),
	"SLIDER",
	["Trailing weight", "Factor with which the weight decreases with per position."], 
	["[TCA] BFT", "Position"],
	[0, 1, 0.75, 2]
] call CBA_fnc_addSetting; 


// Map settings
[
	QGVAR(groupMarkers_mapSettings_enabled),
	"CHECKBOX",
	["Enable map settings menu", "Allows group leaders to change their stuff using ace self interact on the map."],
	["[TCA] BFT", "Map settings"],
	true
] call CBA_fnc_addSetting; 

[
	QGVAR(groupMarkers_nameOptions),
	"EDITBOX",
	["Group Name Options", "Names available in ACE BFT Settings, separated by comma."],
	["[TCA] BFT", "Map settings"],
	["Zulu,Lima,Uniform,Echo,Whiskey,Tango"]
] call CBA_fnc_addSetting;

[
	QGVAR(groupMarkers_preferredIcons),
	"EDITBOX",
	"Preferred icons",
	["[TCA] BFT", "Map settings"],
	["inf, motor_inf, mech_inf, air, armor, recon"]
] call CBA_fnc_addSetting;

[
	QGVAR(groupMarkers_iconsBlacklist),
	"EDITBOX",
	"Icons blacklist",
	["[TCA] BFT", "Map settings"],
	["unknown, uav"]
] call CBA_fnc_addSetting;

[
	QGVAR(groupMarkers_preferredColors),
	"EDITBOX",
	"Preferred colors",
	["[TCA] BFT", "Map settings"],
	["ColorBLUFOR, ColorOPFOR, ColorIndependent, ColorCivilian, ColorUNKNOWN"]
] call CBA_fnc_addSetting;

[
	QGVAR(groupMarkers_colorsBlacklist),
	"EDITBOX",
	"Colors blacklist",
	["[TCA] BFT", "Map settings"],
	["Default, ColorWEST, ColorEAST, ColorGUER, ColorCIV, Color1_FD_F, Color2_FD_F, Color3_FD_F, Color4_FD_F, Color5_FD_F, Color6_FD_F"]
] call CBA_fnc_addSetting;

[
	QGVAR(groupMarkers_fuzzOtherFactions),
	"CHECKBOX",
	["Enable obfuscation of other faction groups", "Groups of other sides/factions will show as default names/colours"],
	["[TCA] BFT", "Crypto settings"],
	true
] call CBA_fnc_addSetting; 
