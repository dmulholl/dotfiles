" Vim syntax file

" Headings.
syn region stxHeadingText matchgroup=stxHeadingDelimiter start="^\s*##\@!" end="#*\s*$" oneline
syn region stxHeadingText matchgroup=stxHeadingDelimiter start="^\s*###\@!" end="#*\s*$" oneline
syn region stxHeadingText matchgroup=stxHeadingDelimiter start="^\s*####\@!" end="#*\s*$" oneline
syn region stxHeadingText matchgroup=stxHeadingDelimiter start="^\s*#####\@!" end="#*\s*$" oneline
syn region stxHeadingText matchgroup=stxHeadingDelimiter start="^\s*######\@!" end="#*\s*$" oneline
syn region stxHeadingText matchgroup=stxHeadingDelimiter start="^\s*#######\@!" end="#*\s*$" oneline
syn match stxHeadingLine "^\s*----\+\s*$"

" YAML front matter.
syn match stxMeta /\%^---\_.\{-}---$/

" Link references.
syn region stxRefText matchgroup=stxRefDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=stxRefUrl skipwhite
syn match stxRefUrl "\S\+" nextgroup=stxRefTitle skipwhite contained
syn region stxRefTitle matchgroup=stxRefTitleDelimiter start=+"+ end=+"+ keepend contained
syn region stxRefTitle matchgroup=stxRefTitleDelimiter start=+'+ end=+'+ keepend contained

" Links.
syn region stxLinkText matchgroup=stxLinkDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%([[(]\)\)\@=" end="\]\%([[(]\)\@=" nextgroup=stxLinkUrl,stxLinkRef oneline
syn region stxLinkUrl matchgroup=stxLinkDelimiter start="(" end=")" keepend contained
syn region stxLinkRef matchgroup=stxLinkDelimiter start="\[" end="\]" keepend contained

" Automatic links.
syn region stxAutoLink matchgroup=stxAutoLinkDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

" Footnotes.
syn match stxFootnoteRef "\[^[^\]]\+\]"

" Default highlighting styles.
hi def link stxMeta Comment

" Lists.
syn match stxUListMarker "^\s*[-*+]\s\+"
syn match stxOListMarker "^\s*[#][.]\s\+"

