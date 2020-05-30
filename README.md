# Half-Life: Alyx Workshop Tool AutoHotkey Scripts

This repository contains some scripts that should be useful while making maps for Half-Life: Alyx.
It may be possible to use parts of these scripts with the SteamVR Home Tools but may need a bit editing before they work.

## Notable Scripts
 - [`entities/createentity.ahk`](entities/createentity.ahk)
    - Contains the `CreateEntityAtMousePos(entName)` function which creates an entity by the `entName` name at the mouse position.
 - [`entities/npc_combine_s.ahk`](entities/npc_combine_s.ahk)
    - A script that spawns the `npc_combine_s` entity.
    - The script was made in mind for the [Elgato Stream Deck](https://www.elgato.com/en/gaming/stream-deck). **However**, that does not mean the script will not launch unless a Stream Deck is used.
        - The script also comes with a [super simple icon](assets/streamdeckicons/npc_combine_s.png) for use with the Stream Deck, if you so choose to use it.
 - [`utils.ahk`](utils.ahk)
    - Contains helpful functions that are used in the scripts above.