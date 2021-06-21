" Enable using ctrl+z and ctrl+s without side-effects
silent !stty -ixon

"" darkbg: #073642 #002b36

""
"" Built-in vimscript functions
""
"" Number
"" pow(2, 3) -> 8.0
"" sqrt(9) -> 3.0
"" round(8.5) -> 9.0
"" ceil(8.2) -> 9.0
"" floor(8.6) -> 8.0
"" abs(-23) -> 23
"" fmod(9, 2) -> 1.0
""
"" List
"" add([1,2,3], 4) -> [1,2,3,4]
"" max([1,2,3,7,4]) -> 7
"" min([3,2,1,2,5]) -> 1
"" range(1, 5) -> [1,2,3,4,5]
"" reverse([1,2,3,4]) -> [4,3,2,1]
"" sort([3,1,2]) -> [1,2,3]
"" deepcopy([1,2,3]) -> [1,2,3]
"" empty([]) -> 1
"" extend([1,2], [2,3]) -> [1,2,2,3]
"" filter([1,2,3,4], {k, v -> v != 3}) -> [1,2,4]
"" map([1,2,3,4], {k, v -> v * 2}) -> [2,4,6,8]
"" get([1,2,3], 2) -> 3
"" get([1,2,3], 3) -> 0
"" get([1,2,3], 3, 5) -> 5
"" insert([1,2,3], 5) -> [5,1,2,3]
"" len([1,2,3]) -> 3
"" join([1,2,3]) -> "1 2 3"
"" remove([1,2,3], 1) -> 2
"" index([1,2,3], 3) -> 2
"" index([1,2,3], 5) -> -1
""
"" String
"" printf("a is %s, b is %s", 5, 8) -> "a is 5, b is 8"
"" substitute("string", "s", "d", "") -> "dtring"
"" split("string", "i") -> ["str", "ng"]
"" empty("") -> 1
"" escape("string", "r") -> "st\ring"
"" len("string") -> 6
"" match("string", "tr") -> 0
"" match("string", "d") -> -1
"" tolower("StrIng") -> "string"
"" toupper("String") -> "STRING"
""
"" Dict
"" has_key(x, k) whether `x` dict has `k` key
"" items({'a': 'val1', 'b': 'val2'}) -> [['a', 'val1'], ['b', 'val2']]
"" keys({'a': 'val1', 'b': 'val2'}) -> ['a', 'b']
"" values({'a': 'val1', 'b': 'val2'}) -> ['val1', 'val2']
"" len({'a': 'val1', 'b': 'val2'}) -> 2
"" remove({'a': 'val1', 'b': 'val2'}, 'a') -> 'val1'
""
"" Util
"" repeat(printf("a is %s", 10), 3) -> a is 10a is 10a is 10
"" exists(x) whether `x` available in current script
"" function(f) returns reference to function `f`


""
"" Built-in editor functions
"" search(x) search for `x`
"" searchpos(x) search for `x` and returns found position
"" nextnonblank(n) where `n` is a line number
"" prevnonblank(n) where `n` is a line number
"" pumvisible() whether popup menu is visible
"" setreg(n, x) store `x` in `n` register
"" getreg(n) get value from `n` register
"" mode() returns current editor mode
"" system(x) returns output of `x` shell command
"" undotree()
"" echom "msg"
"" echoe "some error"
"" exe "exp"
""
"" File
"" argv(n) returns `n`th element of arguments passed to vim command
"" rename(x, y) rename file from x to y
"" delete(x) delete file with name `x`
"" bufname() returns current buffer name
"" expand(x) returns string value that links with `x`
"" glob(x) returns globbed path
"" filereadable(x) whether `x` file is readable
"" filewritable(x) whether `x` file is writable
"" readfile(x) returns content of `x` file as list of lines
"" writefile(a, x) insert content list of `a` to `x` file
"" getcwd() returns current working directory path
"" isdirectory(x) whether `x` is directory
"" mkdir(x, y) creates directory `x` in `y` path
"" did_filetype() whether autocmd FileType event used
"" saveas filename save with file name filename
""
"" User interaction
"" confirm
"" input
"" getchar
"" inputlist
"" inputsecret
""
"" Insert to buffer
"" setline(n, x) insert `x` to `n` line
"" append(n, x) insert `x` after n line, `x` can be list
"" feedkeys(x) type `x` to current buffer
"" matchadd("Search", x) highlights found x with "Search" color
""
"" Read buffer
"" getbufline(x, fromLineN, toLineN) returns list of lines of buffer `x`
"" getline(n) returns content of `n` line
"" getline(n1, n2) returns list of content from `n1` line to `n2` line
""
"" Manipulate positions
"" col(x) returns column number of `x` mark
"" line(x) returns line number of `x` mark
"" cursor(xs) set cursor to `xs` pos
"" getpos(x) returns position details of `x` mark
"" searchpos(x) returns position of `x` content
"" searchpairpos() ???

"" Key commands
"" d delete
"" y copy
"" p,P paste
"" u undo
"" o new line (in visual mode - switch selection direction)


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
    return _do(":\<C-u>call fzf#vim#files(
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

fun! _search()
    return _do("/")
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
    return _do("i\<Bs>", _select() . 'd')
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

    "let l:add_history = a:v == '_repeat()' ? '' : ". _do(\":let @r=" . a:v . "'<cr>')"

    exe 'vnoremap <silent> <expr> ' . a:k . ' ' . a:v
    exe 'inoremap <silent> <expr> ' . a:k . ' ' . a:v
endfun

fun! _normalize_builtin_bindings()

    " Remove all bindings
    let l:keyboard_keys = ['<space>', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '_', '-', '=', '`', '/', '?', ')', '(', '[', ']', '{', '}', '"', '"']
    let l:keyboard_modif = ['C', 'M', 'S', 'M-S']

    for l:keyboard_key in l:keyboard_keys
        exe 'noremap ' . l:keyboard_key . " <Nop>"
    endfor
    for l:keyboard_modif in l:keyboard_modif
        for l:keyboard_key in l:keyboard_keys
            if (l:keyboard_modif == 'C' && index(['M', '['], l:keyboard_key) > -1)
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
    \ "<M-`>": "_command_prompt()",
    \ "<C-q>": "_quit()",
    \ "<C-s>": "_save_file()",
    \ "<C-w>": "_close_file()",
    \ "<C-r>": "_switch_files()",
    \ "<C-h>": "_recent_files()",
    \ "<C-e>": "_open_file()",
    \ "<M-3>": "_show_errors()",
    \ "<C-f>": "_search()",
    \ "<C-g>": "_search_global()",
    \ "<C-b>": "_format()",
    \ "<C-_>": "_comment()",
    \ "<M-a>": "_repeat()",
    \ "<C-c>": "_copy()",
    \ "<C-v>": "_paste()",
    \ "<C-x>": "_cut()",
    \ "<M-l>": "_goto_line_start() . _goto_line_end() . _select()",
    \ "<C-d>": "_dup()",
    \ "<C-z>": "_undo()",
    \ "<M-z>": "_redo()",
    \ "<Bs>": "_delete()",
    \ "<C-j>": "_join()",
    \ "<Tab>": "_complete_word('n')",
    \ "<S-Tab>": "_complete_word('p')",
    \ "<Up>": "_up()",
    \ "<Down>": "_down()",
    \ "<M-0>": "_goto_last_change()",
    \ "<C-up>": "_goto_line_start()",
    \ "<C-down>": "_goto_line_end()",
    \ "<C-l>": "_goto_line_n()",
    \ "<M-f>": "_goto_char()",
    \ "<M-right>": "_goto_next_found()",
    \ "<M-left>": "_goto_prev_found()",
    \ "<M-1>": "_goto_prev_error()",
    \ "<M-2>": "_goto_next_error()",
    \ "<C-right>": "_goto_next_word()",
    \ "<C-left>": "_goto_prev_word()",
    \ "<C-S-left>": "_goto_prev_word() . _select()",
    \ "<C-S-right>": "_goto_next_word() . _select()",
    \ "<C-a>": "_select_all()",
    \ "<M-s>": "_select()",
    \ "<S-left>": "_left() . _select()",
    \ "<S-right>": "_right() . _select()",
    \ "<S-up>": "_up(). _select()",
    \ "<S-down>": "_down() . _select()",
    \ "<C-S-up>": "_goto_line_start() . _select()",
    \ "<C-S-down>": "_goto_line_end() . _select()",
    \ "<M-w>": "_smart_selection()"
    \ }

call _normalize_builtin_bindings()
call map(items(g:hotkeys), {k, v -> _bind(v[0], v[1])})


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
set shortmess+=c
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
set updatetime=100


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
" In-text search
set incsearch nohlsearch ignorecase smartcase wrapscan
" Highlight search only while in-search
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
" Match pairs
set showmatch matchpairs+=<:>
" Remove trailing whitespaces after saving a buffer
autocmd BufWritePre * let b:pos = [line('.'), col('.')]
    \ | %s/\s\+$//e
    \ | :call cursor(b:pos[0], b:pos[1])

""
"" Editor UI
""
set guicursor=a:block-blinkon0 number signcolumn=yes:1
set showcmd cmdheight=1 noshowmode noruler laststatus=2 nomodeline
set statusline=%#Error#%{coc#status()}%#StatusLineNC#%r\ %.60F\ %y\ %{&fenc}%=Col:\ %c\ \|\ Line:\ %l/%L
set t_Co=16
silent! colorscheme sb
" Command line completion by <Tab>
set wildmenu wildmode=longest:full,full

""
"" Define runtime values
""
let g:pkgs_dir = stdpath('data') . '/plugged'

""
"" Package manager
""
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
    " Auto install package manager if is not installed
    !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Packages list
call plug#begin(g:pkgs_dir)
" Toggle comments
Plug 'tpope/vim-commentary'
" Search everything interface
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Language server protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Language syntax
Plug 'sheerun/vim-polyglot'
" Show on the left panel code line status (added | modified | removed)
Plug 'mhinz/vim-signify'
call plug#end()

" Auto install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

""
"" Plugin settings
""

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
    \ "diagnostic.refreshAfterSave": v:true,
    \ "diagnostic.checkCurrentLine": v:true,
    \ "diagnostic.messageTarget": "echo",
    \ "diagnostic.messageDelay": "500",
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
    \ "emmet.includeLanguages": ["html", "javascript", "javascriptreact", "php", "css", "svelte"],
    \ "emmet.excludeLanguages": [],
    \ "codeLens.enable": v:false
\ }
hi! link CocErrorHighlight Error
hi! link CocWarningHighlight WarningMsg
hi! link CocUnderline Underlined

" FZF settings
let g:fzf_layout = {'window': 'enew'}
autocmd  FileType fzf set laststatus=0
    \| autocmd BufLeave <buffer> set laststatus=2

" Show file search after start on directory
autocmd VimEnter * nested
    \ if argc() == 1 && isdirectory(argv()[0])
    \ | sleep 100m
    \ | exe "call fzf#vim#files(
    \   (argv()[0] == getcwd()) ? getcwd() : getcwd() . '/' . argv()[0]
    \ )"
    \ | endif


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
"" TODO:
""
" - switch to VIM
" - switch to another LSP package (but preserve fuzzy-find completion)
" - repeat last command
" - replace (interactive)
" - global replace (interactive)
" - highlight occurences
" - select pasted content
" - keep cursor position after call hotkeys
" - transpose char/line/word
" - support snippets
" - fix indent/outdent behaviour
" - file/dir manipulation from editor
