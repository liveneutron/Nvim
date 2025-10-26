-- colorscheme
vim.cmd("colorscheme retrobox")

-- basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.syntax = on
vim.o.showcmd = true
vim.o.wrap = true
vim.o.cursorline = false
vim.o.scrolloff = 10
vim.o.sidescroll = 8

-- indentation settings
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

--search settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- visual settings
vim.o.termguicolors = true
vim.o.showtabline = 1
vim.o.showmode = false

-- file handling
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autoread = true
vim.o.autowrite = false

-- cursor setting
vim.opt.guicursor = "n-v-c:block,i-ci-ve:block"

-- Keyboard shortcuts
-- keymap
vim.api.nvim_set_keymap('n', '<Space>', '', { noremap = true, silent = true })
vim.g.mapleader = " "

-- centering screen when umping vertically
vim.keymap.set("n", "<A-d>", "<C-d>zz")
vim.keymap.set("n", "<A-u>", "<C-u>zz")

-- Tab handeling
vim.keymap.set("n", "<A-w>", ":tabnew<CR>")
vim.keymap.set("n", "<A-s>", ":tabclose<CR>")
vim.keymap.set("n", "<A-k>", ":tabnext<CR>")
vim.keymap.set("n", "<A-j>", ":tabprevious<CR>")
vim.keymap.set("n", "<A-S-k>", ":tabmove +1<CR>")
vim.keymap.set("n", "<A-S-j>", ":tabmove -1<CR>")

-- Move line/selection up or down
vim.keymap.set("n", "<S-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<S-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv")

-- better indenting in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- file finding
-- fzf
vim.keymap.set("n", "<leader>f", ":FZF --reverse --border double --ghost=Search --input-border sharp --no-info<CR>")
vim.cmd([[let $FZF_DEFAULT_OPTS="--preview 'cat {}' --preview-border sharp --no-scrollbar"]])



-- Basic autocommands
local augtogroup = vim.api.nvim_create_augroup("UserConfig", {})


-- highlight-yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = autogroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = autogroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = autogroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- ============================================================================
-- STATUS LINE
-- ============================================================================
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


-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

-- terminal
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.api.nvim_win_set_option(terminal_state.win, 'winblend', 0)

  -- Set transparent background for the window
  vim.api.nvim_win_set_option(terminal_state.win, 'winhighlight',
    'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder')

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
    vim.fn.termopen(os.getenv("SHELL"))
  end

  terminal_state.is_open = true
  vim.cmd("startinsert")

  -- Set up auto-close on buffer leave 
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true
  })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

-- Key mappings
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
  if terminal_state.is_open then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })
