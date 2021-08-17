#include "script_component.hpp"

params ["_vehicle"];

_crew = crew _vehicle; 
_text = name (_crew select 0);
if (count _crew >= 2) then {_text = _text + ", " + name (_crew select 1)};
if (count _crew >= 3) then {_text = _text + ", " + name (_crew select 2)};
if (count _crew >= 4) then {_text = _text + " +" + str (count _crew - 3)};

_text