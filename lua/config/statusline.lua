-- STATUS LINE
vim.o.laststatus = 3
-- Which mode
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

-- function to get current date
function _G.get_statusline_date()
    return os.date('%d/%m/%y')
end

-- function to get current time
function _G.get_statusline_time()
  return os.date('%H:%M:%S')
end

--function to get file size of current buffer
function _G.file_size()
  local buf = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(buf)

  -- Skip non‑file buffers
  if path == '' or vim.fn.filereadable(path) == 0 then
    return ''
  end

  local ok, stat = pcall(vim.loop.fs_stat, path)
  if not ok or not stat then
    return ''
  end

  local size = stat.size               -- bytes (integer)
  -- unit conversion from bytes to human readable unit
  if size < 1024 then
    return string.format('%d B', size)
  elseif size < 1024 * 1024 then
    return string.format('%.1f KB', size / 1024)
  elseif size < 1024 * 1024 * 1024 then
    return string.format('%.1f MB', size / (1024 * 1024))
  else
    return string.format('%.1f GB', size / (1024 * 1024 * 1024))
  end
end

-- Retrive git brach name
function get_git_branch()
    local handle = io.popen("git rev-parse --abbrev-ref HEAD 2> /dev/null")
    local branch = handle:read("*a")
    handle:close()

    if branch ~= "" then
        return branch:gsub("%s+", "") -- Trim whitespace
    else
        return ""
    end
end

-- Nvim version function
function get_nvim_version()
    return vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
end

local statusline = {
    '%#Keyword#[%{v:lua.get_nvim_version()}]%#StatusLine# ',
    '%#Keyword#%{v:lua.mode()}%#StatusLine# ',
    '%#Search# %{%v:lua.get_statusline_date()%} %#Statusline# ',
    '%=',
    '[%{%v:lua.get_git_branch()%}]',
    ' %t',
    ' %r',
    '%=',
    '%#Search# %{%v:lua.get_statusline_time()%} %#Statusline#',
    ' [%{&filetype}]',
    '[%{%v:lua.file_size()%}] ',
    '%2p%% ',
    '%#Search# %04L:%04l:%02c %#StatusLine#'
}

vim.o.statusline = table.concat(statusline, '')

-- Function to redraw statusline
function redrawstatus()
    vim.cmd("redrawstatus")
end

-- Timer to for redrawstatus function
function start_timer()
    vim.defer_fn(function()
        redrawstatus()
        start_timer()
    end, 1000)
end

-- Start timer
start_timer()
