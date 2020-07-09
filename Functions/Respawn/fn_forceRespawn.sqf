params["_target", "_time"];
_target = _this # 0;
_time = _this # 1;

//Check if var exists

if !((typeName _time) isEqualTo "SCALAR") exitWith {["> Error: Invalid function parameters."] remoteExec ["systemChat"]};
if (_time < 2) then {_time = 2};

if !((typeName _target) isEqualTo "STRING") exitWith {["> Error: Invalid function parameters."] remoteExec ["systemChat"]};
if (_target isEqualTo "All") then {
	[_time] remoteExec ["setPlayerRespawnTime"];
	[format["> Server: All players will be respawned in %1 seconds.", _time]] remoteExec ["systemChat"];
} else {
	_players = allPlayers;
	_targetList = _players apply {name _x};
	_idList = _players apply {owner _x};

	_result = (_targetList find _target);
	if (_result isEqualTo -1) exitWith {["> Error: Can't find player with given name."] remoteExec ["systemChat"]};
	[_time] remoteExec ["setPlayerRespawnTime", _idList # _result];
	[format["> Server: %1 will be respawned in %2 seconds.", _target ,_time]] remoteExec ["systemChat"];
};

//return
true