highlight clear
if exists("syntax on")
    syntax reset
endif

set background=light

let g:colors_name="sb"

"#153A51 dark blue bg

" Colors
" let s:black = "#61605F"
let s:black = 0
" let s:light_black = "#A8A7A6"
let s:light_black = 8
" let s:red = "#CC7070"
let s:red = 1
" let s:light_red = "#F2DFDF"
let s:light_red = 9
" let s:green = "#5D9875"
let s:green = 2
" let s:light_green = "#DAF0E3"
let s:light_green = 10
" let s:yellow = "#AC855D"
let s:yellow = 3
" let s:light_yellow = "#F0E7DD"
let s:light_yellow = 11
" let s:blue = "#2F8BA7"
let s:blue = 14
" let s:light_blue = "#D0EAF2"
let s:light_blue = 12
" let s:magenta = "#B573A0"
let s:magenta = 5
" let s:light_magenta = "#F7E1F0"
let s:light_magenta = 13
" let s:cyan = "#1B8D8D"
let s:cyan = 6
" let s:light_cyan = "#D8EDED"
let s:light_cyan = 14
" let s:white = "#F3F2F1"
let s:white = 7
" let s:dark_white = "#EBEAE9"
let s:dark_white = 15

" Syntax aliases
let s:fg = s:black
let s:bg = s:white
let s:sec_fg = s:light_black
let s:sec2_fg = s:dark_white
let s:empty_style = "NONE"
let s:underline = "underline"
let s:italic = "italic"

" Utils
fun! Determine_syntax_group()
    echo map(
        \ synstack(line('.'), col('.')),
        \ 'synIDattr(v:val, "name") . " -> " . synIDattr(synIDtrans(v:val), "name")'
        \)
endfun

fun! s:set_color(id, fg, bg, style)
    " exe 'hi! ' . a:id . ' gui=' . a:style . ' guifg=' . a:fg . ' guibg=' . a:bg
    exe 'hi! ' . a:id . ' cterm=' . a:style . ' ctermfg=' . a:fg . ' ctermbg=' . a:bg
endfun


let s:scheme = [
\   ["Normal", s:fg, s:bg, s:empty_style],
\   ["SignColumn", s:sec_fg, s:bg, s:empty_style],
\   ["EnfOfBuffer", s:empty_style, s:empty_style, s:empty_style],
\   ["MsgArea", s:empty_style, s:empty_style, s:empty_style],
\   ["FoldColumn", s:sec_fg, s:bg, s:empty_style],
\   ["Folded", s:sec_fg, s:bg, s:empty_style],
\   ["VertSplit", s:sec2_fg, s:sec2_fg, s:empty_style],
\   ["LineNr", s:sec_fg, s:bg, s:empty_style],
\   ["Directory", s:sec_fg, s:bg, s:empty_style],
\   ["Pmenu", s:fg, s:sec2_fg, s:empty_style],
\   ["PmenuSel", s:fg, s:light_magenta, s:empty_style],
\   ["PmenuSbar", s:empty_style, s:empty_style, s:empty_style],
\   ["PmenuThumb", s:empty_style, s:empty_style, s:empty_style],
\   ["WildMenu", s:fg, s:sec2_fg, s:empty_style],
\   ["Question", s:fg, s:sec2_fg, s:empty_style],
\   ["MoreMsg", s:fg, s:sec2_fg, s:empty_style],
\   ["ModeMsg", s:fg, s:sec2_fg, s:empty_style],
\   ["StatusLine", s:sec_fg, s:sec2_fg, s:empty_style],
\   ["StatusLineNC", s:sec_fg, s:sec2_fg, s:empty_style],
\   ["TabLine", s:sec_fg, s:sec2_fg, s:empty_style],
\   ["TabLineFill", s:sec_fg, s:sec2_fg, s:empty_style],
\   ["TabLineSel", s:sec_fg, s:light_magenta, s:empty_style],
\   ["Cursor", s:fg, s:empty_style, s:empty_style],
\   ["CursorIM", s:fg, s:empty_style, s:empty_style],
\   ["Conceal", s:sec2_fg, s:empty_style, s:empty_style],
\   ["CursorLine", s:empty_style, s:empty_style, s:empty_style],
\   ["CursorLineNr", s:empty_style, s:empty_style, s:empty_style],
\   ["CursorColumn", s:empty_style, s:empty_style, s:empty_style],
\   ["ColorColumn", s:empty_style, s:empty_style, s:empty_style],
\   ["Menu", s:empty_style, s:empty_style, s:empty_style],
\   ["Scrollbar", s:empty_style, s:empty_style, s:empty_style],
\   ["Tooltip", s:empty_style, s:empty_style, s:empty_style],
\   ["Visual", s:empty_style, s:light_yellow, s:empty_style],
\   ["VisualNOS", s:empty_style, s:light_yellow, s:empty_style],
\   ["Search", s:empty_style, s:light_magenta, s:empty_style],
\   ["IncSearch", s:empty_style, s:light_magenta, s:empty_style],
\   ["MatchParen", s:empty_style, s:light_magenta, s:empty_style],
\   ["SpellBad", s:empty_style, s:light_red, s:empty_style],
\   ["SpellCap", s:empty_style, s:light_yellow, s:empty_style],
\   ["SpellLocal", s:empty_style, s:light_yellow, s:empty_style],
\   ["SpellRare", s:empty_style, s:light_yellow, s:empty_style],
\   ["DiffAdd", s:empty_style, s:light_green, s:empty_style],
\   ["DiffChange", s:empty_style, s:light_yellow, s:empty_style],
\   ["DiffDelete", s:empty_style, s:sec2_fg, s:empty_style],
\   ["DiffText", s:empty_style, s:empty_style, s:empty_style],
\   ["Keyword", s:yellow, s:empty_style, s:empty_style],
\   ["Operator", s:fg, s:empty_style, s:empty_style],
\   ["Identifier", s:fg, s:empty_style, s:empty_style],
\   ["Function", s:cyan, s:empty_style, s:empty_style],
\   ["Number", s:green, s:empty_style, s:empty_style],
\   ["String", s:fg, s:empty_style, s:italic],
\   ["TypeDef", s:magenta, s:empty_style, s:empty_style],
\   ["Error", s:red, s:light_red, s:empty_style],
\   ["ErrorMsg", s:red, s:empty_style, s:empty_style],
\   ["WarningMsg", s:yellow, s:empty_style, s:empty_style],
\   ["TODO", s:sec_fg, s:light_magenta, s:empty_style],
\   ["Comment", s:sec_fg, s:empty_style, s:empty_style],
\   ["Underlined", s:fg, s:empty_style, s:underline]
\ ]

for x in s:scheme | call s:set_color(x[0], x[1], x[2], x[3]) | endfor

""
"" Keyword
""
hi! link Boolean Keyword
hi! link Conditional Keyword
hi! link Repeat Keyword
hi! link Label Keyword
hi! link Exception Keyword
hi! link PreProc Keyword
hi! link Statement Keyword
hi! link shCommandSub Keyword
hi! link Title Keyword
hi! link mkdHeading Keyword
hi! link CSVColumnHeaderEven Keyword
hi! link CSVColumnEven Keyword
hi! link jsStorageClass Keyword
hi! link jsTemplateBraces Keyword
hi! link jsNull Keyword

""
"" Operator
""
hi! link Special Operator
hi! link SpecialChar Operator
hi! link Delimiter Operator
hi! link Tag Operator
hi! link Debug Operator
hi! link helpSpecial Special
hi! link shEscape Operator
hi! link jsxPunct Operator
hi! link jsxCloseString Operator

""
"" Identifier
""
hi! link Type Identifier
hi! link shDeref Identifier
hi! link Constant Identifier

""
"" Function
""
hi! link jsArrowFunction Function
hi! link vimUserFunc Function
hi! link vimFunction Function
hi! link mkdCodeStart Function
hi! link mkdCodeEnd Function
hi! link phpFunction Function
hi! link phpMethod Function

""
"" Number
""
hi! link Float Number

""
"" String
""
hi! link Character String
hi! link mkdLink String
hi! link CSVColumnHeaderOdd String
hi! link CSVColumnOdd String

""
"" Type
""
hi! link phpType TypeDef
hi! link mkdBlockquote TypeDef

""
"" Error
""
hi! link NvimInternalError ErrorMsg
hi! link CocErrorSign Error

""
"" Comment
""
hi! link NonText Comment
hi! link SpecialKey Comment
hi! link shShebang Comment
hi! link mkdUrl Comment


""
"" HTML
""
hi! link htmlTag Operator
hi! link htmlTitle Noise
hi! link htmlTagName Function
hi! link htmlArg Keyword
hi! link htmlH1 Noise

""
"" CSS
""
hi! link cssBraces Operator
hi! link cssTagName Function
hi! link cssIdentifier Function
hi! link cssClassName Function
hi! link cssClassNameDot Operator
hi! link cssPseudoClassId TypeDef
hi! link cssUnitDecorators Noise
hi! link cssAttributeSelector Function
hi! link cssAttr String
hi! link cssProp Keyword

""
"" PHP
""
hi! link phpVarSelector Keyword
hi! link phpNullValue Keyword

""
"" VIM
""
hi! link vimVar Identifier
hi! link vimGroup TypeDef
hi! link vimContinue Comment

""
"" Shell
""
hi! link shTestOpr Keyword
hi! link shSource Keyword

""
"" Git
""
hi! link gitcommitSummary Noise
hi! link gitcommitHeader Noise
hi! link gitcommitBranch Function

""
"" Log
""
hi! link logDate logTime
