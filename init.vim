source /home/Neutron/.config/nvim/lua/init.lua
"my functions
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vexplore
    endif
endfunction

"filebrowser settings
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_winsize=15
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

"toggles file browser
noremap <silent> <A-f> :call ToggleNetrw()<CR>
