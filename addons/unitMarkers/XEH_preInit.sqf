#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

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

ADDON = true;
