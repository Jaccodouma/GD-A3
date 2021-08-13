params ["_str"]; 
[
	(_str splitString ","),
	{
		toUpper trim _x;
	}
] call CBA_fnc_filter;