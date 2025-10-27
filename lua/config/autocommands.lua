-- Autogroup setup
local augtogroup = vim.api.nvim_create_augroup("UserConfig", {})

-- highlight-yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = autogroup,
    callback = function()
        vim.hl.on_yank()
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
