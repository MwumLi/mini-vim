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
    set cursorline          " 行光标线
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

if !exists('g:colors_name')
" space-vim-dark {
  " Vim color file
  "
  " Author: Liu-Cheng Xu
  " URL: https://github.com/liuchengxu/space-vim-dark
  "
  " Note: Inspired by spacemacs-dark theme

  hi clear

  if v:version > 580
      " no guarantees for version 5.8 and below, but this makes it stop
      " complaining
      hi clear
      if exists('g:syntax_on')
          syntax reset
      endif
  endif

  let g:colors_name='space-vim-dark'

  " refer to http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
  let s:color256 = {
        \ 0 : '#000000',  1 : '#800000',  2 : '#008000',  3 : '#808000',  4 : '#000080',  5 : '#800080',  6 : '#008080' , 7 : '#c0c0c0',
        \ 8 : '#808080',  9 : '#ff0000', 10 : '#00ff00', 11 : '#ffff00', 12 : '#0000ff', 13 : '#ff00ff', 14 : '#00ffff', 15 : '#ffffff',
        \ 16 : '#000000',  17 : '#00005f',  18 : '#000087',  19 : '#0000af',  20 : '#0000d7',  21 : '#0000ff',
        \ 22 : '#005f00',  23 : '#005f5f',  24 : '#005f87',  25 : '#005faf',  26 : '#005fd7',  27 : '#005fff',
        \ 28 : '#008700',  29 : '#00875f',  30 : '#008787',  31 : '#0087af',  32 : '#0087d7',  33 : '#0087ff',
        \ 34 : '#00af00',  35 : '#00af5f',  36 : '#00af87',  37 : '#00afaf',  38 : '#00afd7',  39 : '#00afff',
        \ 40 : '#00d700',  41 : '#00d75f',  42 : '#00d787',  43 : '#00d7af',  44 : '#00d7d7',  45 : '#00d7ff',
        \ 46 : '#00ff00',  47 : '#00ff5f',  48 : '#00ff87',  49 : '#00ffaf',  50 : '#00ffd7',  51 : '#00ffff',
        \ 52 : '#5f0000',  53 : '#5f005f',  54 : '#5f0087',  55 : '#5f00af',  56 : '#5f00d7',  57 : '#5f00ff',
        \ 58 : '#5f5f00',  59 : '#5f5f5f',  60 : '#5f5f87',  61 : '#5f5faf',  62 : '#5f5fd7',  63 : '#5f5fff',
        \ 64 : '#5f8700',  65 : '#5f875f',  66 : '#5f8787',  67 : '#5f87af',  68 : '#5f87d7',  69 : '#5f87ff',
        \ 70 : '#5faf00',  71 : '#5faf5f',  72 : '#5faf87',  73 : '#5fafaf',  74 : '#5fafd7',  75 : '#5fafff',
        \ 76 : '#5fd700',  77 : '#5fd75f',  78 : '#5fd787',  79 : '#5fd7af',  80 : '#5fd7d7',  81 : '#5fd7ff',
        \ 82 : '#5fff00',  83 : '#5fff5f',  84 : '#5fff87',  85 : '#5fffaf',  86 : '#5fffd7',  87 : '#5fffff',
        \ 88 : '#870000',  89 : '#87005f',  90 : '#870087',  91 : '#8700af',  92 : '#8700d7',  93 : '#8700ff',
        \ 94 : '#875f00',  95 : '#875f5f',  96 : '#875f87',  97 : '#875faf',  98 : '#875fd7',  99 : '#875fff',
        \ 100 : '#878700', 101 : '#87875f', 102 : '#878787', 103 : '#8787af', 104 : '#8787d7', 105 : '#8787ff',
        \ 106 : '#87af00', 107 : '#87af5f', 108 : '#87af87', 109 : '#87afaf', 110 : '#87afd7', 111 : '#87afff',
        \ 112 : '#87d700', 113 : '#87d75f', 114 : '#87d787', 115 : '#87d7af', 116 : '#87d7d7', 117 : '#87d7ff',
        \ 118 : '#87ff00', 119 : '#87ff5f', 120 : '#87ff87', 121 : '#87ffaf', 122 : '#87ffd7', 123 : '#87ffff',
        \ 124 : '#af0000', 125 : '#af005f', 126 : '#af0087', 127 : '#af00af', 128 : '#af00d7', 129 : '#af00ff',
        \ 130 : '#af5f00', 131 : '#af5f5f', 132 : '#af5f87', 133 : '#af5faf', 134 : '#af5fd7', 135 : '#af5fff',
        \ 136 : '#af8700', 137 : '#af875f', 138 : '#af8787', 139 : '#af87af', 140 : '#af87d7', 141 : '#af87ff',
        \ 142 : '#afaf00', 143 : '#afaf5f', 144 : '#afaf87', 145 : '#afafaf', 146 : '#afafd7', 147 : '#afafff',
        \ 148 : '#afd700', 149 : '#afd75f', 150 : '#afd787', 151 : '#afd7af', 152 : '#afd7d7', 153 : '#afd7ff',
        \ 154 : '#afff00', 155 : '#afff5f', 156 : '#afff87', 157 : '#afffaf', 158 : '#afffd7', 159 : '#afffff',
        \ 160 : '#d70000', 161 : '#d7005f', 162 : '#d70087', 163 : '#d700af', 164 : '#d700d7', 165 : '#d700ff',
        \ 166 : '#d75f00', 167 : '#d75f5f', 168 : '#d75f87', 169 : '#d75faf', 170 : '#d75fd7', 171 : '#d75fff',
        \ 172 : '#d78700', 173 : '#d7875f', 174 : '#d78787', 175 : '#d787af', 176 : '#d787d7', 177 : '#d787ff',
        \ 178 : '#d7af00', 179 : '#d7af5f', 180 : '#d7af87', 181 : '#d7afaf', 182 : '#d7afd7', 183 : '#d7afff',
        \ 184 : '#d7d700', 185 : '#d7d75f', 186 : '#d7d787', 187 : '#d7d7af', 188 : '#d7d7d7', 189 : '#d7d7ff',
        \ 190 : '#d7ff00', 191 : '#d7ff5f', 192 : '#d7ff87', 193 : '#d7ffaf', 194 : '#d7ffd7', 195 : '#d7ffff',
        \ 196 : '#ff0000', 197 : '#ff005f', 198 : '#ff0087', 199 : '#ff00af', 200 : '#ff00d7', 201 : '#ff00ff',
        \ 202 : '#ff5f00', 203 : '#ff5f5f', 204 : '#ff5f87', 205 : '#ff5faf', 206 : '#ff5fd7', 207 : '#ff5fff',
        \ 208 : '#ff8700', 209 : '#ff875f', 210 : '#ff8787', 211 : '#ff87af', 212 : '#ff87d7', 213 : '#ff87ff',
        \ 214 : '#ffaf00', 215 : '#ffaf5f', 216 : '#ffaf87', 217 : '#ffafaf', 218 : '#ffafd7', 219 : '#ffafff',
        \ 220 : '#ffd700', 221 : '#ffd75f', 222 : '#ffd787', 223 : '#ffd7af', 224 : '#ffd7d7', 225 : '#ffd7ff',
        \ 226 : '#ffff00', 227 : '#ffff5f', 228 : '#ffff87', 229 : '#ffffaf', 230 : '#ffffd7', 231 : '#ffffff',
        \
        \ 232 : '#080808', 233 : '#121212', 234 : '#1c1c1c', 235 : '#262626', 236 : '#303030', 237 : '#3a3a3a',
        \ 238 : '#444444', 239 : '#4e4e4e', 240 : '#585858', 241 : '#606060', 242 : '#666666', 243 : '#767676',
        \ 244 : '#808080', 245 : '#8a8a8a', 246 : '#949494', 247 : '#9e9e9e', 248 : '#a8a8a8', 249 : '#b2b2b2',
        \ 250 : '#bcbcbc', 251 : '#c6c6c6', 252 : '#d0d0d0', 253 : '#dadada', 254 : '#e4e4e4', 255 : '#eeeeee',
        \ }

  " ========|===========
  " Red     | 160 168
  " Blue    | 67  68  111
  " Yellow  | 114 179
  " Orange  | 173 178
  " Purple  | 140
  " Magenta | 128
  " ========|===========

  let s:colors = {
        \ 16: '#292b2e', 24: '#3C8380', 28: '#c269fe', 30: '#2aa1ae', 36: '#20af81', 40: '#00ff00',
        \ 59: '#FF73B9', 68: '#4f97d7', 75: '#FF62B0', 76: '#86dc2f', 81: '#f9bb00', 88: '#330033',
        \ 104: '#df90ff', 114: '#67b11d', 128: '#e76a49', 135: '#B7B7FF', 136: '#dc752f', 139: '#d698fe',
        \ 140: '#b888e2', 141: '#9a9aba', 151: '#74BAAC', 160: '#e0211d', 161: '#E469FE', 167: '#ce537a',
        \ 168: '#ce537a', 169: '#bc6ec5', 171: '#6094DB', 173: '#e18254', 176: '#E697E6', 177: '#D881ED',
        \ 178: '#d1951d', 179: '#d4b261', 196: '#e0211d', 204: '#ce537a', 207: '#FF68DD', 214: '#FF4848',
        \ 218: '#d19a66', 225: '#FFC8C8', 229: '#fff06a', 233: '#303030', 234: '#212026', 235: '#292b2e',
        \ 236: '#34323e', 238: '#544a65', 241: '#534b5d', 243: '#65737e', 244: '#b4d1b6',
        \ }

  function! s:hi(item, fg, bg, cterm, gui)
    let l:fg = empty(a:fg) ? '' : printf('ctermfg=%d guifg=%s', a:fg, get(s:colors, a:fg, s:color256[a:fg]))
    let l:bg = empty(a:bg) ? '' : printf('ctermbg=%d guibg=%s', a:bg, get(s:colors, a:bg, s:color256[a:bg]))
    let l:style = printf('cterm=%s gui=%s', a:cterm, a:gui)
    execute 'hi '.a:item.' '.l:fg.' '.l:bg.' '.l:style
  endfunction

  let s:fg = 249
  let s:bg = get(g:, 'space_vim_dark_background', 235)

  let s:bias = s:bg - 235
  let s:bg0 = s:bg - 1
  let s:bg1 = s:bg + 1
  let s:bg2 = s:bg + 2
  let s:bg3 = s:bg + 3
  let s:bg4 = s:bg + 4

  " call s:hi(item, fg, bg, cterm, gui)

  call s:hi('Normal' , 249 , s:bg , 'None' , 'None')
  call s:hi('Cursor' , 235 , 178  , 'bold' , 'bold')

  call s:hi('LineNr' , 238+s:bias , s:bg0 , 'None' , 'None')

  call s:hi('CursorLine'   , ''  , s:bg0 , 'None' , 'None')
  call s:hi('CursorLineNr' , 134 , s:bg0 , 'None' , 'None')
  call s:hi('CursorColumn' , ''  , s:bg0 , 'None' , 'None')
  call s:hi('ColorColumn'  , ''  , s:bg0 , 'None' , 'None')

  " bug. opposite here.
  call s:hi('StatusLine'   , 140 , s:bg2 , 'None' , 'None')
  call s:hi('StatusLineNC' , 242 , s:bg1 , 'None' , 'None')

  call s:hi('StatusLineTerm'   , 140 , s:bg2 , 'bold' , 'bold')
  call s:hi('StatusLineTermNC' , 244 , s:bg1 , 'bold' , 'bold')

  call s:hi('TabLine'     , 66  , s:bg3 , 'None' , 'None')
  call s:hi('TabLineSel'  , 178 , s:bg4 , 'None' , 'None')
  call s:hi('TabLineFill' , 145 , s:bg2 , 'None' , 'None')

  call s:hi('WildMenu'    , 214 , s:bg3 , 'None' , 'None')

  call s:hi('Boolean'     , 178 , '' , 'None' , 'None')
  call s:hi('Character'   , 75  , '' , 'None' , 'None')
  call s:hi('Number'      , 176 , '' , 'None' , 'None')
  call s:hi('Float'       , 135 , '' , 'None' , 'None')
  call s:hi('String'      , 36  , '' , 'None' , 'None')
  call s:hi('Conditional' , 68  , '' , 'bold' , 'bold')
  call s:hi('Constant'    , 218 , '' , 'None' , 'None')
  call s:hi('Debug'       , 225 , '' , 'None' , 'None')
  call s:hi('Define'      , 177 , '' , 'None' , 'None')
  call s:hi('Delimiter'   , 151 , '' , 'None' , 'None')

  call s:hi('DiffAdd'    , ''  , 24  , 'None' , 'None')
  call s:hi('DiffChange' , 181 , 239 , 'None' , 'None')
  call s:hi('DiffDelete' , 162 , 53  , 'None' , 'None')
  call s:hi('DiffText'   , ''  , 102 , 'None' , 'None')

  call s:hi('Exception'  , 204 , ''  , 'bold' , 'bold')
  call s:hi('Function'   , 169 , ''  , 'bold' , 'bold')
  call s:hi('Identifier' , 167 , ''  , 'None' , 'None')
  call s:hi('Ignore'     , 244 , ''  , 'None' , 'None')
  call s:hi('Operator'   , 111 , ''  , 'None' , 'None')
  call s:hi('FoldColumn' , 67  , s:bg1 , 'None' , 'None')
  call s:hi('Folded'     , 133 , s:bg1 , 'bold' , 'bold')

  call s:hi('PreCondit' , 139 , '' , 'None' , 'None')
  call s:hi('PreProc'   , 176 , '' , 'None' , 'None')
  call s:hi('Question'  , 81  , '' , 'None' , 'None')

  call s:hi('Directory' , 67 , '' , 'bold' , 'bold')
  call s:hi('Repeat'    , 68 , '' , 'bold' , 'bold')
  call s:hi('Keyword'   , 68 , '' , 'bold' , 'bold')
  call s:hi('Statement' , 68 , '' , 'None' , 'None')
  call s:hi('Structure' , 68 , '' , 'bold' , 'bold')

  call s:hi('Label'   , 104 , '' , 'None' , 'None')
  call s:hi('Macro'   , 140 , '' , 'None' , 'None')

  call s:hi('Type'       , 68 , '' , 'None'      , 'None')
  call s:hi('Typedef'    , 68 , '' , 'None'      , 'None')
  call s:hi('Underlined' , ''  , '' , 'underline' , 'underline')

  call s:hi('Search'    , 16 , 76    , 'bold' , 'bold')
  call s:hi('IncSearch' , 16 , 167   , 'bold' , 'bold')
  call s:hi('MatchParen', 40 , s:bg0 , 'bold,underline', 'bold,underline')

  call s:hi('ModeMsg'  , 229 , '' , 'None' , 'None')

  " Popup menu
  call s:hi('Pmenu'      , 141 , s:bg1 , 'None' , 'None')
  call s:hi('PmenuSel'   , 251 , 97    , 'None' , 'None')
  call s:hi('PmenuSbar'  , 28  , 233   , 'None' , 'None')
  call s:hi('PmenuThumb' , 160 , 97    , 'None' , 'None')

  " SignColumn may relate to ale sign
  call s:hi('SignColumn' , 118 , s:bg , 'None' , 'None')
  call s:hi('Todo'       , 172 , s:bg , 'bold' , 'bold')

  " VertSplit consistent with normal background to hide it
  call s:hi('VertSplit' , s:bg0 , '' , 'None' , 'None')

  call s:hi('Warning'    , 136 , '' , 'bold' , 'bold')
  call s:hi('WarningMsg' , 136 , '' , 'bold' , 'bold')

  call s:hi('Error'    , 160 , s:bg , 'bold' , 'bold')
  call s:hi('ErrorMsg' , 196 , s:bg , 'bold' , 'bold')

  call s:hi('Special'        , 169 , '' , 'None' , 'None')
  call s:hi('SpecialKey'     , 59  , '' , 'None' , 'None')
  call s:hi('SpecialChar'    , 171 , '' , 'bold' , 'bold')
  call s:hi('SpecialComment' , 243  , '' , 'None' , 'None')

  call s:hi('SpellBad'   , 168 , '' , 'underline' , 'undercurl')
  call s:hi('SpellCap'   , 110 , '' , 'underline' , 'undercurl')
  call s:hi('SpellLocal' , 253 , '' , 'underline' , 'undercurl')
  call s:hi('SpellRare'  , 218 , '' , 'underline' , 'undercurl')

  call s:hi('Tag'          , 161 , ''  , 'None' , 'None')
  call s:hi('Title'        , 176 , ''  , 'None' , 'None')
  call s:hi('StorageClass' , 178 , ''  , 'bold' , 'bold')

  call s:hi('Comment'   , 30 , ''    , 'None' , 'italic')
  call s:hi('Visual'    , '' , s:bg3 , 'None' , 'None')
  call s:hi('VisualNOS' , '' , s:bg3 , 'None' , 'None')

  " tilde group
  call s:hi('NonText' , 241 , '' , 'None' , 'None')

  call s:hi('Terminal' , 249 , s:bg , 'None' , 'None')

  call s:hi('diffAdded'   , 36  , '' , 'None' , 'None')
  call s:hi('diffRemoved' , 167 , '' , 'None' , 'None')

  hi MatchParen   guibg=NONE
  hi SignColumn   guibg=NONE

  hi link qfLineNr Type

  """""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Language
  """""""""""""""""""""""""""""""""""""""""""""""""""""""
  " markdown
  call s:hi('markdownH1' , 68  , '' , 'bold' , 'bold')
  call s:hi('markdownH2' , 36  , '' , 'bold' , 'bold')
  call s:hi('markdownH3' , 114 , '' , 'bold' , 'bold')
  call s:hi('markdownH4' , 178 , '' , 'bold' , 'bold')
  call s:hi('markdownH5' , 68  , '' , 'None' , 'None')
  call s:hi('markdownH6' , 36  , '' , 'None' , 'None')
  call s:hi('mkdCode'    , 114 , '' , 'None' , 'None')
  call s:hi('mkdItalic'  , 36  , '' , 'None' , 'italic')

  " c
  call s:hi('cConstant'    , 178 , '' , 'none' , 'none')
  call s:hi('cCustomClass' , 167 , '' , 'bold' , 'bold')

  " cpp
  call s:hi('cppSTLexception', 199, '', 'bold', 'bold')
  call s:hi('cppSTLnamespace', 178, '', 'bold', 'bold')

  " css
  call s:hi('cssTagName' , 68  , '' , 'bold' , 'bold')
  call s:hi('cssProp'    , 169 , '' , 'bold' , 'bold')

  " dot
  call s:hi('dotKeyChar' , 176 , '' , 'none' , 'none')
  call s:hi('dotType'    , 178 , '' , 'none' , 'none')

  " sh
  call s:hi('shSet'         , 68  , '' , 'bold' , 'bold')
  call s:hi('shLoop'        , 68  , '' , 'bold' , 'bold')
  call s:hi('shFunctionKey' , 68  , '' , 'bold' , 'bold')
  call s:hi('shTestOpr'     , 178 , '' , 'none' , 'none')

  " solidity
  call s:hi('solContract'     , 178 , '' , 'bold' , 'bold')
  call s:hi('solContractName' , 168 , '' , 'bold' , 'bold')
  call s:hi('solBuiltinType'  , 176 , '' , 'none' , 'none')

  " vimL
  call s:hi('vimLet'     , 68 , '' , 'bold' , 'bold')
  call s:hi('vimFuncKey' , 68 , '' , 'bold' , 'bold')
  call s:hi('vimCommand' , 68 , '' , 'bold' , 'bold')
  call s:hi('vimGroup'   , 67 , '' , 'bold' , 'bold')
  call s:hi('vimHiGroup' , 67 , '' , 'bold' , 'bold')

  " rust
  call s:hi('rustKeyword' , 68  , '' , 'bold' , 'bold')
  call s:hi('rustModPath' , 68  , '' , 'none' , 'none')
  call s:hi('rustTrait'   , 168 , '' , 'bold' , 'bold')

  " json
  call s:hi('jsonStringSQError', 160, '', 'none', 'none')

  " xml
  call s:hi('xmlTag'     , 167 , '' , 'none' , 'none')
  call s:hi('xmlEndTag'  , 167 , '' , 'none' , 'none')
  call s:hi('xmlTagName' , 167 , '' , 'none' , 'none')

  " go
  call s:hi('goType'                  , 176 , '' , 'none' , 'none')
  call s:hi('goFloat'                 , 135 , '' , 'none' , 'none')
  call s:hi('goField'                 , 68  , '' , 'none' , 'none')
  call s:hi('goTypeName'              , 169 , '' , 'bold' , 'bold')
  call s:hi('goFunction'              , 169 , '' , 'bold' , 'bold')
  call s:hi('goMethodCall'            , 168 , '' , 'bold' , 'bold')
  call s:hi('goReceiverType'          , 114 , '' , 'none' , 'none')
  call s:hi('goFunctionCall'          , 169 , '' , 'bold' , 'bold')
  call s:hi('goFormatSpecifier'       , 68  , '' , 'none' , 'none')
  call s:hi('goTypeConstructor'       , 178 , '' , 'none' , 'none')
  call s:hi('goPredefinedIdentifiers' , 140 , '' , 'none' , 'none')

  " make
  call s:hi('makeCommands'   , 68 , '' , 'none' , 'none')
  call s:hi('makeSpecTarget' , 68 , '' , 'bold' , 'bold')

  " java
  call s:hi('rustScopeDecl' , 68  , '' , 'bold' , 'bold')
  call s:hi('javaClassDecl' , 168 , '' , 'bold' , 'bold')

  " scala
  call s:hi('scalaKeyword'        , 68 , '' , 'bold' , 'bold')
  call s:hi('scalaNameDefinition' , 68 , '' , 'bold' , 'bold')

  " ruby
  call s:hi('rubyClass'                  , 68  , '' , 'bold' , 'bold')
  call s:hi('rubyDefine'                 , 68  , '' , 'bold' , 'bold')
  call s:hi('rubyInterpolationDelimiter' , 176 , '' , 'none' , 'none')

  " html
  hi link htmlSpecialTagName Tag
  call s:hi('htmlItalic'  , 36  , '' , 'None' , 'italic')

  " python-mode
  call s:hi('pythonLambdaExpr'      , 105 , '' , 'none' , 'none')
  call s:hi('pythonClass'           , 207 , '' , 'bold' , 'bold')
  call s:hi('pythonParameters'      , 147 , '' , 'none' , 'none')
  call s:hi('pythonParam'           , 108 , '' , 'none' , 'none')
  call s:hi('pythonBrackets'        , 183 , '' , 'none' , 'none')
  call s:hi('pythonClassParameters' , 111 , '' , 'none' , 'none')
  call s:hi('pythonBuiltinType'     , 68  , '' , 'none' , 'none')
  call s:hi('pythonBuiltinObj'      , 71  , '' , 'bold' , 'bold')
  call s:hi('pythonBuiltinFunc'     , 169 , '' , 'bold' , 'bold')
  call s:hi('pythonOperator'        , 68  , '' , 'bold' , 'bold')
  call s:hi('pythonInclude'         , 68  , '' , 'bold' , 'bold')
  call s:hi('pythonSelf'            , 68  , '' , 'bold' , 'bold')
  call s:hi('pythonStatement'       , 68  , '' , 'bold' , 'bold')
  call s:hi('pythonDottedName'      , 169 , '' , 'bold' , 'bold')
  call s:hi('pythonDecorator'       , 169 , '' , 'bold' , 'bold')
  call s:hi('pythonException'       , 166 , '' , 'bold' , 'bold')
  call s:hi('pythonError'           , 195 , '' , 'none' , 'none')
  call s:hi('pythonIndentError'     , 196 , '' , 'none' , 'none')
  call s:hi('pythonSpaceError'      , 196 , '' , 'none' , 'none')

  """""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Plugins
  """""""""""""""""""""""""""""""""""""""""""""""""""""""
  " ALE
  hi link ALEErrorSign    Error
  hi link ALEWarningSign  Warning

  " vim-easymotion
  call s:hi('EasyMotionTarget'        , 76  , '' , 'bold' , 'bold')
  call s:hi('EasyMotionTarget2First'  , 162 , '' , 'bold' , 'bold')
  call s:hi('EasyMotionTarget2Second' , 69  , '' , 'bold' , 'bold')

  " vim-markdown
  call s:hi('htmlH1' , 68  , '' , 'bold' , 'bold')
  call s:hi('htmlH2' , 36  , '' , 'bold' , 'bold')
  call s:hi('htmlH3' , 114 , '' , 'bold' , 'bold')
  call s:hi('htmlH4' , 178 , '' , 'bold' , 'bold')
  call s:hi('htmlH5' , 68  , '' , 'None' , 'None')
  call s:hi('htmlH6' , 36  , '' , 'None' , 'None')

  " vim-indent-guides
  let g:indent_guides_auto_colors = 0
  call s:hi('IndentGuidesOdd'  , '' , 237 , 'none' , 'none')
  call s:hi('IndentGuidesEven' , '' , 239 , 'none' , 'none')

  " vim-gitgutter
  call s:hi('GitGutterAdd'          , 36  , '' , 'none' , 'none')
  call s:hi('GitGutterChange'       , 178 , '' , 'none' , 'none')
  call s:hi('GitGutterDelete'       , 160 , '' , 'none' , 'none')
  call s:hi('GitGutterChangeDelete' , 140 , '' , 'none' , 'none')

  " vim-signify
  call s:hi('SignifySignAdd'         , 36  , '' , 'none' , 'none')
  call s:hi('SignifySignChange'      , 178 , '' , 'none' , 'none')
  call s:hi('SignifySignDelete'      , 160 , '' , 'none' , 'none')
  call s:hi('SignifySignChangeDelete', 140 , '' , 'none' , 'none')

  " vim-startify
  hi link StartifyFile Normal
  call s:hi('StartifyHeader'  , 177 , '' , 'none' , 'none')
  call s:hi('startifySection' , 68  , '' , 'bold' , 'bold')

  " YouCompleteMe
  call s:hi('YcmErrorSection'   , 249 , 5  , 'none' , 'none')
  call s:hi('YcmWarningSection' , 249 , 60 , 'none' , 'none')

  " vim-leader-guide
  hi link LeaderGuideDesc Normal
  call s:hi('LeaderGuideKeys'     , 169 , '' , 'bold' , 'bold')
  call s:hi('LeaderGuideBrackets' , 36  , '' , 'none' , 'none')

  " NERDTree
  call s:hi('NERDTreeCWD'      , 169 , '' , 'bold' , 'bold')
  call s:hi('NERDTreeUp'       , 68  , '' , 'bold' , 'bold')
  call s:hi('NERDTreeDir'      , 68  , '' , 'bold' , 'bold')
  call s:hi('NERDTreeDirSlash' , 68  , '' , 'bold' , 'bold')
  call s:hi('NERDTreeOpenable' , 68  , '' , 'bold' , 'bold')
  call s:hi('NERDTreeClosable' , 68  , '' , 'bold' , 'bold')
  call s:hi('NERDTreeExecFile' , 167 , '' , 'bold' , 'bold')
  hi link NERDTreeLinkTarget Macro

  " Tagbar
  call s:hi('TagbarKind'             , 169 , '' , 'bold' , 'bold')
  call s:hi('TagbarScope'            , 169 , '' , 'bold' , 'bold')
  call s:hi('TagbarHighlight'        , 16  , 36 , 'bold' , 'bold')
  call s:hi('TagbarNestedKind'       , 68  , '' , 'bold' , 'bold')
  call s:hi('TagbarVisibilityPublic' , 34  , '' , 'none' , 'none')

  " vim-signature
  call s:hi('SignatureMarkText', 178, '', 'bold', 'bold')

  " vim_current_word
  call s:hi('CurrentWord'      , '' , s:bg1 , 'underline' , 'underline')
  call s:hi('CurrentWordTwins' , '' , s:bg1 , 'none'      , 'none')

  " quick-scope
  call s:hi('QuickScopePrimary'   , 155 , '' , 'underline' , 'underline')
  call s:hi('QuickScopeSecondary' , 81  , '' , 'underline' , 'underline')

  delf s:hi
  unlet s:color256 s:colors s:bg

  " Must be at the end, because of ctermbg=234 bug.
  " https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
  " 设置暗色调貌似会重置 Comment 的颜色
  " set background=dark

" } // end space-vim-dark
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

" call s:statusline_hi()
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
