local function apply_options(option_table, global)
  for k, v in pairs(option_table) do
    if global then
      vim.g[k] = v
    else
      vim.opt[k] = v
    end
  end
end

local fn = vim.fn

local options = {
  autoindent = true,
  autoread = true,
  backup = true,
  backupcopy = 'yes',
  backupdir = fn.stdpath('data') .. '/backup',
  clipboard = 'unnamedplus',
  colorcolumn = '+1',
  completeopt = { 'menuone', 'noselect' },
  conceallevel = 0,
  cursorline = true,
  directory = fn.stdpath('data') .. '/swap',
  encoding = 'utf8',
  expandtab = true,
  fileencoding = 'utf-8',
  fileformats = { 'unix', 'dos', 'mac' },
  foldlevel = 9999,
  foldmethod = 'expr',
  foldexpr = 'nvim_treesitter#foldexpr()',
  hidden = true,
  hlsearch = true,
  list = true,
  listchars = { tab = '󰞔', space = '·', trail = '·', extends = '', precedes = '' },
  mouse = '',
  number = true,
  scrolloff = 99,
  sidescrolloff = 20,
  signcolumn = 'yes',
  shiftwidth = 2,
  showmode = false,
  smartindent = true,
  smarttab = false,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  swapfile = true,
  tabstop = 2,
  termguicolors = true,
  textwidth = 120,
  timeoutlen = 300,
  undodir = fn.stdpath('data') .. '/undo',
  undofile = true,
  undolevels = 10000,
  updatetime = 500,
  viminfofile = fn.stdpath('data') .. '/viminfo',
  virtualedit = 'all',
  writebackup = true,
}

vim.opt.formatoptions:append('n')
vim.opt.iskeyword:append('-')

apply_options(options)

local globals = {
  is_bash = 1,
  loaded_netrw = 1,
  loaded_netrwPlugin = 1,
  loaded_perl_provider = 0,
  loaded_ruby_provider = 0,
  loaded_python3_provider = 0,
  loaded_node_provider = 0,
  mapleader = ' ',
  maplocalleader = ' ',
  skip_ts_context_commentstring_module = true,
}

apply_options(globals, true)

vim.cmd([[
  augroup open_at_last_pos
    autocmd!
    autocmd open_at_last_pos BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup end
]])
