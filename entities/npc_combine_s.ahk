; Make sure that multiple instances of the script are not open.
#SingleInstance, force

; Make sure the include location is relative to the script
#Include %A_ScriptDir%
; Include the CreateEntityAtMousePos function from createentity.ahk
#Include createentity.ahk

; Run the CreateEntityAtMousePos function in createentity.ahk
;   This should create a "npc_combine_s" entity at the mouse location, if the mouse location is in the viewport.
CreateEntityAtMousePos("npc_combine_s")