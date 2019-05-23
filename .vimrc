set nu! " 显示行号
syntax on " 代码高亮
set ts=4 " 设置tab键空格数量
set backspace=2 " 解决删除键失效
set wildmode=list:longest " vim 命令模式补全
set autoindent " 换行缩进
set autowrite " 自动保存内容
set hlsearch " 高亮搜索 :nohlsearch or :noh 清除最近一次高亮搜索
set ignorecase " 搜索区分大小写
set smartcase " 自动判断是否区分大小写
"set paste " 解决粘贴乱码
" 切换自动缩进快捷键
set pastetoggle=<F9>
" 开启所有模式鼠标支持
" set mouse=a
" 显示当前所在行
set cursorline

set nocompatible              " be iMproved, required 关闭vim处于历史兼容型的考虑而设置的vi模式
filetype off                  " required 自动检测文件类型

" 启用vundle来管理vim插件
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 安装插件写在这之后

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe' " 代码补全插件
Plugin 'fatih/vim-go' " go vim 开发插件
Plugin 'kien/ctrlp.vim' " go vim 依赖
Plugin 'AndrewRadev/splitjoin.vim' " go 结构体拆分与连接
Plugin 'SirVer/ultisnips' " 代码片段
Plugin 'fatih/molokai' " 颜色方案
Plugin 'scrooloose/nerdtree' " 目录插件
Plugin 'Xuyuanp/nerdtree-git-plugin' " git 插件
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive' " 状态栏显示 git 分支
Plugin 'majutsushi/tagbar' " 代码视图、方法、变量 
Plugin 'Raimondi/delimitMate' " 括号补全
" Plugin 'Blackrush/vim-gocode' " go代码提示
" 安装插件写在这之前
call vundle#end()            " required
filetype plugin on    " required

" 常用命令
" :PluginList       - 查看已经安装的插件
" :PluginInstall    - 安装插件
" :PluginUpdate     - 更新插件
" :PluginSearch     - 搜索插件，例如 :PluginSearch xml就能搜到xml相关的插件
" :PluginClean      - 删除插件，把安装插件对应行删除，然后执行这个命令即可

" h: vundle         - 获取帮助

" vundle的配置到此结束，下面是你自己的配置

"**** go-vim 配置 start ****"

" 设置 leader 键
let mapleader = ","
" quickfix 下一个
map <C-n> :cnext<CR>
" quickfix 上一个
map <C-m> :cprevious<CR>
" quickfix 关闭
nnoremap <leader>a :cclose<CR>
" GoBuild
" autocmd FileType go nmap <leader>b <Plug>(go-build)
" GoRun
autocmd FileType go nmap <leader>r <Plug>(go-run)
" 使用 vim 终端打开
autocmd FileType go nmap <leader>lr :terminal go run %<CR>
" 让所有的都用 quickfix
let g:go_list_type = "quickfix"
" GoTest
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" 自动判断是 GoBuild 还是 GoTestCompile
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" GoCoverageToggle
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" 关闭保存自动执行某些命令 命令依赖于 let g:go_fmt_command 默认 Gofmt
" let g:go_fmt_autosave = 1
" 替换 GoFmt 为 GoImports
let g:go_fmt_command = "goimports"
" GoFmt 快捷键
autocmd FileType go nmap <leader>l  <Plug>(go-imports)
" 关闭 af 会选中函数注释
" let g:go_textobj_include_function_doc = 0

"********** 解决 ultisnips 与 YouComp.. 的快捷键冲突 **********
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction
function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction
if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
"***********************************************************

" 禁用保存文件时 展示 quickfix list 错误
" let g:go_fmt_fail_silently = 1
" 修改生成 json tag 的方式 camelcase or snake_case
" let g:go_addtags_transform = "camelcase"

"*********** 启动更多颜色，语法高亮，默认启用少量 ************
" 类型 type 高亮
let g:go_highlight_types = 1
" 类型字段高亮
let g:go_highlight_fields = 1
" 函数高亮
let g:go_highlight_functions = 1
" 函数调用高亮
let g:go_highlight_function_calls = 1
" 操作符高亮
let g:go_highlight_operators = 1
" 高亮额外类型 reflect bytes......
let g:go_highlight_extra_types = 1
" build tag 高亮
let g:go_highlight_build_constraints = 1
" 高亮 generate
let g:go_highlight_generate_tags = 1
"*************************************************************

" tab 设置 4 空格
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" 保存时调用 GoMetaLinter：let g:go_metalinter_autosave_enabled = ['vet',
" 'golint']
let g:go_metalinter_autosave = 1
" GoAlternate 快捷方式，打开测试文件
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" GoInfo 在状态栏显示函数定义信息
autocmd FileType go nmap <Leader>i <Plug>(go-info)
" GoInfo 自动显示函数定义信息
" let g:go_auto_type_info = 1
" GoInfo 设置更新时间 ms
set updatetime=20
" 自动展示相同的定义 GoSameIds
let g:go_auto_sameids = 1
" 设置 GoPlay 默认浏览器
"let g:go_play_open_browser = 1
"let g:go_play_browser_command = "xdg-open %URL%"
" 关闭模板
"let g:go_template_autocreate = 0
"**** go-vim 配置 end ****"

"**** nerdtree 配置 start ****
" 配置打开目录快捷键
map <F3> :NERDTreeToggle<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" git 符号
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
"*****************************
" go-code 代码提示快捷键
" imap <F6> <C-x><C-o>

"********** ariline **********
" tag
let g:airline#extensions#tabline#enabled = 1
" tag 分割
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"******************************

"*********** vim 终端 ************
if has('terminal')
  " Kill job and close terminal window
  tnoremap <Leader>q <C-w><C-c><C-w>c<cr>

  " switch to normal mode with esc
  "tnoremap <Esc> <C-W>N

  " mappings to move out from terminal to other views
  tnoremap <C-h> <C-w>h
  tnoremap <C-j> <C-w>j
  tnoremap <C-k> <C-w>k
  tnoremap <C-l> <C-w>l
 
  " Open terminal in vertical, horizontal and new tab
  nnoremap <leader>tv :vsplit<cr>:term ++curwin<CR>
  nnoremap <leader>ts :split<cr>:term ++curwin<CR>
  nnoremap <leader>tt :tabnew<cr>:term ++curwin<CR>

  tnoremap <leader>tv <C-w>:vsplit<cr>:term ++curwin<CR>
  tnoremap <leader>ts <C-w>:split<cr>:term ++curwin<CR>
  tnoremap <leader>tt <C-w>:tabnew<cr>:term ++curwin<CR>

  " 进入正常模式 Ctrl+W+N
  " 离开正常模式 i or a

  " always start terminal in insert mode when I switch to it
  " NOTE(arslan): startinsert doesn't work in Terminal-normal mode.
  autocmd WinEnter * if &buftype == 'terminal' | call feedkeys("i") | endif
endif
"*********************************

"********* 补全括号插件 **********
" 括号内回车自动换行格式化
let g:delimitMate_expand_cr = 1
"*********************************

"***********youcompleteme**************
" 自动关闭预览窗口
let g:ycm_autoclose_preview_window_after_insertion = 1
" 触发补全
let g:ycm_key_invoke_completion = '<c-z>'
" ctrl y 取消补全
"**************************************

"********* 颜色方案 *********
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai
" 支持透明背景
hi normal ctermbg=none
hi nontext ctermbg=none
hi linenr ctermbg=none
" 设置行号的颜色
highlight linenr ctermfg=white
highlight Visual ctermfg=white ctermbg=red
"set t_co=256
"****************************

