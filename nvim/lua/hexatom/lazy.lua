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

  -- Rainbow delimiters
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'BufEnter',
    dependencies = {
      'lukas-reineke/indent-blankline.nvim',
    },
  },

  -- cmp & co
  {
    'hrsh7th/nvim-cmp',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
      'windwp/nvim-autopairs',
    },
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost' },
    cmd = { 'LspInfo', 'LspInstall', 'LspUninstall', 'Mason' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
      },
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'mfussenegger/nvim-lint',
      'mhartington/formatter.nvim',
      'mfussenegger/nvim-ansible',
      'towolf/vim-helm',
      'b0o/schemastore.nvim',
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    },
  },

  -- Telescope
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-media-files.nvim',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    event = { 'BufEnter' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
    },
  },

  -- Comment
  {
    'numToStr/Comment.nvim',
    event = { 'BufEnter' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },

  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
  },

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
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
  },

  -- Whichkey
  'folke/which-key.nvim',

  -- gitignore
  'wintermute-cell/gitignore.nvim',

  -- dressing
  'stevearc/dressing.nvim',

  -- spectre
  {
    'nvim-pack/nvim-spectre',
    lazy = true,
    cmd = { 'Spectre' },
  },

  -- ufo
  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = {
      'kevinhwang91/promise-async',
      'luukvbaal/statuscol.nvim',
    },
  },

  -- wilder
  {
    'gelguy/wilder.nvim',
    keys = {
      ':',
      '/',
      '?',
    },
  },
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
