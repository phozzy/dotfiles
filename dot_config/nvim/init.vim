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
