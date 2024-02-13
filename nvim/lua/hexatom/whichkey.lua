local status_ok, wk = pcall(require, 'which-key')
if not status_ok then return end

wk.setup({
  plugins = {
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
    e = {
      name = 'edit configs',
      i = { ':vsplit ~/.config/i3/config<cr>', 'edit i3 config' },
      n = { ':vsplit ~/.config/nvim/init.lua<cr>', 'edit nvim config' },
      t = { ':vsplit ~/.config/tmux/tmux.conf<cr>', 'edit tmux config' },
      z = { ':vsplit ~/.config/zsh/.zshrc<cr>', 'edit zsh config' },
    },
    f = {
      name = 'find',
      c = {
        function()
          require('telescope.builtin').commands(require('telescope.themes').get_dropdown({
            previewer = false,
          }))
        end,
        'find commands',
      },
      f = { function() require('telescope.builtin').find_files({ hidden = true }) end, 'find file' },
      g = { require('telescope.builtin').live_grep, 'find string' },
      h = { require('telescope.builtin').help_tags, 'find help' },
      r = { require('telescope.builtin').oldfiles, 'recently used files' },
    },
    g = {
      name = 'gitsigns',
      j = { require('gitsigns').next_hunk, 'Next Hunk' },
      k = { require('gitsigns').prev_hunk, 'Prev Hunk' },
      b = { require('gitsigns').blame_line, 'Blame' },
      p = { require('gitsigns').preview_hunk, 'Preview Hunk' },
      r = { require('gitsigns').reset_hunk, 'Reset Hunk' },
      R = { require('gitsigns').reset_buffer, 'Reset Buffer' },
    },
    h = { '<c-w>h', 'move left' },
    j = { '<c-w>j', 'move down' },
    k = { '<c-w>k', 'move up' },
    l = { '<c-w>l', 'move right' },
    n = { '<c-w>=', 'normalize windows' },
    o = { '<c-w>v', 'split pane vertically' },
    r = { vim.lsp.buf.rename, 'rename token' },
    p = { ':set paste!<cr>', 'toggle paste mode' },
    s = {
      w = { function() require('spectre').open_visual({ select_word = true }) end, 'search current word' },
    },
    S = { require('spectre').toggle, 'toggle spectre' },
    t = {
      name = 'trees and lists',
      d = { vim.diagnostic.setloclist, 'open diagnostics list' },
      f = { ':NvimTreeFocus<cr>', 'open file tree' },
      l = { ':noautocmd bufdo vimgrepadd /TODO/j % | copen<cr>', 'open TODO list' },
      r = { vim.lsp.buf.references, 'open references list' },
      u = { function() require('undotree').toggle({ async = true }) end, 'open undo tree' },
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
    ['='] = { ':Format<cr>', 'format file' },
  },
  g = {
    name = 'goto',
    d = { vim.lsp.buf.definition, 'definition' },
    i = { vim.lsp.buf.implementation, 'implementation' },
    r = { require('telescope.builtin').lsp_references, 'references' },
    x = { ':sil !xdg-open <c-r><c-a><cr>', 'open link' },
  },
  H = { ':bprev<cr>', 'focus previous buffer' },
  ['<c-j>'] = { ':m +1<cr>', 'move line up' },
  K = { vim.lsp.buf.hover, 'open hover menu' },
  ['<c-k>'] = { ':m -2<cr>', 'move line down' },
  L = { ':bnext<cr>', 'focus next buffer' },
  ['<c-w>'] = {
    name = 'which_key_ignore',
    h = { '<nop>', 'which_key_ignore' },
    j = { '<nop>', 'which_key_ignore' },
    k = { '<nop>', 'which_key_ignore' },
    l = { '<nop>', 'which_key_ignore' },
    s = { '<nop>', 'which_key_ignore' },
    v = { '<nop>', 'which_key_ignore' },
    ['='] = { '<nop>', 'which_key_ignore' },
  },
  U = { '<c-r>', 'redo' },
  Y = { 'y$', 'which_key_ignore' },
  z = {
    name = 'folding',
    c = { 'close fold under cursor' },
    C = { 'close all folds under cursor' },
    M = { require('ufo').closeAllFolds, 'close all folds' },
    o = { 'open fold under cursor' },
    O = { 'open all folds under cursor' },
    R = { require('ufo').openAllFolds, 'open all folds' },
  },
  ['<esc>'] = { ':noh<cr>:echo<cr>', 'clear highlight and message' },
  ['['] = {
    name = 'next item in category',
    d = { ':lua vim.diagnostic.goto_next({})', 'next diagnostic' },
    e = { ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})', 'next error' },
    w = { ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})', 'next warning' },
  },
  [']'] = {
    name = 'prev item in category',
    d = { ':lua vim.diagnostic.goto_prev({})', 'prev diagnostic' },
    e = { ':lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})', 'prev error' },
    w = { ':lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})', 'prev warning' },
  },
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
  s = {
    w = { '<esc>:lua require("spectre").open_visual()<cr>' },
  },
  ['<c-j>'] = { ":m '>+1<cr>gv=gv", 'move line down' },
  ['<c-k>'] = { ":m '<-2<cr>gv=gv", 'move line up' },
  ['<'] = { '<gv', 'which_key_ignore' },
  ['>'] = { '>gv', 'which_key_ignore' },
}

local select_mappings = {
  p = { 'p', 'fix select mode' },
  a = { 'a', 'fix select mode' },
  g = { 'g', 'fix select mode' },
}

wk.register(normal_mappings)
wk.register(global_mappings, { mode = '' })
wk.register(insert_mappings, { mode = 'i' })
wk.register(visual_mappings, { mode = 'v' })
wk.register(select_mappings, { mode = 's' })
