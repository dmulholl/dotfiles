" --------------------------------------------------------------------------
" Dusk Colour Scheme
" --------------------------------------------------------------------------

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

hi Comment          ctermfg=238
hi Constant         ctermfg=3
hi Identifier       ctermfg=2
hi Statement        ctermfg=5
hi PreProc          ctermfg=5
hi Type             ctermfg=4
hi Special          ctermfg=6
hi Underlined       ctermfg=2
hi Ignore           ctermfg=238
hi Error                                ctermbg=52
hi Todo             ctermfg=2

hi MatchParen                           ctermbg=8          cterm=bold
