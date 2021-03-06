" Define base path environment variables
let $VIMCONFIG = stdpath("config")
let $VIMDATA = stdpath("data")

" Make the undo history persistant
set undofile

" Make the sign column always visible
set signcolumn=yes

" Make it easy to work with buffers
set hidden

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
autocmd vimenter * ++nested colorscheme gruvbox

" Add powerline like decorations
" lightline install
call minpac#add('itchyny/lightline.vim')
" add gruvbox thee for lightline
call minpac#add('shinchu/lightline-gruvbox.vim')
let g:lightline = {'colorscheme': 'gruvbox'}

" Add markdown preview support
call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})

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
" enable completion from ALE
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
set omnifunc=ale#completion#OmniFunc
" For JavaScript files, use `eslint` (and only eslint)
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'rust': ['analyzer'],
\}
" For JavaScript fixes, use `eslint`
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'rust': ['analyzer'],
\}
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
let test#strategy = "dispatch"

" Add Rust lang integration
call minpac#add('rust-lang/rust.vim')
" Add Go lang integration
call minpac#add('fatih/vim-go', { 'do': ':GoUpdateBinaries' })
" Add Guile integration
call minpac#add('HiPhish/guile.vim')
" Read and navigate Info files in Vim
call minpac#add('HiPhish/info.vim')
" The universal, extendible and configurable REPL plugin
call minpac#add('HiPhish/repl.nvim')
" Add ruby lang integration
call minpac#add('vim-ruby/vim-ruby')
" Add puppet integration
call minpac#add('rodjek/vim-puppet')
