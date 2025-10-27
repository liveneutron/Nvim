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

        -- Your ASCII Art
        local ascii = {
        ' ,_     _   ',
        ' |\\\\_,-~/   ',
        ' / _  _ |    ,--. ',
        '(  @  @ )   / ,-\' ',
        ' \\  _T_/-._( (   ',
        ' /         `. \\  ',
        '|         _  \\ | ',
        ' \\ \\ ,  /      | ',
        '  || |-\\_\\__   / ',
        ' ((_/`(____,-\'  ',
        }

        dashboard.section.header.val = ascii

        -- Auto-calculate vertical padding to center the art
        local height = #ascii
        local win_height = vim.fn.winheight(0)
        local padding = math.floor((win_height - height) / 2)
        if padding < 0 then padding = 0 end

        dashboard.opts.layout = {
        { type = "padding", val = padding },
        dashboard.section.header,
        }

        -- Header and Footer
        dashboard.section.buttons.val = {}
        dashboard.section.footer.val = {}

        -- Optional: highlight the ASCII art
        dashboard.section.header.opts.hl = "String"  -- or "Include", "Title", etc.

        -- Disable unnecessary autocmds
        dashboard.opts.opts.noautocmd = true

        alpha.setup(dashboard.opts)
    end,
    }
end)
