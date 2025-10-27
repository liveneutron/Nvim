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
