local status_ok, lint = pcall(require, 'lint')
if not status_ok then return end

lint.linters_by_ft = {
  ansible = { 'ansible_lint' },
  dockerfile = { 'hadolint' },
  go = { 'golangcilint' },
  helm = {},
  json = { 'jsonlint' },
  lua = { 'luacheck' },
  md = { 'markdownlint' },
  sh = { 'shellcheck' },
  sql = { 'sqlfluff' },
  terraform = {
    'tflint',
    'tfsec',
  },
  yaml = { 'yamllint' },
}

-- configuration for standard linters
lint.linters.luacheck.args = {
  '--config',
  '~/.config/nvim/lua/hexatom/lsp/configs/luacheckrc',
}
lint.linters.yamllint.args = {
  '-c',
  '~/.config/nvim/lua/hexatom/lsp/configs/yamllint.yaml',
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    lint.try_lint()
    lint.try_lint({
      'proselint',
      'woke',
    })
  end,
})
