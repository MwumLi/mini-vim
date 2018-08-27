" vim: set filetype=vim expandtab ts=2 sts=2 sw=2 :
scriptencoding utf-8

" Varible {
  " 定义键映射前缀: 统一按键前缀, 避免键冲突
  " 全局键映射前缀 <Leader>, 默认为 '\', 这里设置为 <Space>
  let g:mapleader = "\<Space>"
  " 文件类型插件的键映射前缀 <LocalLeader>
  let g:maplocalleader = ","

	" 是否启用鼠标(鼠标滚动, 点击位置): 1 为启用 0 为禁用
	let g:enableMouse = 1

  " 当超出显示区域, 超出区域是否下一行显示, 1 为不折行, 0 为折行
  " let g:noWrapLine = 1

  " 一个 TAB 占几个空格
  let g:tabspace = 2
  " 将输入的 Tab 自动展开成空格, 0 为展开, 1 为不展开
  " let g:noExpandtab = 0
  " 仅有在 noExpandtabList 里的文件类型不进行输入的 Tab 自动转化为相应数量空格
  let g:noExpandtabList = ['markdown']

  " 启用回退: 1 为 启用, 0 为禁用
  " 可视 Mode 下: u 为撤销, ctrl+r 为恢复
  let g:enableUndo = 1
"}

" 是否为 GUi VIM
let g:gui_running = has('gui_running')

set nocompatible          " 关掉兼容模式: 避免 vi 下的一些功能操作
set modeline              " 启用 modeline

" 避免续行效应
let s:save_cpo = &cpo
set cpo&vim

" config {

  " http://edyfox.codecarver.org/html/vim_fileencodings_detection.html
  " encoding {
    set encoding=utf-8      " Set default encoding
    set termencoding=utf-8  " 输出到终端采用的编码类型
    " 按顺序使用一下编码尝试解码
    " 如果解码成功, fileencoding 被设置为相应编码
    " 如果解码失败, 则继续下一个编码尝试解码
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
  " }

  " color {
    set t_Co=256            " 开启 256 色
    " http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging/15095377#15095377
    set t_ut=               " 修复 tmux 下背景色渲染正确的问题
  " }

  " line number {
    set number              " 行号
    set relativenumber      " Relative numbers on
  " }

  " cursor {
  " set cursorline          " 行光标线
  " set cursorcolumn        " 列光标线
  "}

	" Change cursor shape for iTerm2 on macOS {
		" inside iTerm2
		if $TERM_PROGRAM =~# 'iTerm'
			let &t_SI = "\<Esc>]50;CursorShape=1\x7"
			if exists('&t_SR')
				let &t_SR = "\<Esc>]50;CursorShape=2\x7"
			endif
			let &t_EI = "\<Esc>]50;CursorShape=0\x7"
		endif

		" inside tmux
		if exists('$TMUX')
			let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
			if exists('&t_SR')
				let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
			endif
			let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
		endif
	" }

  " 括号匹配 {
    set showmatch                   " 当输入右括号, 闪烁匹配的左括号
    set matchtime=2                 " Show matching time, 单位为 1/10s, 默认 500ms
  " }

  " 断行设置 {
    set textwidth=80          " 一行显示 80 字符
    if exists('g:noWrapLine') && g:noWrapLine
      set nowrap
      set sidescroll=6        " 当光标达到水平极端时 移动的列数
    else
      set wrap                " 设置自动折行, 超过 textwidth, 则折行
    endif
    set linebreak             " 不在单词中间断行
    set fo+=mB                " 断行对汉字的支持
    set whichwrap+=<,>,h,l    " 允许Normal 或 Visual 模式下左右移动跨越行边界
  " }

  " list {
    set listchars=tab:▸\ ,trail:·,precedes:«,extends:»,eol:↵ 
    set list
  "}

  " fold {
    set foldmethod=indent      " 折叠方式
    set nofoldenable           " 不自动折叠
    set foldcolumn=1           " 在行号前空出一列的宽度
  " }

  " bottom status bar {
		set report=0							" Always report changed lines, such as 1 line yanked, 2 fewer lines
    set laststatus=2        	" 总是显示状态栏
    set display=lastline    	" Show as much as possible of the last line
    set showmode            	" 左下角显示 vim Mode, 没有显示为常规模式
    set ruler               	" 右下角显示光标的行列信息
    set showcmd             	" 右下角显示 vim 输入指令
		set wildmenu    					" 开启 Vim 自身命令行模式智能补全
		set wildmode=list:longest,full " http://vimcdoc.sourceforge.net/doc/options.html#'wildmode'
		" <EOL> {
			set fileformats=unix,dos,mac    " 给出换行符的格式, 具体: help fileformats
		" }
  "}

  " syntax {
    syntax on                      " Syntax highlighting
    filetype plugin indent on      " Automatically detect file types
  " }

  " indent {
    filetype indent on              " 自适应不同语言的智能缩进
    set autoindent
    set smartindent                 " 智能对齐
    " set cindent
  " }

  " TAB {
  	let &tabstop=g:tabspace         " 一个 <Tab> 占据的空格数
    let &shiftwidth=g:tabspace      " cindent, autoindent、<< 和 >> 缩进的空格数
  	let &softtabstop=g:tabspace     " Tab 将补齐 n 个空格, <Backspace> 删除 n 个空格
    set smarttab
  	" 将输入的 Tab 自动展开成空格
    if !exists('g:noExpandtab') || !g:noExpandtab
      if !exists('g:noExpandtabList')
        let g:noExpandtabList = []
      endif
      autocmd InsertEnter * if index(g:noExpandtabList, &ft) < 0 | set expandtab | endif
    endif
  "}

  " 设置 backspace 的行为
  " indent : 允许删除自动插入的缩进
  " eol: 允许删除到上一行
  " start: 允许删除到行首
  set backspace=indent,eol,start

  " search {
    set hlsearch                    " Highlight search results
    set incsearch                   " 开启实时搜索
    set ignorecase                  " 搜索时大小写不敏感
    set smartcase                   " 如果搜索字符串里包含大写字母,则精确匹配
  "}

	" mouse {
		if exists('g:enableMouse') && g:enableMouse
			set mouse=a           " Automatically enable mouse usage
			set mousehide         " Hide the mouse cursor while typing
			set ttymouse=xterm2
			set scrolljump=1      " 当光标达到上端或下端时 翻滚的行数
			set so=6              " 上下滚行时空余6行
		endif
	" }

  " use system copyboard {
    if has('unnamedplus')
      set clipboard=unnamedplus,unnamed
    else
      set clipboard+=unnamed
    endif
  " }

	" http://vimcdoc.sourceforge.net/doc/undo.html
	" undo - 无限回退 {
		if exists('g:enableUndo') && g:enableUndo
			if has('persistent_undo')
				set undodir=~/.vim/undodir  " 指定撤销文件路径(默认撤销文件通常保存在文件本身相同的目录里)
				set undofile                " Persistent undo
				set undolevels=1000         " Maximum number of changes that can be undone
				set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
			endif
		endif
	" }


  " 性能 {
    set lazyredraw                  " 解决某些类型的文件由于syntax导致vim反应过慢的问题
    set ttyfast                     " Faster redrawing, 有助于 xterm 和其他终端上使用鼠标来进行复制/粘贴
  " }


  " other {
    set linespace=0                 " No extra spaces between rows
		set shortmess=atOI              " 启动时不显示捐助乌干达儿童的提示
		set autoread                    " Automatically read a file changed outside of vim
		set autowrite                   " Automatically write a file when leaving a modified buffer
		set complete-=i                 " Exclude files completion
		set history=10000               " Maximum history record
		set viminfo+=!                  " Viminfo include !
  "}

	if g:gui_running
		set guioptions-=r        " Hide the right scrollbar
		set guioptions-=L        " Hide the left scrollbar
		set guioptions-=T
		set guioptions-=e
		set shortmess+=c
		" No annoying sound on errors
		set noerrorbells
		set novisualbell
		set visualbell t_vb=
	endif

" } end config

if has('autocmd')
augroup MINI_VIM_BASIC
  autocmd!

  " Restore cursor position when opening file
  autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif

	" 当退出最后一个可可编辑文件时, 退出 vim
  autocmd BufEnter * call MyLastWindow()
  function! MyLastWindow()
      " if the window is quickfix/locationlist go on
      if &buftype ==# 'quickfix' || &buftype ==# 'locationlist'
          " if this window is last on screen quit without warning
          if winbufnr(2) == -1
              quit!
          endif
      endif
  endfunction

	" 当大于 10000000 时, 关闭语法增强
  autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   endif

augroup END
endif

function! s:statusline_hi()
    " default bg for statusline is 236 in space-vim-dark
    hi paste       cterm=bold ctermfg=149 ctermbg=239 gui=bold guifg=#99CC66 guibg=#3a3a3a
    hi ale_error   cterm=None ctermfg=197 ctermbg=237 gui=None guifg=#CC0033 guibg=#3a3a3a
    hi ale_warning cterm=None ctermfg=214 ctermbg=237 gui=None guifg=#FFFF66 guibg=#3a3a3a

    hi User1 cterm=bold ctermfg=232 ctermbg=179 gui=Bold guifg=#333300 guibg=#FFBF48
    hi User2 cterm=None ctermfg=214 ctermbg=243 gui=None guifg=#FFBB7D guibg=#666666
    hi User3 cterm=None ctermfg=251 ctermbg=241 gui=None guifg=#c6c6c6 guibg=#585858
    hi User4 cterm=Bold ctermfg=177 ctermbg=239 gui=Bold guifg=#d75fd7 guibg=#4e4e4e
    hi User5 cterm=None ctermfg=208 ctermbg=238 gui=None guifg=#ff8700 guibg=#3a3a3a
    hi User6 cterm=Bold ctermfg=178 ctermbg=237 gui=Bold guifg=#FFE920 guibg=#444444
    hi User7 cterm=None ctermfg=250 ctermbg=238 gui=None guifg=#bcbcbc guibg=#444444
    hi User8 cterm=None ctermfg=249 ctermbg=239 gui=None guifg=#b2b2b2 guibg=#4e4e4e
    hi User9 cterm=None ctermfg=249 ctermbg=241 gui=None guifg=#b2b2b2 guibg=#606060
endfunction

call s:statusline_hi()
" Refer to http://vim.wikia.com/wiki/Show_tab_number_in_your_tab_line
if g:gui_running
    set guioptions-=e
endif

silent function! s:source(file) abort
    if filereadable(expand(a:file))
        execute 'source ' . fnameescape(a:file)
        return 1
    endif
    return 0
endfunction

silent function! ToggleLineNumber()
  if &number
    set nonumber            " 关闭号
    set norelativenumber    " 关闭相对行号
    echo "Hide Line Number"
  else
    set number              " 行号
    set relativenumber      " Relative numbers on
    echo "Show Line Number"
  endif
endfunction

silent function! TogglePasteMode()
  setlocal paste!
  if &paste
    echo "Enable Paste Mode"
  else
    echo "Disable Paste Mode"
  endif
endfunction

" keymap {
	" Visual shifting (does not exit Visual mode) {
		vnoremap < <gv
		vnoremap > >gv
	" }

	" Treat long lines as break lines (useful when moving around in them) {
    nmap j gj
    nmap k gk
    vmap j gj
    vmap k gk
	" }

	" :W sudo saves the file
	" (useful for handling the permission-denied error) {
		command! W w !sudo tee % > /dev/null
	" }

	" file save
	nnoremap <Leader>fs :update<CR>

	" Quit normal mode {
		nnoremap <Leader>q  :q<CR>
		nnoremap <Leader>Q  :qa!<CR>
	" }

	" Move half page faster {
		" <C-d> : 向下移动半页
		" <C-u> : 向上移动半页
	" }

	" Insert mode shortcut {
		inoremap <C-h> <Left>
		inoremap <C-j> <Down>
		inoremap <C-k> <Up>
		inoremap <C-l> <Right>
	" }

	" like bash {
		inoremap <C-a> <Home>
		inoremap <C-e> <End>
		inoremap <C-d> <Delete>
	" }


	" Quit visual mode {
    vnoremap v <Esc>
  " }

	" move {
		" jump to the start of line
		nnoremap 1 0
		" jump to the end of line
		nnoremap 0 $
		" jump to the start of line text
		nnoremap H ^
		" jump loop in Pairing characters , such '( ... )', '{  }'
		nnoremap 5 %
		" <C-w>H -- 跳转至左方的窗口
		" <C-w>l -- 跳转至右方的窗口
		" <C-w>k -- 跳转至上方的窗口
		" <C-w>j -- 跳转至下方的窗口
	" }

	" Quick command mode
	nnoremap ; :

	" Open shell in vim
	" :shell

	" Search result highlight countermand
	nnoremap <Leader>sc :nohlsearch<CR>

	" Toggle pastemode
	nnoremap <Leader>tp :call TogglePasteMode()<CR>

  " Toggle Line Number
  nnoremap <Leader>ln :call ToggleLineNumber()<CR>

	" window-split {
			" :sp 或 :new -- 上下分割窗口
			" :vsp 或 :vnew -- 左右分割窗口
	" }

	" buffer {
		nnoremap <Leader>bp :bprevious<CR>
		nnoremap <Leader>bn :bnext<CR>
		nnoremap <Leader>bf :bfirst<CR>
		nnoremap <Leader>bl :blast<CR>
		nnoremap <Leader>bd :bd<CR>
		nnoremap <Leader>bk :bw<CR>
	" }

	" Command mode shortcut {
		cnoremap <C-h> <left>
		cnoremap <C-j> <Down>
		cnoremap <C-k> <Up>
		cnoremap <C-l> <Right>
		cnoremap <C-a> <Home>
		cnoremap <C-e> <End>
		cnoremap <C-d> <Delete>
	" }

  " 函数 {
    " 命令列出所有用户自定义的函数及其参数
    " :function
    " 查看函数的定义
    " :function ToggleLineNumber
  " "}
" }

let &cpo = s:save_cpo
unlet s:save_cpo
