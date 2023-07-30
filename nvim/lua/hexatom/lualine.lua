local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then return end

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = ' ', warn = ' ' },
}

local filename = {
  'filename',
  file_status = false,
  path = 1,
  shorting_target = 20,
}

local branch = {
  'branch',
  icon = '',
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local max_lines = function() return vim.fn.line('$') end

lualine.setup({
  options = {
    theme = 'dracula',
    component_separators = { left = '', right = '' },
    --[[ section_separators = { left = '', right = '' }, ]]
    disabled_filetypes = { 'dashboard', 'NvimTree', 'Outline' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { diagnostics, branch },
    lualine_c = { filename },
    lualine_x = { 'filetype', 'encoding', 'fileformat' },
    lualine_y = { 'location', progress, max_lines },
    lualine_z = {},
  },
  extensions = { 'mundo', 'nvim-tree', 'quickfix', 'toggleterm' },
})
