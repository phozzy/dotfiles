" Define base path environment variables
let $VIMCONFIG = stdpath("config")
let $VIMDATA = stdpath("data")

" make sure that package directories exist
call mkdir(stdpath("config") . "/pack/bundle/start" , "p")
call mkdir(stdpath("config") . "/pack/bundle/opt" , "p")
call mkdir(stdpath("config") . "/pack/minpac/start" , "p")
call mkdir(stdpath("config") . "/pack/minpac/opt" , "p")

" Configure minpac plugin manager
" make sure that minpac is downloaded
" be sure that Git is installed in your system!
if empty(glob(stdpath("config") . "/pack/minpac/opt/minpac"))
  silent !git clone https://github.com/k-takata/minpac.git ${VIMCONFIG}/pack/minpac/opt/minpac
endif
" load and initialize the plugin
packadd minpac
call minpac#init()
" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})
" commands to manage packates easilier with minpac
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" Install Gruvbox vim theme
call minpac#add('morhetz/gruvbox')
autocmd vimenter * colorscheme gruvbox

" Add powerline like decorations
" airline install
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
" configure airline
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" configure fuzzy search
" be sure that fzf package is installed using a package manager
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
nnoremap <C-p> :<C-u>FZF<CR>
" be sure that ripgrep package is installed using a package manager
let $FZF_DEFAULT_COMMAND = 'rg --files'

" configure semantic search
call minpac#add('tpope/vim-projectionist')

" install dispatch plugin
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')

" install ALE asynchronous linting engine
call minpac#add('dense-analysis/ale')
" For JavaScript files, use `eslint` (and only eslint)
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}
" Make the sign column always visible
let g:ale_sign_column_always = 1
" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

" install Grepper plugin
call minpac#add('mhinz/vim-grepper')
" configure Grepper plugin
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg']
" search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
" search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
" Open Grepper-prompt for a particular grep-alike tool
nnoremap <Leader>g :Grepper -tool git<CR>
nnoremap <Leader>G :Grepper -tool rg<CR>

" Install vim-test plugin
call minpac#add('vim-test/vim-test')
