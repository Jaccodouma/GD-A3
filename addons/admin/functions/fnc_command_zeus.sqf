// Add zeus to local player

systemChat "Adding zeus!";

_this = [name player];

// https://gist.github.com/dedmen/3fa5f648631dd14a4173edea7580045e

missionNamespace setVariable [_this select 0,player, true];
[0, {
	params ["_myName"];
	private _curVarName = _myName+"Cur";
	
	if (!isNil _curVarName) then {
		[-1, compile format["if (player == %1) then {%1 sideChat 'deleting Curator';}", _myName]] call CBA_fnc_globalExecute;
		deleteVehicle (missionNamespace getVariable [_curVarName, objNull]);
		missionNamespace setVariable [_curVarName, nil, true];
	};


	if (isNil _curVarName) then {
		[-1, compile format["if (player == %1) then {%1 sideChat 'creating Curator';}", _myName]] call CBA_fnc_globalExecute;

		if (isNil "DedmenCur_group") then {DedmenCur_group = creategroup sideLogic;};
		private _myCurObject = DedmenCur_group createunit["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];	//Logic Server
		_myCurObject setVariable ["showNotification",false];
		
		missionNamespace setVariable [_curVarName, _myCurObject, true];
		publicVariable "DedmenCur_group";
		unassignCurator _myCurObject;
		_cfg = (configFile >> "CfgPatches");
		_newAddons = [];
		for "_i" from 0 to((count _cfg) - 1) do {
			_name = configName(_cfg select _i);
			_newAddons pushBack _name;
		};
		if (count _newAddons > 0) then {_myCurObject addCuratorAddons _newAddons};

		_myCurObject setcuratorcoef["place", 0];
		_myCurObject setcuratorcoef["delete", 0];
		private _enableSyncVar = _myName+"_enableSync";
		private _val = random 500;
		missionNamespace setVariable [_enableSyncVar, random 500];
		[_enableSyncVar,_val] spawn {
			while  {(missionNamespace getVariable [_this select 0, 0]) == (_this select 1)} do {
			// {
			_myCurObject addCuratorEditableObjects[(allMissionObjects "All"), true];
			// } forEach allCurators;
			sleep 2;
		};};
		

	};
	private _myCurObject = missionNamespace getVariable [_curVarName, objNull];
	
	/* if (getAssignedCuratorUnit (_myCurObject) != dedmen) then {*/
	unassignCurator _myCurObject;
	sleep 0.4;
	player assignCurator _myCurObject;
	/* };*/
	[-1, compile format["if (player == %1) then {%1 sideChat 'you are Curator';}", _myName]] call CBA_fnc_globalExecute;
}, _this] call CBA_fnc_globalExecute;