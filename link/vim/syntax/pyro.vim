" Syntax definition file for Pyro.

syn match pyroComment "#.*$"

syn match pyroBuiltin "\$\w\+\>"

syn region pyroString start=+"+ end=+"+ skip=+\\\\\|\\"+
syn region pyroString start=+`+ end=+`+
syn region pyroChar start=+'+ end=+'+

syn keyword pyroKeyword var def class
syn keyword pyroKeyword if else for while in loop
syn keyword pyroKeyword return break continue
syn keyword pyroKeyword and nand or nor xor xnor
syn keyword pyroKeyword try echo
syn keyword pyroAssert assert
syn keyword pyroImport import as from
syn keyword pyroConstant true false null self super

" Numbers.
syn case ignore
syn match pyroNumber "\<\d\+\>"
syn match pyroNumber "\<0x\x\+\>"
syn match pyroNumber "\<0o\o\+\>"
syn match pyroNumber "\<\d\+\.\d*\(e[-+]\=\d\+\)\=\>"
syn match pyroNumber "\<\d\+e[-+]\=\d\+\>"
syn case match

" Default highlighting styles.
hi def link pyroComment Comment
hi def link pyroString String
hi def link pyroKeyword Statement
hi def link pyroAssert PreProc
hi def link pyroImport PreProc
hi def link pyroConstant Special
hi def link pyroNumber Constant
hi def link pyroBuiltin Normal
hi def link pyroChar Constant

let b:current_syntax = "pyro"
