" --------------------------------------------------------------------------
" Dusk Colour Scheme
" --------------------------------------------------------------------------

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "dusk"

hi Comment          ctermfg=8
hi Normal           ctermfg=none        ctermbg=none
hi NonText          ctermfg=none        ctermbg=none
hi LineNr           ctermfg=8
hi CursorLineNr     ctermfg=8
hi String           ctermfg=3
hi Keyword          ctermfg=2
hi Statement        ctermfg=2
hi Function         ctermfg=4
hi PreProc          ctermfg=5
hi Constant         ctermfg=6
hi Character        ctermfg=6
hi Number           ctermfg=6
hi Visual                               ctermbg=237
hi Search                               ctermbg=237
hi MatchParen                           ctermbg=none        cterm=underline
hi StatusLine       ctermfg=244         ctermbg=0
