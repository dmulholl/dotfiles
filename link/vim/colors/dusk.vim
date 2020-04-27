" ----------------------
"   Dusk Colour Scheme
" ----------------------

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "dusk"

hi Normal                   ctermfg=none        ctermbg=none

" Interface elements.
hi LineNr                   ctermfg=233
hi CursorLineNr             ctermfg=233
hi Visual                                       ctermbg=237
hi NonText                  ctermfg=233
hi MatchParen                                   ctermbg=8           cterm=bold
hi ErrorMsg                 ctermfg=9           ctermbg=0           
hi VertSplit                ctermfg=234         ctermbg=234

" Status line.
hi StatusLine               ctermfg=234         ctermbg=245         cterm=reverse
hi StatusLineNC             ctermfg=234         ctermbg=0           cterm=reverse
hi StatusLineTerm           ctermfg=234         ctermbg=245         cterm=reverse
hi StatusLineTermNC         ctermfg=234         ctermbg=0           cterm=reverse

" Custom status line color blocks for (A)ctive and (I)nactive windows.
hi StatusA1                 ctermfg=black       ctermbg=4
hi StatusA2                 ctermfg=245         ctermbg=236
hi StatusA3                 ctermfg=245         ctermbg=234
hi StatusI1                 ctermfg=black       ctermbg=238
hi StatusI2                 ctermfg=black       ctermbg=236
hi StatusI3                 ctermfg=black       ctermbg=234

" Search.
hi Search                   ctermfg=none        ctermbg=237

" Spellcheck.
hi SpellBad                                     ctermbg=52
hi SpellLocal                                   ctermbg=none
hi SpellRare                                    ctermbg=none
hi SpellCap                                     ctermbg=none

" Content categories.
hi Comment                  ctermfg=240
hi Constant                 ctermfg=3
hi Identifier               ctermfg=4                               cterm=bold
hi Statement                ctermfg=5
hi PreProc                  ctermfg=5
hi Type                     ctermfg=4
hi Special                  ctermfg=3
hi Underlined               ctermfg=2
hi Ignore                   ctermfg=238
hi Error                                        ctermbg=52
hi Todo                     ctermfg=2           ctermbg=none

" Python.
hi pythonDecoratorName      ctermfg=5

" NERDTree plugin.
hi NERDTreeDir              ctermfg=4
hi NERDTreeDirSlash         ctermfg=4

" Markdown.
hi markdownItalic           ctermfg=5
hi markdownBold             ctermfg=4
hi markdownH1               ctermfg=5
hi markdownH2               ctermfg=5
hi markdownH3               ctermfg=5

" Clear unwanted Latex highlights.
hi clear texItalStyle
hi clear texBoldStyle
hi clear texEmphStyle
