#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

[
	QGVAR(ClearBuildingMarkers_Enabled),
	"CHECKBOX",
	"Enable building clear markers", 
	["[TCA] Miscellaneous", "Building Clear Markers"],
	false, 
	0, 
	{}
] call CBA_fnc_addSetting; 

[
	QGVAR(ClearBuildingMarkers_Color),
	"LIST",
	"Marker colour", 
	["[TCA] Miscellaneous", "Building Clear Markers"],
	[
		["ColorBlack", "ColorGrey", "ColorRed", "ColorBrown", "ColorOrange", "ColorYellow", "ColorKhaki", "ColorGreen", "ColorBlue", "ColorPink", "ColorWhite"], 
		["Black", "Grey", "Red", "Brown", "Orange", "Yellow", "Khaki", "Green", "Blue", "Pink", "White"], 
		7
	], 
	0, 
	{}
] call CBA_fnc_addSetting; 

[
	QGVAR(ClearBuildingMarkers_Color),
	"LIST",
	["Marker colour", "Action colour only changes after mission restart!"], 
	["[TCA] Miscellaneous", "Building Clear Markers"],
	[
		["ColorBlack", "ColorGrey", "ColorRed", "ColorBrown", "ColorOrange", "ColorYellow", "ColorKhaki", "ColorGreen", "ColorBlue", "ColorPink", "ColorWhite"], 
		["Black", "Grey", "Red", "Brown", "Orange", "Yellow", "Khaki", "Green", "Blue", "Pink", "White"], 
		7
	], 
	0, 
	{}
] call CBA_fnc_addSetting; 

[
	QGVAR(ClearBuildingMarkers_Channel),
	"LIST",
	["Marker channel", "None disables deletion!"], 
	["[TCA] Miscellaneous", "Building Clear Markers"],
	[
		[-1, 0, 1, 2, 3, 4, 5], 
		["None", "Global", "Side", "Command", "Group", "Vehicle", "Direct"], 
		1
	], 
	0, 
	{}
] call CBA_fnc_addSetting; 





ADDON = true;