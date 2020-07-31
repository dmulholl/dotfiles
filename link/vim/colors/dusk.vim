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
hi LineNr                   ctermfg=236
hi CursorLineNr             ctermfg=248         ctermbg=233         cterm=none
hi CursorLine                                   ctermbg=233         cterm=none
hi Visual                                       ctermbg=235
hi NonText                  ctermfg=233
hi MatchParen                                   ctermbg=236         cterm=bold
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
hi StatusA4                 ctermfg=black       ctermbg=6
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
hi Comment                  ctermfg=242                             cterm=italic
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
