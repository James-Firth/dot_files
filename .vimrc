" Show RELATIVE line numbers and commands as they're typed
set number relativenumber
set showcmd

" Fix weird indent issues
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" supposed to fix issues
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
