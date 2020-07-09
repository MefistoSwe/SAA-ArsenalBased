params ["_unit"];
_unit = _this # 0;
_uid = getPlayerUID _unit;
_data = [_uid,_unit];

if (_unit getVariable ["SAA_isZeus", false]) exitWith {
	[] call Shadec_fnc_addZeusModules;
    [[player, "assign"], Shadec_fnc_manageCurators] remoteExec ["call", 2];
    _unit addAction [ localize "str_SAA_ASSIGN_ZEUS_ACTION", {
        [[player, "assign"], Shadec_fnc_manageCurators] remoteExec ["call", 2];
    }];
};

// Load action