" Enable using ctrl+z and ctrl+s without side-effects

silent !stty -ixon

""
"" Editor core
""
set nocompatible
filetype plugin indent on
syntax enable
set hidden
set backspace=indent,eol,start
set whichwrap+=[,],h,l
set noswapfile
set nobackup
set insertmode
set encoding=utf-8
set clipboard=unnamedplus
set history=50
set shortmess+=qc
set timeoutlen=100
let loaded_netrw = 0

""
"" Editor performance
""
set nocursorline
set nocursorcolumn
set scrolljump=5
set nofoldenable
set foldmethod=manual
set foldlevel=0
set lazyredraw
set redrawtime=5000
set updatetime=300

""
"" Editor behaviour
""
" Indentation
set expandtab autoindent smartindent tabstop=4 softtabstop=4 shiftwidth=4
" Soft wrap
set wrap linebreak breakindent breakindentopt=shift:4
" Basic formatting
set formatoptions=2ql
" Completion
set complete=.,b,u,t,i
set completeopt=menu
" set omnifunc=syntaxcomplete#Complete
" In-text search
set incsearch nohlsearch ignorecase smartcase wrapscan
" Match pairs
set showmatch matchpairs+=<:>
" Remove trailing whitespaces after saving a buffer
autocmd BufWritePre * let b:pos = [line('.'), col('.')]
            \ | %s/\s\+$//e
            \ | :call cursor(b:pos[0], b:pos[1])

""
"" Editor UI
""
set guicursor=a:block-blinkon0 number signcolumn=yes
set showcmd cmdheight=1 noshowmode noruler laststatus=2 nomodeline
set statusline=%#StatusLineNC#%r\ %.60F\ %y\ %{&fenc}%=Col:\ %c\ \|\ Line:\ %l/%L
set t_Co=16
" Command line completion by <Tab>
set wildmenu wildmode=longest:full,full

""
"" Package manager
""
let g:pkgs_dir = '~/.vim'
if empty(glob(g:pkgs_dir . '/autoload/plug.vim'))
    " Auto install package manager if is not installed
    echom 'Please wait! Package manager installing...'
    silent execute '!curl -fLo ' . g:pkgs_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

" Packages list
call plug#begin(g:pkgs_dir . '/plugged')
" Toggle comments
Plug 'tpope/vim-commentary'
" Search everything interface
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Language syntax
Plug 'sheerun/vim-polyglot'
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'prabirshrestha/vim-lsp'
call plug#end()

" LSP
let g:coc_node_path = '/usr/bin/node'
let g:coc_user_config = {
            \ "npm.binPath": '/usr/bin/npm',
            \ "suggest.autoTrigger": "none",
            \ "suggest.floatEnable": v:false,
            \ "suggest.triggerCompletionWait": 500,
            \ "suggest.maxCompleteItemCount": 10,
            \ "suggest.minTriggerInputLength": 10,
            \ "suggest.snippetIndicator": "",
            \ "suggest.preferCompleteThanJumpPlaceholder": v:true,
            \ "suggest.noselect": v:false,
            \ "suggest.keepCompleteopt": v:true,
            \ "suggest.echodocSupport": v:true,
            \ "signature.target": "echo",
            \ "signature.triggerSignatureWait": 250,
            \ "signature.preferShownAbove": v:false,
            \ "signature.messageTarget": "echo",
            \ "diagnostic.level": "error",
            \ "diagnostic.enableMessage": "never",
            \ "diagnostic.refreshOnInsertMode": v:false,
            \ "diagnostic.locationlistUpdate": v:false,
            \ "diagnostic.refreshAfterSave": v:false,
            \ "diagnostic.checkCurrentLine": v:false,
            \ "diagnostic.messageTarget": "echo",
            \ "diagnostic.messageDelay": 500,
            \ "diagnostic.warningSign": "#",
            \ "diagnostic.errorSign": "*",
            \ "diagnostic.infoSign": "",
            \ "diagnostic.hintSign": "",
            \ "coc.preferences.hoverTarget": "echo",
            \ "coc.preferences.bracketEnterImprove": v:false,
            \ "coc.preferences.snippets.enable": v:false,
            \ "coc.preferences.extensionUpdateCheck": "never",
            \ "coc.preferences.maxFileSize": "5MB",
            \ "coc.preferences.enableFloatHighlight": v:false,
            \ "coc.preferences.messageLevel": "error",
            \ "coc.preferences.floatActions": v:false,
            \ "coc.preferences.enableMarkdown": v:false,
            \ "emmet.showExpandedAbbreviation": v:false,
            \ "emmet.includeLanguages": ["html", "javascript", "php"],
            \ "emmet.excludeLanguages": [],
            \ "codeLens.enable": v:false
            \ }
hi! link CocErrorHighlight Error
hi! link CocWarningHighlight WarningMsg
hi! link CocUnderline Underlined

" FZF settings
let g:fzf_layout = { 'window': {'width': 0.75, 'height': 0.75, 'border': 'sharp'} }
let g:fzf_preview_window = []
" autocmd! FileType fzf
autocmd FileType fzf set noinsertmode
    \| autocmd BufLeave <buffer> set insertmode

" Show file search after start on directory
" autocmd VimEnter * nested
"             \ if argc() == 1 && isdirectory(argv()[0])
"             \ | sleep 100m
"             \ | exe "call fzf#vim#files(
"             \   (argv()[0] == getcwd()) ? getcwd() : getcwd() . '/' . argv()[0]
"             \ )"
"             \ | endif


" Filetype specific
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 breakindentopt=shift:2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 breakindentopt=shift:2
autocmd FileType svelte setlocal shiftwidth=2 tabstop=2 softtabstop=2 breakindentopt=shift:2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2 breakindentopt=shift:2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 breakindentopt=shift:2
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 breakindentopt=shift:2

autocmd FileType php,html :iabbrev <buffer> dd@ echo<space>"<pre>";var_dump();die;
autocmd FileType php,html :iabbrev <buffer> ddl@ static<space>function<space>($x)<cr>{<cr>echo<space>"<pre>";var_dump($x);die;<cr>return<space>$x;<cr>}
autocmd FileType javascript,html :iabbrev <buffer> cl@ console.log

fun! PhpSyntaxOverride()
    " user defined plain function
    syn match phpFunctions /\$\=\<[a-z]\=\K\k\{-}\ze(/
    " user defined functions assignied to variables
    syn match phpFunctions /\$\=\K\k\{-}\ze\s\{-}=.\{-}\(function\|fn\)/
    " arrow function
    syn match phpFunctions /\(fn.\{-}\)\@<==>/
    " arrow function keyword
    syn keyword phpKeyword fn self
    " fix highlighting built-in functions
    syn keyword phpFunctions empty isset
    syn keyword phpKeyword abstract final private protected public static const
    " type in definition of function's parameter
    syn match phpType /\\\=\K\k\{-}\(\s\$\.\{-}\)\@=/ containedin=phpParent
    syn match phpType /\():\s\=\)\@<=\\\=\K\k\+\((\)\@!=/
    " const
    syn match phpConstants /[A-Z_]\+\>/
endfun

fun! CssSyntaxOverride()
    syn keyword cssProp object-fit object-position
endfun

fun! ShellSyntaxOverride()
    syn match shStatement /\$(\|\(\$.\{-}\)\@<=)/
    syn keyword shStatement alias local
endfun

augroup syntaxOverride
    autocmd!
    autocmd FileType sh call ShellSyntaxOverride()
    autocmd FileType php call PhpSyntaxOverride()
    autocmd FileType css call CssSyntaxOverride()
augroup END


""
"" Funcs
""
fun! _do(...)
    let l:icmd = get(a:, '1', '')
    let l:vcmd = get(a:, '2', l:icmd)

    let l:exec = "\<C-\>\<C-o>"

    return mode() == 'i' ? l:exec . l:icmd : "\<Esc>i" . l:exec . l:vcmd
endfun

fun! _command_prompt()
    echo "> "
    return _do(":")
endfun

fun! _save_file()
    return _do(":w\<cr>")
endfun

fun! _close_file()
    return _do(":bdelete\<cr>")
endfun

fun! _quit()
    return _do(":q!\<cr>")
endfun

fun! _open_file()
    return _do(":call fzf#vim#files(
                \ (argv()[0] == getcwd())
                \   ? getcwd()
                \   : (isdirectory(argv()[0])
                \       ? getcwd() . '/' . argv()[0]
                \       : fnamemodify(getcwd() . '/' . argv()[0], ':h'))
                \ )\<cr>")
endfun

fun! _switch_files()
    return _do(":call fzf#vim#buffers()\<cr>")
endfun

fun! _recent_files()
    return _do(":History\<cr>")
endfun

fun! _stop_hlight()
    augroup vimrc-incsearch-highlight
        autocmd!
        autocmd CmdlineEnter /,\? :set hlsearch
        autocmd CmdlineLeave /,\? :set nohlsearch
    augroup END
    set nohlsearch
    return "\<Esc>"
endfun

fun! _search()
    augroup vimrc-incsearch-highlight
        autocmd!
        autocmd CmdlineEnter /,\? :set hlsearch
    augroup END
    call feedkeys("1\<C-?>")
    return _do("/", 'gv"zy' . _do("/\<c-r>z"))
endfun

fun! _search_global()
    return _do(":call fzf#vim#grep(
                \   'rg --smart-case
                \       -uu
                \       --line-number
                \       --no-heading
                \       --color=always
                \       --colors=line:fg:black
                \       --colors=path:fg:black
                \       --colors=match:none
                \       --colors=column:none
                \       -- .',
                \   1
                \ )\<cr>")
endfun

fun! _replace()
    echo "Replace, input <from>/<to>"
    return _do(":,$s//c\<left>\<left>", ":'<,'>s//gc\<left>\<left>\<left>")
endfun

fun! _greplace()
    echo "Global replace in opened files, input <from>/<to>"
    return _do(":bufdo %s//gc\<left>\<left>\<left>")
endfun

fun! _show_errors()
    call coc#rpc#request('fillDiagnostics', [bufnr('%')])
    return _do(":call fzf#run(fzf#wrap({'source': map(getloclist('%'), {k, v -> get(v, 'lnum') . ':' .get(v, 'col') . '\t' . get(v, 'text')}), 'sink': {x -> cursor(split(split(x, ' ')[0], ':')[0], split(split(x, ' ')[0], ':')[1])}, 'options': '--prompt=Errors: '}))\<cr>")
endfun

fun! _repeat()
    return _do('.')
endfun

fun! _comment()
    let l:cmd = ":Commentary\<cr>"
    return _do(l:cmd, _select() . l:cmd)
endfun

fun! _undo()
    return _do(":undo\<cr>")
endfun

fun! _redo()
    return _do(":redo\<cr>")
endfun

fun! _delete()
    return _do("i\<BS>", _select() . 'd')
endfun

fun! __copy()
    let @a = join(map(split(@a, "\n"), {k, v -> trim(v)}), "\n")
    " windows wsl tweak
    if system('uname -r') =~ 'microsoft'
        call system('clip.exe', @a)
    endif
endfun

fun! _copy()
    let l:cmd = '"ay' . _do(":call __copy()\<cr>")
    return _do("^" . _do('vg_') . l:cmd, _select() . l:cmd)
endfun

fun! _cut()
    let l:cmd = '"ad' . _do(":call __copy()\<cr>")
    return _do("^" . _do('vg_') . l:cmd, _select() . l:cmd)
endfun

fun! _paste()
    let l:cmd = '"aP' . _do('=`]')

    return _do(l:cmd, _delete() . l:cmd)
endfun

fun! _dup()
    return _do(":t.\<cr>", _select() . ":t'>\<cr>")
endfun

fun! _join()
    return _do("vJ", _select() . "J")
endfun

fun! _indent()
    return _do("i\<Tab>", _select() . ">")
endfun

fun! _outdent()
    return _do("i\<Bs>", _select() . "<")
endfun

fun! _smart_selection()
    let l:objs = ['(', ')', '{', '}', '[', ']', '"', "'", '`', '<', '>', 'w', 'p']
    let l:obj = nr2char(getchar())

    if index(l:objs, l:obj) < 0
        return ""
    endif

    let l:cmd = 'i' . l:obj

    return _do('v' . l:cmd)
endfun

fun! _select_all()
    return _do("gg") . _do("vG$")
endfun

fun! _select()
    return _do("gv")
endfun

fun! _up()
    return _old_pos() . _do("gk") . _new_pos()
endfun

fun! _down()
    return _old_pos() . _do("gj") . _new_pos()
endfun

fun! _left()
    return _old_pos() . _do("h") . _new_pos()
endfun

fun! _right()
    return _old_pos() . _do("l") . _new_pos()
endfun

fun! _old_pos()
    return _do("m<", "")
endfun

fun! _new_pos()
    return _do("m>")
endfun

fun! _goto_last_change()
    return _do("g;")
endfun

fun! _goto_line_start()
    return _old_pos() . _do("^") . _new_pos()
endfun

fun! _goto_line_end()
    return _old_pos() . _do("g_") . _new_pos()
endfun

fun! _goto_line_n()
    let l:line = input('')
    let l:cmd = ":call cursor(" . l:line . ", 1)\<cr>" . _new_pos()

    return _old_pos() . _do(l:cmd, l:cmd . _select())
endfun

fun! _goto_char()
    let l:x = nr2char(getchar())
    call matchadd("Search", l:x)
    exe 'redraw!'

    let l:y = nr2char(getchar())
    call clearmatches()

    let l:search_pattern = l:x . "\\ze" . l:y

    call search(l:search_pattern, 'nW')
    let @/ = l:search_pattern

    return _goto_next_found() . _do("", _select())
endfun

fun! _goto_next_found()
    return _old_pos() . _do("n") . _new_pos()
endfun

fun! _goto_prev_found()
    return _old_pos() . _do("N") . _new_pos()
endfun

fun! _goto_next_error()
    return _do(":call CocAction('diagnosticNext', 'error')\<cr>")
endfun

fun! _goto_prev_error()
    return _do(":call CocAction('diagnosticPrevious', 'error')\<cr>")
endfun

" очень интересно очень_интересно оченьИнтересно
fun! _goto_next_word()
    let l:word_pattern = '\([^a-zA-Zа-яА-Я0-9]\|\n\)\zs[a-zA-Zа-яА-Я0-9]'
    let l:camel_case_pattern = '[a-zа-я0-9]\zs[A-ZА-Я]'
    let l:word_end_pattern = '[a-zA-Zа-яА-Я0-9]\ze\([^a-zA-Zа-яА-Я0-9]\|\n\)'

    let l:search_pattern = l:word_pattern . '\|'
                \ . l:camel_case_pattern . '\|'
                \ . l:word_end_pattern

    if l:search_pattern != @/
        call search(l:search_pattern, 'nW')
        let @/ = l:search_pattern
    endif

    return _goto_next_found()
endfun

fun! _goto_prev_word()
    return _left() . _goto_next_word() . _goto_prev_found()
endfun

fun! _complete_word(x)
    let l:line = getline('.')
    let l:prev_char = strpart(l:line, col('.') - 2, 1)

    if (pumvisible())
        return a:x == 'n' ? "\<C-n>" : "\<C-p>"
    endif

    if (l:prev_char == " " || col('.') == 1)
        return a:x == 'n' ? _indent() : _outdent()
    endif
    return coc#refresh()
    " return "\<C-x>\<C-o>"
endfun

fun! _format()
    let l:cmd = ":\<C-u>silent call CocAction('formatSelected', visualmode())\<cr>"
    return _do('v=', _select() . '=')
                \ . _do("^" . _do('vg_') . l:cmd, _select() . l:cmd)
endfun

" fun! _close_panel()
"     if (get(getloclist(0, {'winid':0}), 'winid', 0))
"         return _do('') . ":lclose\<cr>"
"     endif

"     return "\<ESC>"
" endfun

fun! _bind(k, v)
    if empty(a:k) || empty(a:v)
        echoe("hotkey or action cannot be empty")
    endif

    exe 'vnoremap <silent> <expr> ' . a:k . ' ' . a:v
    exe 'inoremap <silent> <expr> ' . a:k . ' ' . a:v
endfun

fun! _normalize_builtin_bindings()

    " Remove all bindings
    let l:keyboard_keys = ['<space>', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '_', '-', '=', '`', '/', '?', ')', '(', '[', ']', '{', '}', '"', '"']
    let l:keyboard_modif = ['C', 'ESC', 'S']

    for l:keyboard_key in l:keyboard_keys
        exe 'noremap ' . l:keyboard_key . " <Nop>"
    endfor
    for l:keyboard_modif in l:keyboard_modif
        for l:keyboard_key in l:keyboard_keys
            if (l:keyboard_modif == 'C' && index(['ESC', '['], l:keyboard_key) > -1)
                continue
            endif

            if (l:keyboard_modif != 'S')
                exe 'inoremap <' . l:keyboard_modif . '-' . l:keyboard_key . "> <Nop>"
            endif
            exe 'noremap <' . l:keyboard_modif . '-' . l:keyboard_key . "> <Nop>"
        endfor
    endfor

    " Normalize Enter
    inoremap <silent> <cr> <cr>
    vnoremap <silent> <cr> do

    " Normalize Space
    for l:k_key in l:keyboard_keys
        exe 'vnoremap <silent> ' . l:k_key . ' di' . l:k_key
    endfor

    " Normalize Selection
    vnoremap <silent> <Up> <Esc>
    vnoremap <silent> <Down> <Esc>
    vnoremap <silent> <Left> <Esc>
    vnoremap <silent> <Right> <Esc>
endfun

""
"" Hotkeys
""
let g:hotkeys = {
            \ "<ESC>`": "_command_prompt()",
            \ "<C-q>": "_quit()",
            \ "<C-s>": "_save_file()",
            \ "<C-w>": "_close_file()",
            \ "<Esc>1": "_switch_files()",
            \ "<Esc>2": "_open_file()",
            \ "<Esc>3": "_recent_files()",
            \ "<ESC>0": "_show_errors()",
            \ "<Esc>": "_stop_hlight()",
            \ "<C-f>": "_search()",
            \ "<C-r>": "_replace()",
            \ "<Esc>r": "_greplace()",
            \ "<C-g>": "_search_global()",
            \ "<C-b>": "_format()",
            \ "<C-_>": "_comment()",
            \ "<ESC>a": "_repeat()",
            \ "<C-c>": "_copy()",
            \ "<C-v>": "_paste()",
            \ "<C-x>": "_cut()",
            \ "<ESC>l": "_goto_line_start() . _goto_line_end() . _select()",
            \ "<C-d>": "_dup()",
            \ "<C-z>": "_undo()",
            \ "<ESC>z": "_redo()",
            \ "<C-?>": "_delete()",
            \ "<C-j>": "_join()",
            \ "<Tab>": "_complete_word('n')",
            \ "<S-Tab>": "_complete_word('p')",
            \ "<Up>": "_up()",
            \ "<Down>": "_down()",
            \ "<ESC>,": "_goto_last_change()",
            \ "<C-up>": "_goto_line_start()",
            \ "<C-down>": "_goto_line_end()",
            \ "<C-l>": "_goto_line_n()",
            \ "<ESC>f": "_goto_char()",
            \ "<Esc>[1;3C": "_goto_next_found()",
            \ "<ESC>[1;3D": "_goto_prev_found()",
            \ "<ESC>(": "_goto_prev_error()",
            \ "<ESC>9": "_goto_next_error()",
            \ "<C-right>": "_goto_next_word()",
            \ "<C-left>": "_goto_prev_word()",
            \ "<C-S-left>": "_goto_prev_word() . _select()",
            \ "<C-S-right>": "_goto_next_word() . _select()",
            \ "<C-a>": "_select_all()",
            \ "<ESC>s": "_select()",
            \ "<S-left>": "_left() . _select()",
            \ "<S-right>": "_right() . _select()",
            \ "<S-Up>": "_up(). _select()",
            \ "<S-down>": "_down() . _select()",
            \ "<C-S-Up>": "_goto_line_start() . _select()",
            \ "<C-S-down>": "_goto_line_end() . _select()",
            \ "<ESC>w": "_smart_selection()"
            \ }

call _normalize_builtin_bindings()
call map(items(g:hotkeys), {k, v -> _bind(v[0], v[1])})

let g:sb_terminal_colors = v:true

""
"" Colorscheme
""
if g:sb_terminal_colors
    highlight clear
    if exists("syntax on")
        syntax reset
    endif

    set background=light

    " Colors
    let s:black = 0
    let s:light_black = 8
    let s:red = 1
    let s:light_red = 9
    let s:green = 2
    let s:light_green = 10
    let s:yellow = 3
    let s:light_yellow = 11
    let s:blue = 14
    let s:light_blue = 12
    let s:magenta = 5
    let s:light_magenta = 13
    let s:cyan = 6
    let s:light_cyan = 14
    let s:white = 7
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
endif

" Capture all found: `:g/something/`
" Capture all last found: `:g//`
