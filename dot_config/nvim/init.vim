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

" Add powerline like decorations
" airline install
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
" configure airline
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" configure fuzzy search
" be sure that fzf package is installed using a package manager
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
nnoremap <C-p> :<C-u>FZF<CR>

" configure semantic search
call minpac#add('tpope/vim-projectionist')

" install dispatch plugin
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')
