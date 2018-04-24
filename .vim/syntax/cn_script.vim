" Vim Syntax File for CN_Script
" Language: CN_Script
" Maintainer: Clara Nguyen
" Latest Revision: 2017-12-11
"
" Check: {{{1
if exists('b:current_syntax')
  finish
endif

" ------------------------------------
" Inline C Support: {{{1

let b:current_syntax = ''
unlet b:current_syntax
runtime! syntax/c.vim

let b:current_syntax = ''
unlet b:current_syntax
syn include @C syntax/c.vim

let b:current_syntax = ''
unlet b:current_syntax
syn region INLINE_C matchgroup=Snip start="__INLINE_C {" end="}" contains=@C

hi link Snip SpecialComment
let b:current_syntax = 'cn_script'

" ------------------------------------
" Keywords: {{{1

syn keyword cnsFunction dynamic func fend __INLINE_C
hi def link cnsFunction Keyword

syn keyword cnsObject struct object class oend
hi def link cnsObject Keyword

syn keyword cnsConditional if else ifend eif
hi def link cnsConditional Keyword

syn keyword cnsVariableType const ghost volatile
hi def link cnsVariableType Type

syn keyword cnsThisVar this
hi def link cnsThisVar Identifier

" ------------------------------------
" Comments: {{{1

"  Single Line Comment: {{{1
syn match CNS_SL_Comment '\/\/.*$'
hi def link CNS_SL_Comment Comment

"  Multi-Line Comment: {{{1
syn region CNS_ML_Comment start='\/\*' end='\*\/'
hi def link CNS_ML_Comment Comment

" ------------------------------------
" Data types: {{{1

"  Strings {{{1
syn region CNS_String start='"' end='"'
hi def link CNS_String constant

"  Import Statements {{{1
syn match CNS_ImportINIT '#import .*$' contains=CNS_Import
hi def link CNS_ImportINIT Identifier

syn match CNS_Import '\zeimport \zs["<][a-zA-Z_\/\\\.1-9]*[>"]' containedin=CNS_ImportINIT
hi def link CNS_Import constant

" ------------------------------------
" Function Calls {{{1

syn match CNS_Function 'func\(<.\{-}>\)\?' contains=CNS_Function_Parametre,CNS_Function_Name,CNS_Function_Type
hi def link CNS_Function Keyword

syn match CNS_Function_Parametre '\zefunc\zs\(<.\{-}>\)\?'
hi def link CNS_Function_Parametre constant

syn match CNS_Function_Name '[a-zA-Z_][a-zA-Z0-9_]*(.*)\ze{\?$' contains=CNS_Function_Type
hi def link CNS_Function_Name Function

syn match CNS_Function_Type '\ze\([,(] *\zs.\{-}\ze \).*{\?$' containedin=CNS_Function_Name
hi def link CNS_Function_Type Type

syn match CNS_Function_Type_Template '\ze<\zs\(.\{-},\? *\)\+\ze>' containedin=CNS_Function_Type
hi def link CNS_Function_Type_Template Keyword
