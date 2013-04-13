" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
"开启语法高亮"
if has("syntax")
  syntax on
endif

filetype plugin on
"自动缩进"
set cindent
"Tab宽度"
set tabstop=4
"匹配括号"
set showmatch
"缩进格数"
set softtabstop=4
set shiftwidth=4
"编码设置"
set enc=utf-8
set fencs=utf-8,gb18030,gdk,gdk2312
set fenc=utf-8
"set tenc=gbk2312
"开启文件类型检测，主要是makefile文件中的Tab"
filetype plugin indent on
"空格代替Tab"
set expandtab
"set noexpandtab"
"实时搜索"
set incsearch
"缩进折叠
set fdm=indent

set autochdir
map \gc :vimgrep /<c-r><c-w>/g *.c<cr>
map \gh :vimgrep /<c-r><c-w>/g *.h<cr>
map \ft :!sdcv <c-r><c-W><cr> 


"进行版权声明的设置
"添加或更新头
map <F4> :call TitleDet()<cr>
function AddTitle()
    call append(0,"/*")
    call append(1," *           (c) 罗忠尧 ")
    call append(2," * Email         :\tluozhongyao@gmail.com")
    call append(3," * Author        :\t罗忠尧")
    call append(4," * Last modified :\t".strftime("%Y-%m-%d %H:%M"))
    call append(5," * Filename      :\t".expand("%:t"))
    call append(6," * Description   :\t")
    call append(7," */")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf
"更新最近修改时间和文件名
function UpdateTitle()
    normal mk
    execute '/^\s*\*\s*Last modified\s*:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
    execute '/^\s*\*\s*Filename\s*:/s@:.*$@\=":\t".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endf
"判断前10行代码里面，是否有Last modified这个单词，
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
    "默认为添加
    let line = getline(2)
    if line =~ '^\s*\*\s*(c)\s*罗忠尧\s*$'
        call UpdateTitle()
            return
    endif
    call AddTitle()
endf


" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

