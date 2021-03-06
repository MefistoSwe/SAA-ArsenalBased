//Player init
waitUntil {!isNull player};
if ((getPlayerUID player) in (missionNamespace getVariable "ZeusArray")) then {
	player setVariable ["SAA_isZeus", true, true];
	player setVariable ["SAA_isArsenalRestricted", false, true];
} else {
	player setVariable ["SAA_isZeus", false, true];
	player setVariable ["SAA_isArsenalRestricted", true, true];
};

// Welcome message while loadout is loading
titleText [format["<t color='#ff0000' size='2' align='center' valign='middle' font='PuristaBold'>%1</t><br/><br/><t size='1.5' align='center' valign='middle' font='EtelkaMonospacePro'>%2</t>", name player, "Welcome to Duty | Shadec Asgardian Alliance"], "BLACK FADED", 2, false, true];
playMusic ["EventTrack02a_F_EPA", 3];
sleep 3;

// Loading player data from server profile or assign zeus (if uid in ZeusArray)
[player] spawn Shadec_fnc_loadPlayer;
script_handler = [] spawn {sleep 3; titleFadeOut 3;};

waitUntil { scriptDone script_handler };
if (player getVariable ["SAA_isZeus", false]) then {
	[
		[format["%1 | Zeus", name player],2,1,10],
		[format["%1 | %2", toUpper worldName, mapGridPosition player],2,1,10],
		[format["%1h:%2m", date select 3, date select 4],2,1,10]
	] call BIS_fnc_EXP_camp_SITREP;
} else {
	_data = missionNamespace getVariable format["%1_DATA", getPlayerUID player];
	[
		[format["Rank: %1", _data # 0],2,1,10], 
		[format["Primary: %1", _data # 1],2,1,10], 
		[format["Additional: %1", _data # 2],1,1,10],
		[format[""],0,0,10],
		[format["%1 | %2", toUpper worldName, mapGridPosition player],2,1,10],
		[format["%1h:%2m", date select 3, date select 4],2,1,10]
	] call BIS_fnc_EXP_camp_SITREP;
};

// Recieve variables from server
["Check"] spawn Shadec_fnc_objectJamming; 
player setVariable ["tf_receivingDistanceMultiplicator", missionNamespace getVariable "tf_reciveVar"];
player setVariable ["tf_sendingDistanceMultiplicator", missionNamespace getVariable "tf_sendVar"];

// Delete Existing Markers if they were placed in Editor (Server solution is enough?)
{deleteMarker _x} forEach (allMapMarkers select {"respawn" in _x});

// Execute EHs
[] execVM "Mechanics\LowGear\LowGear_Init.sqf";
[] execVM "EH\player\arsenal.sqf";
[] execVM "EH\player\playerKilled.sqf";
[] execVM "EH\player\playerRespawn.sqf";