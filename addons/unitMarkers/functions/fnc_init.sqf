/*
	Author: Jacco Douma 

	Description: 
	Draw players on map when zoomed in far enough

	Parameter(s): none

	Returns: 
	nothing
*/
#include "script_component.hpp"

call FUNC(addActions);

_fnc_addEH = {
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
		params ["_control"];
		_maxScale = 250; // Max scale for the icons & text

		_scale = (10^(abs log (ctrlMapScale _control))) min _maxScale; 

		_alpha = [0.03*_scale-0.2, 0, 1] call BIS_fnc_clamp;

		if (_alpha > 0) then {
			// Players that have already been marked (when they're in a vehicle with someone else);
			private _alreadyMarkedPlayers = [];  
			
			_textSize = (0.0015 * 0.13) * _scale;

			{
				// _x = unit to mark 
				private ["_icon","_color","_pos","_dir","_text"];

				_markerSize = (1.8 * 0.13) * _scale;

				// Dont' remark already marked players 
				if (_x in _alreadyMarkedPlayers) then {continue};

				if !(_x != vehicle _x) then { // Unit is not in vehilce
					// Basic things 
					_text = name _x; 
					_pos = getPos _x; 
					_dir = getDir _x; 

					_icon = _x getVariable ["diwako_dui_radar_compass_icon", call FUNC(getUnitIcon)];

					// Color 
					_color = [playerSide, false] call BIS_fnc_sideColor;
					if (player in (units group _x)) then {
						_color = + (_x getVariable "diwako_dui_main_compass_color"); // + cause otherwise we get locality issues 
						if (_x getVariable ["ACE_isUnconscious", false]) then {_color = [1, 0.5, 0];};
					} else {
						_color = [playerSide, false] call BIS_fnc_sideColor;
					};
				} else { // Unit is in vehicle
					// Icon (Get from config)
					_icon = getText (configfile >> "CfgVehicles" >> typeOf vehicle _x >> "icon");

					// Color (Color if all the same team, otherwise white) (Still to do, lazy atm)
					_color = [vehicle _x] call FUNC(getVehicleIconColor);

					// Position 
					_pos = getPos vehicle _x; 
					_dir = getDir vehicle _x; 

					// Text
					_text = [vehicle _x] call FUNC(getVehicleText);

					// Increase marker size;
					_markerSize = _markerSize * 2.5; 

					// Add all units in vehicle to _alreadyMarkedPlayers
					_alreadyMarkedPlayers append (crew vehicle _x); 
				};

				// Set alpha
				_color set [3, _alpha];

				// Draw icon
				_this select 0 drawIcon [
					_icon,
					_color,
					_pos,
					_markerSize,
					_markerSize,
					_dir,
					_text,
					1,
					_textSize,
					diwako_dui_font,
					"right"
				];
			} forEach (call FUNC(getUnitsToBeMarked));
		};
	}];
};

[
	{!isNull (findDisplay 12 displayCtrl 51)}, 
	_fnc_addEH
] call CBA_fnc_waitUntilAndExecute; 