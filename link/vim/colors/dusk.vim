" ----------------------
"   Dusk Colour Scheme
" ----------------------

set background=dark
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "dusk"

hi Normal                   ctermfg=none        ctermbg=none

" Interface elements. For explanations search :h highlight-groups.
hi LineNr                   ctermfg=236
hi CursorLineNr             ctermfg=15          ctermbg=235         cterm=none
hi CursorLine                                   ctermbg=235         cterm=none
hi Visual                                       ctermbg=237
hi NonText                  ctermfg=233
hi MatchParen                                   ctermbg=237         cterm=bold
hi ErrorMsg                 ctermfg=1           ctermbg=0
hi WarningMsg               ctermfg=6           ctermbg=0
hi VertSplit                ctermfg=234         ctermbg=234
hi ModeMsg                  ctermfg=8
hi MoreMsg                  ctermfg=2
hi Question                 ctermfg=2
hi ColorColumn                                  ctermbg=233

" Visible whitespace.
hi SpecialKey               ctermfg=236

" Popup menus.
hi Pmenu                    ctermfg=246         ctermbg=17
hi PmenuSel                 ctermfg=15          ctermbg=53
hi PmenuSbar                                    ctermbg=19
hi PmenuThumb                                   ctermbg=21

" Status line.
hi StatusLine               ctermfg=234         ctermbg=245         cterm=reverse
hi StatusLineNC             ctermfg=234         ctermbg=0           cterm=reverse
hi StatusLineTerm           ctermfg=234         ctermbg=245         cterm=reverse
hi StatusLineTermNC         ctermfg=234         ctermbg=0           cterm=reverse

" Custom status line color blocks for (A)ctive and (I)nactive windows.
hi StatusA1                 ctermfg=black       ctermbg=4
hi StatusA2                 ctermfg=245         ctermbg=236
hi StatusA3                 ctermfg=245         ctermbg=234
hi StatusA4                 ctermfg=black       ctermbg=1
hi StatusI1                 ctermfg=black       ctermbg=238
hi StatusI2                 ctermfg=black       ctermbg=236
hi StatusI3                 ctermfg=black       ctermbg=234

" Search.
hi Search                   ctermfg=none        ctermbg=238

" Spellcheck.
hi SpellBad                                     ctermbg=52
hi SpellLocal                                   ctermbg=none
hi SpellRare                                    ctermbg=none
hi SpellCap                                     ctermbg=none

" Content categories.
hi Comment                  ctermfg=242                             cterm=italic
hi Todo                     ctermfg=242                             cterm=italic
hi Constant                 ctermfg=3
hi PreProc                  ctermfg=5                               cterm=bold
hi String                   ctermfg=2
hi Identifier               ctermfg=4
hi Statement                ctermfg=4                               cterm=bold
hi Type                     ctermfg=4
hi Special                  ctermfg=3
hi Underlined               ctermfg=2
hi Ignore                   ctermfg=238
hi Error                                        ctermbg=52
hi Todo                     ctermfg=2           ctermbg=none

" Python.
hi pythonDecoratorName      ctermfg=5
" hi pythonString             ctermfg=2
" hi pythonQuotes             ctermfg=2

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

" Syntext.
hi stxHeadingText           ctermfg=5
hi stxHeadingDelim          ctermfg=242
hi stxHeadingLine           ctermfg=242
hi stxMeta                  ctermfg=242
hi stxRefText               ctermfg=4
hi stxRefDelim              ctermfg=242
hi stxRefUrl                ctermfg=3
hi stxRefTitle              ctermfg=5
hi stxRefTitleDelim         ctermfg=5
hi stxLinkText              ctermfg=4                               cterm=underline
hi stxLinkDelim             ctermfg=242
hi stxLinkUrl               ctermfg=242
hi stxLinkRef               ctermfg=242
hi stxAutoLink              ctermfg=4
hi stxAutoLinkDelim         ctermfg=242
hi stxFootnoteRef           ctermfg=242
hi stxUListMarker           ctermfg=1
hi stxOListMarker           ctermfg=1
hi stxBlockquote                                                    cterm=italic
hi stxTagLine               ctermfg=242
hi stxDLTerm                ctermfg=5
hi stxDLTermDelim           ctermfg=242
hi stxEntity                ctermfg=242

" Rust.
hi rustCommentLineDoc       ctermfg=242

" C.
hi cTodo                    ctermfg=242                             cterm=italic
