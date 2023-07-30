local status_ok, undotree = pcall(require, 'undotree')
if not status_ok then return end

undotree.setup({
  ignore_filetype = { 'UndoTree', 'UndoTreeDiff', 'TelescopePrompt', 'tsplayground', 'NvimTree', 'qf' },
})
