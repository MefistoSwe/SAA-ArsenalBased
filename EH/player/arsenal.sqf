// Arsenal Handlers
// Restirct BIS Arsenal and Handle Ace Arsenal (Players are not allowed to 
// take any item from arsenal except uniform/vest/backpack/glasses/helmet/radio)

// BIS Arsenal Handler, close BIS arsenal.
[missionNamespace, "arsenalOpened", {
    disableSerialization;
    _display = _this select 0;
    _display closeDisplay 1;
	hint "BIS Arsenal is not allowed.";
}] call BIS_fnc_addScriptedEventHandler;

// ACE Arsenal Handler Opened
_EH_ArsenalOpened = ["ace_arsenal_displayOpened", {
    hint "";
    player setVariable["isArsenalOpened", true, true];
	private _uid = getPlayerUID player;
	if (player getVariable ["SAA_isArsenalRestricted", true]) then {};
 
}] call CBA_fnc_addEventHandler;

// ACE Arsenal Handler Closed
_EH_ArsenalClose = ["ace_arsenal_displayClosed", {
    player setVariable ["isArsenalOpened", false, true];
    private _uid = getPlayerUID player;
   if (player getVariable ["SAA_isArsenalRestricted", true]) then {};
}] call CBA_fnc_addEventHandler;

// Restrict "Open backpack" action on players who in ACE Arsenal;
player addEventHandler ["InventoryOpened",{
    params ["_unit","_container"];
    _override = false;
    _allUnitBackpackContainers = allUnits select {_x getVariable ["isArsenalOpened", false]} apply {backpackContainer _x};

        if (_container in _allUnitBackpackContainers) then {
            systemchat "> Server: This player in Arsenal right now. Access to his backpack is restricted.";
            _override = true;
        };

    _override
}];