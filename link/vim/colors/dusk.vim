" ------------------------------------------------------------------------------
" Dusk Colour Scheme
" ------------------------------------------------------------------------------

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "dusk"

hi Normal           ctermfg=none        ctermbg=none

hi LineNr           ctermfg=233
hi CursorLineNr     ctermfg=233
hi StatusLine       ctermfg=238         ctermbg=0
hi Visual                               ctermbg=235
hi Search                               ctermbg=235
hi NonText          ctermfg=4

hi Comment          ctermfg=238
hi Constant         ctermfg=3
hi Identifier       ctermfg=none
hi Statement        ctermfg=4
hi PreProc          ctermfg=5
hi Type             ctermfg=4
hi Special          ctermfg=3
hi Underlined       ctermfg=2
hi Ignore           ctermfg=238
hi Error                                ctermbg=52
hi Todo             ctermfg=2           ctermbg=none

hi MatchParen                           ctermbg=8          cterm=bold
