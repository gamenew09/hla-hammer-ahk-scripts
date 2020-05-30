; Make sure that we are working relative to our script and not to the running script

SetWorkingDir, %A_ScriptDir%
#Include %A_ScriptDir%

; Include utility functions (PasteText)
#Include ../utils.ahk

; Make sure all functions in here can use the Hammer Window Position & Size variables.
global Hammer_X
global Hammer_Y
global Hammer_W
global Hammer_H

; Finds the text that says "Entity Class:" and clicks the combo box next to the text.
ClickEntityClassComboBox()
{
    ; Search for the "Entity Class:" text that is present in the entity tool window.
    ImageSearch, entclasstextx, entclasstexty, 0, 0, Hammer_W, Hammer_H, *2 ../assets/createentity/ent_class_text.png

    if(ErrorLevel = 1)
    {
        ; If the ImageSearch command could not find the "active" version of the text, check for the inactive version of the text.
        ImageSearch, entclasstextx, entclasstexty, 0, 0, Hammer_W, Hammer_H, *2 ../assets/createentity/ent_class_text_deselected.png
    }

    if (ErrorLevel = 2) ; Invalid command arguments
        MsgBox Could not conduct the search.
    else if (ErrorLevel = 1) ; Couldn't find image
        MsgBox Entity Class text could not be found on the screen.
    else
    {
        ; If ent class text was found click inside of the box
        ; Say about 100 pixels in and 10 pixels down.
        MouseClick Left, entclasstextx + 100, entclasstexty + 10, 1, 0
    }
}

; Search for entity tool (or its selected variant)
; TODO: Account for highlighted entity tool, with cursor possibly in way.

; Selects the entity tool, selects the entity given in entName, and then places it where the mouse is located.
; Example: CreateEntityAtMousePos("npc_combine_s")
CreateEntityAtMousePos(entName)
{
    ; Make sure that the Hammer Editor is actually open.
    if(WinExist("Hammer"))
    {
        ; Disable user input for this function
        ; If the user holds Ctrl+Shift, it affects the pasting process.
        BlockInput, On
        WinActivate, Hammer ; Make sure Hammer is in focus. (Maybe just check if it is active instead?)
        WinGetPos, Hammer_X, Hammer_Y, Hammer_W, Hammer_H, Hammer ; Get the position and size of the hammer window for use later.

        MouseGetPos, entityAtPointX, entityAtPointY ; Store where the mouse is so we can place a entity at this point.

        CoordMode, Pixel, Relative ; Make sure our CoordMode is in Relative for Image Searches.

        ; Look for the Entity Tool button on the Hammer Editor window.
        ImageSearch, enttoolx, enttooly, 0, 0, Hammer_W, Hammer_H, *2 ../assets/createentity/entity_tool.png

        if(ErrorLevel = 1)
        {
            ; If we couldn't find the "inactive" variant, look for the selected variant.
            ImageSearch, enttoolx, enttooly, 0, 0, Hammer_W, Hammer_H, *2 ../assets/createentity/entity_tool_selected.png
        }

        if (ErrorLevel = 2) ; Invalid arguments, check to make sure the assets are in the proper locations.
            MsgBox Could not conduct the Entity Tool Icon search.
        else if (ErrorLevel = 1) ; Couldn't find icon in general.
            MsgBox Could not find Entity Tool Icon on screen.
        else
        {
            ; Click the Icon button.
            MouseClick, Left, enttoolx, enttooly, 1, 0

            ; Wait 100 ms
            Sleep, 100

            ; Click the entity class combo box.
            ClickEntityClassComboBox()

            ; Make sure we actually found and clicked the box.
            if(ErrorLevel = 0)
            {
                ; Select all text (sometimes it likes to only select a poriton of the text)
                Send, ^a
                ; Paste the text (see utils.ahk)
                PasteText(entName)
                ; Press enter (makes the combobox inactive and sets the entity 100%)
                Send, {Enter}

                ; Wait 30 ms, makes sure that everything was sent properly
                Sleep, 30

                ; Click where the mouse was before the script started
                ; This should place the entity, unless the mouse was outside the viewport.
                MouseClick, Left, entityAtPointX, entityAtPointY, 1, 0
            }
        }
        ; Make sure that we unblock the users input no matter what.
        ; We don't want to end up preventing the user from using their computer.
        BlockInput, Off
    }
    else
    {
        ; If Hammer is not open, make sure the user of this script knows.
        MsgBox, HLA Hammer is not open.
    }
}