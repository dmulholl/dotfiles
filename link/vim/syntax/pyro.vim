" Syntax definition file for Pyro.

syn match pyroComment "#.*$"

syn region pyroString start=+"+ end=+"+ skip=+\\\\\|\\"+
syn region pyroString start=+`+ end=+`+

syn match pyroNumber "\<\d\+\>"
" syn match pyroBuiltin "$\w\+"

syn keyword pyroKeyword if else var and or xor def class echo for while return break continue
syn keyword pyroAssert assert
syn keyword pyroImport import as from
syn keyword pyroConstant true false null self super

syn match pyroBuiltin "\<$clock\>"

" Default highlighting styles.
hi def link pyroComment Comment
hi def link pyroString String
hi def link pyroKeyword Statement
hi def link pyroAssert PreProc
hi def link pyroImport PreProc
hi def link pyroConstant Special
hi def link pyroNumber Constant
hi def link pyroBuiltin Type

let b:current_syntax = "pyro"
