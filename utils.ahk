; Pastes text given in the pasteText parameter using Windows Clipboard.
; This function will save the clipboard data before editing it, so it shouldn't delete anything in the clipboard.

; Code inside function block from https://stackoverflow.com/a/27398950
; Modified to fit function formula better.
PasteText(pasteText)
{
    savedClip := ClipboardAll
    Clipboard := ""
    Clipboard := pasteText
    ClipWait, 2
    if(!ErrorLevel)
        Send, ^v
    Sleep, 300
    Clipboard := savedClip
    savedClip =
}