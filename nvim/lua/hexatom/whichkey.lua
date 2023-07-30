local status_ok, wk = pcall(require, 'which-key')
if not status_ok then return end

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
    },
    presets = false,
  },
  icons = {
    separator = '',
  },
})

local global_mappings = {
  ['<up>'] = { '<nop>', 'which_key_ignore' },
  ['<down>'] = { '<nop>', 'which_key_ignore' },
  ['<left>'] = { '<nop>', 'which_key_ignore' },
  ['<right>'] = { '<nop>', 'which_key_ignore' },
}

local normal_mappings = {
  ['<leader>'] = {
    name = 'hexatom',
    d = { ':lua vim.diagnostic.open_float()<cr>', 'floating diagnostics' },
    e = {
      name = '+edit configs',
      i = { ':vsplit ~/.config/i3/config<cr>', 'edit i3 config' },
      n = { ':vsplit ~/.config/nvim/init.lua<cr>', 'edit nvim config' },
      t = { ':vsplit ~/.config/tmux/tmux.conf<cr>', 'edit tmux config' },
      z = { ':vsplit ~/.config/zsh/.zshrc<cr>', 'edit zsh config' },
    },
    f = {
      name = 'find',
      f = { ':Telescope find_files<cr>', 'find file' },
      h = { ':Telescope oldfiles<cr>', 'recently used files' },
      r = { ':Telescope live_grep<cr>', 'find string' },
    },
    g = {
      name = 'gitsigns',
      j = { ':Gitsigns next_hunk<cr>', 'Next Hunk' },
      k = { ':Gitsigns prev_hunk<cr>', 'Prev Hunk' },
      b = { ':Gitsigns blame_line<cr>', 'Blame' },
      p = { ':Gitsigns preview_hunk<cr>', 'Preview Hunk' },
      r = { ':Gitsigns reset_hunk<cr>', 'Reset Hunk' },
      R = { ':Gitsigns reset_buffer<cr>', 'Reset Buffer' },
    },
    h = { '<c-w>h', 'move left' },
    j = { '<c-w>j', 'move down' },
    k = { '<c-w>k', 'move up' },
    l = { '<c-w>l', 'move right' },
    n = { '<c-w>=', 'normalize windows' },
    o = { '<c-w>v', 'split pane vertically' },
    r = { ':lua vim.lsp.buf.rename()<cr>', 'rename token' },
    p = { ':set paste!<cr>', 'toggle paste mode' },
    t = {
      name = 'trees and lists',
      d = { ':lua vim.diagnostic.setloclist()<cr>', 'open diagnostics list' },
      f = { ':NvimTreeFocus<cr>', 'open file tree' },
      l = { ':noautocmd bufdo vimgrepadd /TODO/j % | copen<cr>', 'open TODO list' },
      r = { ':lua vim.lsp.buf.references()<cr>', 'open references list' },
      u = { ':lua require("undotree").toggle { async = true }<cr>', 'open undo tree' },
    },
    u = { '<c-w>s', 'split pane horizontally' },
    w = { ':w<cr>', 'save file' },
    W = { ':w<cr>:Bdelete<cr>', 'save file and quit' },
    x = {
      name = 'close',
      a = { ':qa<cr>', 'vim' },
      b = { ':Bdelete<cr>', 'buffer' },
      t = { 'tabclose<cr>', 'tab' },
      w = { ':q<cr>', 'window' },
      x = { ':Bdelete<cr>:q<cr>', 'buffer + window' },
    },
    X = {
      name = 'force close',
      A = { ':qa!<cr>', 'force close vim' },
      B = { ':Bdelete!<cr>', 'force close buffer' },
      X = { ':Bdelete!<cr>:q<cr>', 'force close buffer + window' },
    },
    ['<leader>'] = { ':ToggleTerm<cr>', 'open floating terminal' },
    z = {
      name = 'folding',
      c = { 'close fold under cursor' },
      C = { 'close all folds under cursor' },
      M = { 'close all folds' },
      o = { 'open fold under cursor' },
      O = { 'open all folds under cursor' },
      R = { 'open all folds' },
    },
    ['='] = { ':Format<cr>', 'format file' },
  },
  g = {
    name = 'goto',
    d = { ':lua vim.lsp.buf.definition()<cr>', 'definition' },
    i = { ':lua vim.lsp.buf.implementation()<cr>', 'implementation' },
    n = {
      name = 'next',
      d = { ':lua vim.diagnostic.goto_next', 'diagnostic' },
    },
    p = {
      name = 'previous',
      d = { ':lua vim.diagnostic.goto_prev', 'diagnostic' },
    },
    r = { ':lua require("telescope.builtin").lsp_references()<cr>', 'references' },
  },
  H = { ':bprev<cr>', 'focus previous buffer' },
  ['<c-j>'] = { ':m +1<cr>', 'move line up' },
  K = { ':lua vim.lsp.buf.hover()<cr>', 'open hover menu' },
  ['<c-k>'] = { ':m -2<cr>', 'move line down' },
  L = { ':bnext<cr>', 'focus next buffer' },
  ['<c-w>'] = {
    name = 'which_key_ignore',
    h = { '<nop>', 'which_key_ignore' },
    j = { '<nop>', 'which_key_ignore' },
    k = { '<nop>', 'which_key_ignore' },
    l = { '<nop>', 'which_key_ignore' },
    ['='] = { '<nop>', 'which_key_ignore' },
    s = { '<nop>', 'which_key_ignore' },
    v = { '<nop>', 'which_key_ignore' },
  },
  Y = { 'y$', 'which_key_ignore' },
  ['<esc>'] = { ':noh<cr>:echo<cr>', 'clear highlight and message' },
}

local insert_mappings = {
  ['<esc>'] = { '<nop>', 'which_key_ignore' },
  ['<backspace>'] = { '<nop>', 'which_key_ignore' },
  ['jk'] = { '<esc>', 'which_key_ignore' },
  ['kj'] = { '<esc>', 'which_key_ignore' },
  ['<c-k>'] = { '<esc>:m .-2<cr>a', 'move line up' },
  ['<c-j>'] = { '<esc>:m .+1<cr>a', 'move line down' },
}

local visual_mappings = {
  p = { '"_dP', 'which_key_ignore' },
  ['<'] = { '<gv', 'which_key_ignore' },
  ['>'] = { '>gv', 'which_key_ignore' },
}

wk.register(normal_mappings)
wk.register(global_mappings, { mode = '' })
wk.register(insert_mappings, { mode = 'i' })
wk.register(visual_mappings, { mode = 'v' })
