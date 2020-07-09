params ["_unit", "_uid", "_firstClass", "_secondClass"];

[_unit, _uid, "Unassign"] call Shadec_fnc_rolesAssign;
[_unit, _uid, "Assign"] call Shadec_fnc_rolesAssign;