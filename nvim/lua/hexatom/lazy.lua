local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- lazy.nvim
  {
    'folke/lazy.nvim',
    build = ':lua require("lazy").update({ show = false })',
  },
  -- Common Dependencies
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',

  -- Dracula colorscheme
  'Mofiqul/dracula.nvim',

  -- Indentlines
  'lukas-reineke/indent-blankline.nvim',

  -- cmp plugins
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',

  -- snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  -- LSP
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
  },
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'mfussenegger/nvim-lint',
  'mhartington/formatter.nvim',
  'mfussenegger/nvim-ansible',
  'towolf/vim-helm',
  'b0o/schemastore.nvim',

  -- Telescope
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-media-files.nvim',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'p00f/nvim-ts-rainbow',
  'JoosepAlviste/nvim-ts-context-commentstring',
  'nvim-treesitter/playground',

  -- Autopairs
  'windwp/nvim-autopairs',

  -- Comment
  'numToStr/Comment.nvim',

  -- Gitsigns
  'lewis6991/gitsigns.nvim',

  -- NvimTree
  'kyazdani42/nvim-tree.lua',
  'kyazdani42/nvim-web-devicons',

  -- Bufferline
  'akinsho/bufferline.nvim',
  'moll/vim-bbye',

  -- Toggleterm
  'akinsho/toggleterm.nvim',

  -- Undotree
  'jiaoshijie/undotree',

  -- Lualine
  'nvim-lualine/lualine.nvim',

  -- Whichkey
  'folke/which-key.nvim',

  -- gitignore
  'wintermute-cell/gitignore.nvim',
}

local opts = {
  concurrency = 10,
  install = {
    colorscheme = { 'dracula' },
  },
  custom_keys = {},
  diff = {
    cmd = 'diffview.nvim',
  },
  checker = {
    enabled = true,
    concurrency = 10,
    notify = false,
  },
}

require('lazy').setup(plugins, opts)
