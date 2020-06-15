# err_mf
Mission framework for http://sexyarmaboys.club


## Components

### Briefings

Side-specific briefings are available in `err/briefings`.

### Gear

Gear scripts are defined in `err/gear/configs/`, with one file per faction. If you don't want to use these, you don't need to, and modifying unit loadouts using the ACE Arsenal is just as effective.

To apply a gear loadout to a unit using a config, add the following line to a unit's init field in the editor:

```
  [this, "RU", "CO"] call err_gear_fn_assignGear;
```

If you do not wish to use the gear loadouts, just remove any lines of code from all units init fields. DO NOT remove any gear files or configs from the mission.

### Markers

Each player is shown markers on all friendly groups in the mission, updated every second (while a group has at least one alive member).

These can be disabled by commenting out (adding a `//` to the beginning of the line) line 20 in `err/initPlayerLocal.sqf`, like so:

```
// [] spawn err_markers_fnc_playerInit;
```

### Safety

At the beginning of the mission, all players are put into safety mode, meaning that all grenades and projectiles are deleted.
This will remain in place until the admin disables safety using an scroll-menu option.

This can be disabled for gimmicks by commenting out (adding a `//` to the beginning of the line) line 23 in `err/initPlayerLocal.sqf`, like so:

```
// [] spawn err_safety_fnc_playerInit;
```

### Spectator

Uses simple respawn template from err_configs to setup ACE Spectator with all view options (which also handles TFAR).

### Group Deploy

Using a function from err_configs, you can allow group leaders to instantly deploy their group using the map. This can be limited to placed markers, or allowed anywhere. Add the following code to `initPlayerLocal.sqf` and modify the parameters in order to do so:

```
  [
    true, 		// Deployment enabled by default.
              // When true, all clients with deployment actions can deploy as soon as the mission begins.
              // When false, `[true] call err_deploy_fnc_setDeploymentStatus` must be called on clients before they can deploy.

    west,			// Defending side.
    
    ["defend_area"],	// List of defense area markers.
                      // Only the defending side can deploy to these areas.
                      // When empty, defending side can deploy anywhere outside of attacking zones.

    ["attack_area"]		// List of offense area markers.
                      // Only the attacking side can deploy to these areas.
                      // When empty, attacking side can deploy anywhere outside of defending zones.
  ] call err_deploy_fnc_setupDeployment;
```

In order to limit deploy functions to particular sides or units, you can use `if statements` to check the player the function is being called on, like below:

```
  // All BLUFOR leaders will get a deploy action:
  if (side player == west) then {
    // DEPLOY CODE GOES HERE
  };
```

```
  // Only the Emir is allowed to deploy, inshallah:
  if (player == emir) then {
    // DEPLOY CODE GOES HERE
  };
```

### Custom scripts

Any custom scripts should be kept in the root mission folder, and called from the base `initPlayerLocal.sqf` and `initServer.sqf` files.
