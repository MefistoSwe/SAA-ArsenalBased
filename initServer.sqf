// Init Zeus
[] execVM "initZeus.sqf";
// Load players data
[] execVM "playersData.sqf";

// Execute EHs
[] execVM "EH\server\playerConnected.sqf";
[] execVM "EH\server\playerDisconnected.sqf";
[] execVM "EH\server\playerKilled.sqf";
[] execVM "EH\server\playerRespawned.sqf";

// Define TFAR variables
missionNamespace setVariable ["tf_reciveVar", 1, true];
missionNamespace setVariable ["tf_sendVar", 1, true];

// Delete all respawn markers if some of them were defined in editor
{deleteMarker _x} forEach (allMapMarkers select {"respawn" in _x});

// Define respawnTime var with value from Description.ext
respawnTime = getNumber (missionConfigFile >> "respawnDelay");
missionNamespace setVariable ["respawnTime", respawnTime, true];