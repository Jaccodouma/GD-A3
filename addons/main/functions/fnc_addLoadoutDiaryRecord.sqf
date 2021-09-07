#include "script_component.hpp"
// Updates the diary record to current things 
if !(GVAR(LoadoutDiaryRecord_Enabled)) exitWith {
	if (
		missionNameSpace getVariable ["TCA_Main_LoadoutDiaryRecord", ""] != ""
	) then {
		player removeDiaryRecord ["Diary", GVAR(LoadoutDiaryRecord)]; 
	};
};

fn_weaponString = {
	params [
		"_weapon", 
		"_muzzle",
		"_flashlight",
		"_optics",
		"_primaryMagazine", 
		"_secondaryMagazine", 
		"_bipod"
	];

	_s = ""; 

	_s = _s + format ["    <font face='PuristaBold'>%1</font>", getText (configFile >> "CfgWeapons" >> _weapon >> "displayName")]; 

	// Optic 
	if ("" != getText (configFile >> "CfgWeapons" >> _optics >> "displayName")) then {
		_s = _s + format ["<br/>      <font color='#AFAAAA'>Optic:</font> %1", getText (configFile >> "CfgWeapons" >> _optics >> "displayName")]; 
	};

	// Magazine 
	if (count _primaryMagazine > 0) then {
		_s = _s + format ["<br/>      <font color='#AFAAAA'>Magazine:</font> %1", getText (configFile >> "CfgMagazines" >> _primaryMagazine#0 >> "displayName")]; 
	};

	// Secondary magazine 
	if (count _secondaryMagazine > 0) then {
		_s = _s + format ["<br/>      <font color='#AFAAAA'>Secondary magazine:</font> %1", getText (configFile >> "CfgMagazines" >> _secondaryMagazine#0 >> "displayName")]; 
	};

	// Muzzle 
	if ("" != getText (configFile >> "CfgWeapons" >> _muzzle >> "displayName")) then {
		_s = _s + format ["<br/>      <font color='#AFAAAA'>Muzzle:</font> %1", getText (configFile >> "CfgWeapons" >> _muzzle >> "displayName")]; 
	};

	// Light
	if ("" != getText (configFile >> "CfgWeapons" >> _flashlight >> "displayName")) then {
		_s = _s + format ["<br/>      <font color='#AFAAAA'>Light:</font> %1", getText (configFile >> "CfgWeapons" >> _flashlight >> "displayName")]; 
	};

	// Bipod
	if ("" != getText (configFile >> "CfgWeapons" >> _bipod >> "displayName")) then {
		_s = _s + format ["<br/>      <font color='#AFAAAA'>Bipod:</font> %1", getText (configFile >> "CfgWeapons" >> _bipod >> "displayName")]; 
	};

	_s = _s + "<br/>";

	_s
};

fn_AssignedItems = {
	// Uniform, Vest, Backpack, Helmet, NVG's, Binoculars, GPS, Compass
	_a = []; 

	{
		if (_x != "") then {
			_a pushBack _x
		}
	} forEach [
		getText (configFile >> "CfgWeapons" >> uniform player >> "displayName"),
		getText (configFile >> "CfgWeapons" >> vest player >> "displayName"),
		getText (configFile >> "CfgVehicles" >> backpack player >> "displayName"),
		getText (configFile >> "CfgWeapons" >> headgear player >> "displayName"),
		getText (configFile >> "CfgWeapons" >> hmd player >> "displayName")
	];

	_a
};

fn_invString = {
	_s = ""; 

	// Items 
	_s = _s + format ["    <font face='PuristaBold'>Items</font>"]; 
	{
		_x params ["_item", "_count"];
		_s = _s + format ["<br/>        %2 <font color='#AFAAAA'>(%1x)</font>", _count, getText (configFile >> "CfgWeapons" >> _item >> "displayName")]; 
	} forEach ((items player) call FUNC(arrToCount));

	// Assigned items 
	_s = _s + format ["<br/><br/>    <font face='PuristaBold'>Assigned Items</font>"]; 
	{
		_s = _s + format ["<br/>        %1", _x]; 
	} forEach ([] call fn_AssignedItems);

	_s
};

// Create loadout record
GVAR(LoadoutDiaryRecord) = player createDiaryRecord [
	"Diary", 
	["Loadout", ""], 
	taskNull, "", false
]; 

// Compile string for each weapon
_weaponString = "";
{
	_weaponString = _weaponString + (_x call fn_weaponString) + "<br/>";
} forEach (weaponsItems player);

_invString = [] call fn_invString; 

// Compile final text 
_text = format ["
<font size='20'  face='PuristaBold'>Current Loadout</font>
<br/><font size='16'  face='PuristaBold'>Weapons</font>
<br/>%1
<br/><font size='16'  face='PuristaBold'>Inventory</font>
<br/>%2
", _weaponString, _invString];

player setDiaryRecordText [
	["Diary", GVAR(LoadoutDiaryRecord)], 
	["Loadout", _text]
];