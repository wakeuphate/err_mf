# err_mf
Mission framework for http://sexyarmaboys.club


## Components

### Briefings

Side-specific briefings are available in `err/briefings`.

### Markers

Each player is shown markers on all friendly groups in the mission, updated every second while a group has at least one alive member.

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

### Custom scripts

Any custom scripts should be kept in the root mission folder, and called from the base `initPlayerLocal.sqf` and `initServer.sqf` files.
