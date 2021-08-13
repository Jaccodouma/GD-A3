params ["_str"]; 
[
	(_str splitString ","),
	{
		trim _x;
	}
] call CBA_fnc_filter;