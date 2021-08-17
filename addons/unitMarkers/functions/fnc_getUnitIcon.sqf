#include "script_component.hpp"

private _player = [] call CBA_fnc_currentUnit;
private _iconNamespace = missionNamespace getVariable format["diwako_dui_main_icon_%1", diwako_dui_icon_style];
[_x, _iconNamespace, _player, true] call diwako_dui_radar_fnc_getIcon;