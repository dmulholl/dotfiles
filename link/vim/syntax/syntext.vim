" Vim syntax file

" Metadata region.
syn region stxMeta start="\%^---$" end="^---$"

" Headings.
syn region stxHeadingText matchgroup=stxHeadingDelim start="^\s*#\+\s\+" end="#*\s*$" oneline
syn match stxHeadingLine "^\s*----\+\s*$"

" Link references.
syn region stxRefText matchgroup=stxRefDelim start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=stxRefUrl skipwhite
syn match stxRefUrl "\S\+" nextgroup=stxRefTitle skipwhite contained
syn region stxRefTitle matchgroup=stxRefTitleDelim start=+"+ end=+"+ keepend contained
syn region stxRefTitle matchgroup=stxRefTitleDelim start=+'+ end=+'+ keepend contained

" Links.
syn region stxLinkText matchgroup=stxLinkDelim start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%([[(]\)\)\@=" end="\]\%([[(]\)\@=" nextgroup=stxLinkUrl,stxLinkRef oneline
syn region stxLinkUrl matchgroup=stxLinkDelim start="(" end=")" keepend contained
syn region stxLinkRef matchgroup=stxLinkDelim start="\[" end="\]" keepend contained

" Automatic links.
syn region stxAutoLink matchgroup=stxAutoLinkDelim start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

" Footnotes.
syn match stxFootnoteRef "\[^[^\]]\+\]"

" Lists.
syn match stxUListMarker "^\s*[-*+]\s\+"
syn match stxOListMarker "^\s*[#][.]\s\+"

" Definition lists.
syn region stxDLTerm matchgroup=stxDLTermDelim start="\[\[" end="\]\]" oneline contains=stxEntity

" Tags.
syn match stxTagLine "^\s*:.\+$"
" syn region stxBlockquote matchgroup=stxTagLine start="^\s*::: quote.*$" end="^\s*::: end$"

" HTML entities.
syn match stxEntity "&[#a-zA-Z0-9]\+;"

" Default highlighting styles.
hi def link stxMeta Comment

