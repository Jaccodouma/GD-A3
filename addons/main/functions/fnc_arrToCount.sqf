#include "script_component.hpp"

_oldArr = _this;

_items = []; 
_count = [];

{
	if ((_items find _x) >= 0) then {
		// if _x exists, add 1
		_count set [_items find _x, _count#(_items find _x)+1];
	} else {
		// create new
		_items pushBack _x; 
		_count pushBack 1;
	};
} forEach _oldArr;

_newArr = []; 

{
	_newArr pushBack [_x, _count#_forEachIndex];
} forEach _items;

_newArr