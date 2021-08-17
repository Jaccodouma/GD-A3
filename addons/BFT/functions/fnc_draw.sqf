#include "script_component.hpp"

_playersGroupDecryptCodes = (group player getVariable ["BFT_groupMarker_decryptCodes", []]) + (group player getVariable ["BFT_groupMarker_encryptCodes", [str side group player]]);

{
	if !(_x getVariable ["BFT_groupMarker_visible", false]) then {continue;};
	if (count units _x <= 0) then {continue;};

	if(_x != group player) then {
		// Dont bother with cryption if is players group!
		_canSeeOtherGroup = false;

		// todo: replace with arrayIntersect
		_targetGroupsEncryptCodes = _x getVariable ["BFT_groupMarker_encryptCodes", [str side _x]];
		{
			if((_targetGroupsEncryptCodes find _x) > -1) then {
				// The player has a decrypt code which matches an encrypt code
				_canSeeOtherGroup = true;
				break;
			}		
		} forEach _playersGroupDecryptCodes;
		if(!_canSeeOtherGroup) then {continue;};

	};

	_sameSide = side _x == side (group player);

	// Position
	_markerPos = [_x] call FUNC(getGroupPosition);

	// Type & Color 
	_markerType = _x getVariable ["BFT_groupMarker_type", "inf"];
	_markerColor = _x getVariable ["BFT_groupMarker_color", [side _x, true] call BIS_fnc_sideColor];

	_markerSide = [_x] call FUNC(getGroupMarkerShape);

	// Create marker
	_marker = createMarkerLocal [groupId _x, _markerPos];
	_marker setMarkerShapeLocal "ICON";

	_markerText = groupId _x;
	
	if(!_sameSide && GVAR(groupMarkers_fuzzOtherFactions)) then {
		// if the group is a different side, then lets set that group to unknown text / default side colours. 
		_markerType = "unknown";
		_markerText = str (side _x);
		_markerColor = [side _x, true] call BIS_fnc_sideColor;
	};

	_marker setMarkerTypeLocal (_markerSide + "_" + _markerType);
	_marker setMarkerTextLocal _markerText;
	_marker setMarkerColorLocal _markerColor;

	if(_x != group player) then {
		// Don't care about showing cryption if is players group
		_targetGroupsEncryptCodes = _x getVariable ["BFT_groupMarker_encryptCodes", [str side _x]];
		_targetGroupCryptCodes = (_targetGroupsEncryptCodes) + (_x getVariable ["BFT_groupMarker_decryptCodes", []]);
		_targetCanSeeUs = false;
		// todo: replace with arrayIntersect
		{
			if((_targetGroupCryptCodes find _x) > -1) then {
				_targetCanSeeUs = true;
				break;
			}
		} forEach (group player getVariable ["BFT_groupMarker_encryptCodes",[str side group player]]);
		if(!_targetCanSeeUs) then {	
			// visually indicate that the other group cannot see our marker
			_marker setMarkerAlphaLocal 0.6;
		} else {
			_marker setMarkerAlphaLocal 1;
		};

	};

	// Add marker to array 
	BFT_GroupMarkers pushBack _marker;
} forEach allGroups;