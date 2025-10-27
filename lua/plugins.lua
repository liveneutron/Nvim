-- ensuring packer is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    ------------------------------------------------------------------
    -- DASHBOARD
    ------------------------------------------------------------------
    use {
        'goolord/alpha-nvim',
        config = function()
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        -- Dragoon
        local ascii = {
        '╔═════════════════════════════════════════════╗',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀  ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠔⢚⡭⠗⠋⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⣠⢶⡝⠁⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⢯⢀⡟⠉⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣞⢹⠊⠀⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠻⣄⣴⠋⠀⣠⣰⣇⣴⠁⡀⣤⠀⠀⠀⢀⡠⠾⣅⠀⡏⠀⠀⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡞⠒⣤⣼⣥⣴⠋⠁⠙⢿⡷⠾⣿⣧⣴⠲⢮⡉⠲⡀⢘⡞⠤⠤⠤⣐⡶⠦⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⣽⡩⣏⡴⠈⠉⣢⠵⠒⠒⠛⢢⡞⠙⠆⠀⢱⠀⢱⢀⡵⠋⠀⢀⡴⠋⠁⠀⣀⡀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠙⢋⢾⢇⢔⡁⣩⡞⠉⠁⣠⣶⣶⣢⠈⠻⡄⠉⠀⠈⣠⠴⠋⠀⠀⠀⠈⢁⣠⠽⠛⠋⠁⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⣿⡹⠓⡹⠓⠣⡀⡼⢹⠁⠀⣸⣿⣧⢽⡎⠀⡀⠰⣤⣖⠟⠃⠀⠀⠀⠀⠀⢰⠋⠀⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⣠⠾⠃⠈⠳⡄⣠⠊⠀⡇⢠⣾⣁⣘⡻⠼⠷⠾⠛⢁⣀⡈⢢⡀⠀⠀⠀⠀⠀⠸⣦⣀⡀⠀⠀⠀⠀ ║',
        '║⠀⢀⣤⠤⢤⣠⡞⢁⣀⣄⡀⠀⠈⠁⠀⠔⠓⠋⠉⠀⠀⠀⠀⠀⠀⠀⣨⡾⢺⡆⢻⡧⠀⠀⠀⠀⠀⠀⢠⠜⠋⠀⠀⠀ ║',
        '║⠀⡟⠁⠣⠀⠉⢒⡿⠃⠀⠪⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣾⢋⣿⡀⢣⠀⣷⣄⣤⣤⣤⣤⣤⣄⣙⠢⣀⠀⠀ ║',
        '║⢀⣇⠀⠀⠀⠐⠁⠀⢀⣦⣢⠈⠁⠉⠂⠄⠀⠀⠀⠀⠀⣠⠞⢋⡽⠃⠸⢸⡇⠀⠃⠹⡆⠀⠀⣿⡉⠉⠈⠉⠙⠚⢷⡀ ║',
        '║⢸⢹⠀⠀⠒⠃⠀⡇⡾⠟⠈⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣯⣶⡿⠁⠀⢁⠞⠁⠀⠀⢀⡷⡤⣤⣤⣭⣓⠢⣄⠀⠀⠀⠉ ║',
        '║⣿⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣿⠻⣿⣿⡯⡿⣿⡿⠋⠀⠀⠐⠁⠀⠀⠀⢀⡾⢷⣤⡀⠈⡟⠛⠛⠲⢽⣆⠀⠀ ║',
        '║⠈⢷⣤⣀⡀⠀⠀⠀⣀⣴⡿⢽⡍⠃⠀⠓⠇⢈⣠⣾⡜⠁⠀⢀⡴⠊⠁⠀⣠⡴⡿⡄⠀⠈⠛⢷⣜⢦⡀⠀⠀⠉⠃⠀ ║',
        '║⠀⠈⠯⠙⠛⠷⠶⠚⠉⢠⣇⠀⠀⠀⢀⣠⣴⣾⣿⠎⠀⣠⠾⢋⣀⣤⣴⠺⠙⠋⠀⠸⡄⠀⠀⠀⢹⣷⣷⡄⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⣀⠀⢀⣞⣾⡄⠀⢠⣿⣿⣷⠟⠁⣠⣾⠥⠚⠋⠉⢳⣌⠳⡉⠀⣀⠔⢣⠀⠀⠀⠈⣧⠘⢿⡄⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⢻⣦⣿⣯⡼⣙⣶⣯⡿⠟⠁⣠⠞⠋⠀⠀⠀⠀⠀⠀⢻⠉⢫⠉⠀⠀⢸⠀⠀⠀⠀⣿⣇⠀⢻⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠈⣷⠯⠿⠿⠿⠛⡉⠀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⢸⠀⠀⠀⣸⢀⠀⠀⠀⣿⠹⡄⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⣿⢷⣦⣠⣾⣴⣧⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠳⢼⠠⠴⠚⡝⠀⠀⠀⢀⣿⡆⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠘⢮⡇⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⢠⠃⠀⠀⡰⠁⠀⠀⠀⢸⠀⠇⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢫⡠⠃⠀⢀⡜⠁⠀⠀⠀⢀⡏⠀⠀⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠞⢁⡜⠉⠉⣩⠋⠀⠀⠀⠀⠀⡞⠀⠀⠀⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣈⡿⠛⠉⢹⡠⠊⠀⣠⠞⠁⠀⠀⠀⠀⢀⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀ ║',
        '║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠔⠚⠉⠀⠀⠀⠀⠀⣑⠖⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ║',
        '╚═════════════════════════════════════════════╝',
        }

        dashboard.section.header.val = ascii

        -- Options
        dashboard.section.buttons.val = {
        dashboard.button('n', 'New Journy', ':ene <BAR> startinsert<CR>'),
        dashboard.button('p', 'Pilgrimage', ':FZF<CR>'),
        dashboard.button('f', 'Fresh Air', ':PackerSync<CR>'),
        dashboard.button('q', "Journy's End", ':qa<CR>'),
        }

        -- ── STYLE ─────────────────────────────────────────────────────
        dashboard.section.header.opts.hl   = 'Include'
        dashboard.section.buttons.opts.hl  = 'Keyword'

        -- ── FOOTER ─────────────────────────────────────────────────────
        dashboard.section.footer.val = {}

        -- highlight the ASCII art
        dashboard.section.header.opts.hl = "Include"  -- "String", "Comment" "Include", "Title", etc. String looks like piss for retrobox

        -- Disable unnecessary autocmds
        dashboard.opts.opts.noautocmd = true

        alpha.setup(dashboard.opts)
    end,
    }
end)
