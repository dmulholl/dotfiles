" Syntax definition file for Syntext.

" Metadata region.
syn region stxMeta start="\%^---$" end="^---$"

" Headings.
syn region stxHeadingText matchgroup=stxHeadingDelim start="^#\+\s\+" end="#*\s*$" oneline

" Link references.
syn region stxRefText matchgroup=stxRefDelim start="^ \{0,3\}!\=\[" end="\]:" oneline nextgroup=stxRefUrl skipwhite
syn match stxRefUrl "\S\+" nextgroup=stxRefTitle skipwhite contained
syn region stxRefTitle matchgroup=stxRefTitleDelim start=+"+ end=+"+ contained
syn region stxRefTitle matchgroup=stxRefTitleDelim start=+'+ end=+'+ contained

" Links.
syn region stxLinkText matchgroup=stxLinkDelim start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%([[(]\)\)\@=" end="\]\%([[(]\)\@=" nextgroup=stxLinkUrl,stxLinkRef oneline
syn region stxLinkUrl matchgroup=stxLinkDelim start="(" end=")" contained
syn region stxLinkRef matchgroup=stxLinkDelim start="\[" end="\]" contained

" Automatic links.
syn region stxAutoLink matchgroup=stxAutoLinkDelim start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" oneline

" Footnotes.
syn match stxFootnoteRef "\[^[^\]]\+\]"
syn match stxFootnoteRef "\[fn:[^\]]\+\]"

" Lists.
syn match stxUListMarker "^\s*[-*+]\s\+"
syn match stxOListMarker "^\s*[#][.]\s\+"

" Block lists.
syn match stxUListMarker "^\s*([-*+])\s\+"
syn match stxOListMarker "^\s*([#])\s\+"

" Definition lists.
syn region stxDLTerm matchgroup=stxDLTermDelim start="\[\[" end="\]\]" oneline contains=stxEntity

" Tags.
syn match stxTagLine "^\s*:.\+$"

" HTML entities.
syn match stxEntity "&[#a-zA-Z0-9]\+;"

" HTML comments.
syn region htmlComment start="<!--" end="-->"

" Default highlighting styles.
hi def link stxMeta Comment
hi def link htmlComment Comment
