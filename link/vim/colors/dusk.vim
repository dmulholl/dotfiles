" ----------------------
"   Dusk Colour Scheme
" ----------------------

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "dusk"

hi Normal           ctermfg=none        ctermbg=none

" Interface elements.
hi LineNr           ctermfg=233
hi CursorLineNr     ctermfg=233
hi StatusLine       ctermfg=242         ctermbg=0
hi StatusLineNC     ctermfg=236         ctermbg=0
hi Visual                               ctermbg=235
hi Search                               ctermbg=235
hi NonText          ctermfg=233
hi MatchParen                           ctermbg=8           cterm=bold
hi ErrorMsg         ctermfg=9           ctermbg=0           
hi VertSplit        ctermfg=236         ctermbg=236

" Spellcheck.
hi SpellBad                             ctermbg=52
hi SpellLocal                           ctermbg=none
hi SpellRare                            ctermbg=none
hi SpellCap                             ctermbg=none

" Content categories.
hi Comment          ctermfg=240
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

" NERDTree plugin.
hi NERDTreeDir      ctermfg=4
hi NERDTreeDirSlash ctermfg=4

" Markdown.
hi markdownItalic   ctermfg=5
hi markdownBold     ctermfg=4
hi markdownH1       ctermfg=5

" Clear unwanted highlights.
hi clear texItalStyle
hi clear texBoldStyle
hi clear texEmpStyle
