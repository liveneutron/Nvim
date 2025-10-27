-- STATUS LINE
vim.o.laststatus = 3
local modes = {
    ['n']    = 'NORMAL',
    ['no']   = 'N·OPERATOR PENDING',
    ['v']    = 'VISUAL',
    ['V']    = 'V·LINE',
    ['\22']  = 'V·BLOCK',  -- ^V
    ['s']    = 'SELECT',
    ['S']    = 'S·LINE',
    ['\19']  = 'S·BLOCK',  -- ^S
    ['i']    = 'INSERT',
    ['R']    = 'REPLACE',
    ['Rv']   = 'V·REPLACE',
    ['c']    = 'COMMAND',
    ['cv']   = 'VIM EX',
    ['ce']   = 'EX',
    ['r']    = 'PROMPT',
    ['rm']   = 'MOAR',
    ['r?']   = 'CONFIRM',
    ['!']    = 'SHELL',
    ['t']    = 'TERMINAL',
}

local function mode()
    local current_mode = vim.fn.mode()
    return string.format(' %s ', modes[current_mode] or 'UNKNOWN')
end

_G.mode = mode

local statusline = {
    ' %#Search#%{v:lua.mode()}%#StatusLine# ',
    '%t ',
    '%r',
    '%=',
    '[%{&filetype}] ',
    '%2p%% ',
    '%#Search# %04L:%04l:%02c %#StatusLine#'
}

vim.o.statusline = table.concat(statusline, '')
