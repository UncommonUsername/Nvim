-- ========================================================== --
-- =                     EDITOR SETTINGS                    = --
-- ========================================================== --

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8

vim.opt.hlsearch = true

-- ========================================================== --
-- =                      KEYBINDINGS                       = --
-- ========================================================== --
 
vim.g.mapleader = ' '

-- Clear search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Copy to clipboard
vim.keymap.set({'n', 'x'}, 'gy', '"+y')

-- Paste from clipboard
vim.keymap.set({'n', 'x'}, 'gp', '"+p')

-- ========================================================== --
-- =                        PLUGINS                         = --
-- ========================================================== --

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	{'ellisonleao/gruvbox.nvim', priority = 1000, config = true, opts = ...},
	{'nvim-lualine/lualine.nvim'},
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
})

-- ========================================================== --
-- =                 PLUGIN CONFIGURATION                   = --
-- ========================================================== --

vim.opt.showmode = false
require('lualine').setup({
	options = {
		icons_enabled = false,
		theme = 'gruvbox',
		component_separator = '|',
		section_separators = '',
	},
})

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'c', 'cpp', 'python', 'javascript' }, -- Adjust languages as needed
    highlight = {
        enable = true,
    },
})

-- ========================================================== --
-- =                COLORSCHEME AND FONTS                   = --
-- ========================================================== --

vim.opt.termguicolors = true
vim.o.background = 'dark'
vim.cmd.colorscheme('gruvbox')
