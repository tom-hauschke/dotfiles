local nvim_lint_status_ok, nvim_lint = pcall(require, 'nvim-lint')
if not nvim_lint_status_ok then return end

nvim_lint.linters_by_ft = {
  sh = { 'shellcheck' },
  lua = { 'luacheck' },
  json = { 'jsonlint' },
  md = { 'markdownlint' },
  yaml = { 'yamllint' },
  ansible = { 'ansible_lint' },
  terraform = { 'tflint' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function() require('lint').try_lint() end,
})
