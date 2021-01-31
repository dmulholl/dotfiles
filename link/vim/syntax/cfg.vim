" Syntax definition file for context-free grammar files.

syn region Constant start="\"" end="\""

syn match Comment "#.*$"
syn match Comment "[();*+?=|]"

" Turn off default styles for .cfg files.
let b:current_syntax = "cfg"
