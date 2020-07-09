params ["_box", "_uniformType", "_clear","_additionalInfo"]; // Object, Uniform type, clear object inventory, type info to players

[_box, true] call ace_arsenal_fnc_removeBox;

if (_clear isEqualTo 1) then {
	clearWeaponCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackpackCargoGlobal _box;
};

_arsenalObjects = missionNamespace getVariable ["arsenalObjects", []];
_arsenalObjects pushBack _box;
missionNamespace setVariable ["arsenalObjects", _arsenalObjects, true];

_box setVariable ["_uniformType", _uniformType, true];

if (_additionalInfo isEqualTo 1) then {
	{hint parseText format ["<t align='center'>Arsenal was assigned</t><t align='center'><img size='4' image='%1'/></t><br/><br/><t align='center' shadow='1' shadowColor='#000000'>%2</t><br/><t align='center' color='#ffffff' shadow='1' shadowColor='#000000'>Direction: %3</t><br/><t align='center' color='#ffffff' shadow='1' shadowColor='#000000'>Distance: %4</t>", getText(configfile >> "CfgVehicles" >> typeOf (missionNamespace getVariable "arsenalObject") >> "picture"), getText (configFile >> "CfgVehicles" >> typeOf (missionNamespace getVariable "arsenalObject") >> "displayName"), floor ([player, (missionNamespace getVariable "arsenalObject")] call BIS_fnc_dirTo), round (player distance (missionNamespace getVariable "arsenalObject"))]} remoteExec ["call", -2];
};

["> Server: Arsenal added."] remoteExec ["systemChat"]; // A couple of words about rearm?