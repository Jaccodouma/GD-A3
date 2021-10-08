#include "script_component.hpp"

// Make sure admin menu subject exists 
GVAR(adminMenuSubject) = player createDiarySubject ["Admin", "Admin"];
if (missionNamespace getVariable [QGVAR(adminmenuRecord), ""] isEqualTo "") then {
	GVAR(adminmenuRecord) = player createDiaryRecord ["Admin", ["Admin", ""], taskNull,	"", false];
}; 


// Add menu 
/**
	Layout: 
	Title + Refresh
	Self/misc (add zeus, end mission, some other things?)

	List of squads with players and options: 
	 - Heal
	 - TP to x
	 - make medic, engi, squad lead 
	 - show full arsenal
	
	List of dead people (spectating)
	 - Revive options (where)
*/

_fn_groupsWithPlayers = {
	private _allGroupsWithPlayers = [];
	{_allGroupsWithPlayers pushBackUnique group _x} forEach allPlayers;
	_allGroupsWithPlayers
};

/*
	[player] call ace_medical_status_fnc_getBloodLoss
	[player] call ace_medical_status_fnc_isInStableCondition
	[player] call ace_medical_status_fnc_hasStableVitals
	[0.4] call ace_medical_gui_fnc_damageToRGBA
	[0.4] call ace_medical_gui_fnc_bloodLossToRGBA
*/
_fn_playerColor = {
	params ["_unit"];
	(_unit getVariable ["ace_medical_bodypartdamage", [0,0,0,0,0,0]]) params ["_head", "_body", "_arm_l", "_arm_r", "_leg_l", "_leg_r"]; 
	_dmg = ((_head*1)+(_body*1)+(_arm_l*0.25)+(_arm_r*0.25)+(_leg_l*0.25)+(_leg_r*0.25))/2; 
	_rgba = [_dmg] call ace_medical_gui_fnc_bloodLossToRGBA; //ace_medical_gui_fnc_damageToRGBA;
	_html = _rgba call BIS_fnc_colorRGBAtoHTML;
	_html
};

_fn_listPlayers = {
	_str = ""; 

	_deadPlayers = []; 

	{
		// Add group header 
		_str = _str + format ["<br/><font size='16' face='PuristaBold'>%1</font>", groupId _x];

		{
			if (!isPlayer _x) then {continue;};

			// Add unit text
			_str = _str + format ["<br/><font color='%2'>%1</font> ", name _x, [_x] call _fn_playerColor];
			_str = _str + format ["<execute expression='[""%1""] call %2'>[Heal]</execute> ", 	getPlayerUID _x, QFUNC(command_heal)];
			_str = _str + format ["<execute expression='[""%1""] call %2'>[TP]</execute> ", 	getPlayerUID _x, QFUNC(command_teleport)];
			_str = _str + format ["<execute expression='[""%1""] call %2'>[Medi]</execute> ", 	getPlayerUID _x, QFUNC(command_makeMedic)];
			_str = _str + format ["<execute expression='[""%1""] call %2'>[Engi]</execute> ", 	getPlayerUID _x, QFUNC(command_makeEngineer)];
			_str = _str + format ["<execute expression='[""%1""] call %2'>[Arsenal]</execute> ",getPlayerUID _x, QFUNC(command_arsenal)];
			_str = _str + "<br/>";
		} forEach units _x;
	} forEach (call _fn_groupsWithPlayers);

	// Dead units 
	_str = _str + "<br/><font size='16' face='PuristaBold'>Dead ones</font>";
	{
		// Current result is saved in variable _x
		_str = _str + format ["<br/><font color='%2'>%1</font> ", name _x, '#676767'];
		_str = _str + format ["<execute expression='[] remoteExec [%2, %1]'>[Respawn]</execute> ", 	owner _x, QFUNC(command_respawn)];
	} forEach _deadPlayers;

	_str
};


// Compile list
// <br/><execute expression='[] call %3'>[Add Zeus]</execute>
_text = format ["
<font size='20' face='PuristaBold'>Admin menu </font><execute expression='[] call %2;'>[Reload]</execute>
<br/><execute expression='[""%4""] remoteExec [""%3"", 2]'>[Add Zeus]</execute>
<br/><font size='20' face='PuristaBold'>Players</font>
%1",
call _fn_listPlayers, 
QFUNC(updateAdminMenu), 
QFUNC(command_zeus), 
getPlayerUID player
];

player setDiaryRecordText [
	["Admin", GVAR(adminmenuRecord)], 
	["Admin", _text]
]; 

if (missionNamespace getVariable [QGVAR(adminMenu_TPUnit), ""] != "") then {
	systemChat str GVAR(adminMenu_TPUnit);
};