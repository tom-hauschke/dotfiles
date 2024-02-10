local status_ok, lspl = pcall(require, 'lsp_lines')
if not status_ok then return end

lspl.setup()

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    only_current_line = true,
  },
})
