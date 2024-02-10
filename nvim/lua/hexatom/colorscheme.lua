local status_ok, dracula = pcall(require, 'dracula')
if not status_ok then return end

dracula.setup({
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = true, -- default false
  -- set italic comment
  italic_comment = true, -- default false
})

vim.cmd([[colorscheme dracula]])

local highlight = function(group, fg, bg, attr, sp)
  fg = fg and 'guifg=' .. fg or 'guifg=NONE'
  bg = bg and 'guibg=' .. bg or 'guibg=NONE'
  attr = attr and 'gui=' .. attr or 'gui=NONE'
  sp = sp and 'guisp=' .. sp or ''

  vim.api.nvim_command('highlight ' .. group .. ' ' .. fg .. ' ' .. bg .. ' ' .. attr .. ' ' .. sp)
end

highlight('SpellBad', '#FF6E6E', nil, 'bold,underline', nil)
highlight('DiagnosticUnderlineError', '#FF6E6E', nil, 'bold,underline', nil)
highlight('DiagnosticUnderlineWarn', '#F1FA8C', nil, 'bold,underline', nil)
highlight('DiagnosticUnderlineInfo', '#8BE9FD', nil, 'bold,underline', nil)
highlight('DiagnosticUnderlineHint', '#8BE9FD', nil, 'bold,underline', nil)
highlight('LspDiagnosticUnderlineError', '#FF6E6E', nil, 'bold,underline', nil)
highlight('LspDiagnosticUnderlineWarn', '#F1FA8C', nil, 'bold,underline', nil)
highlight('LspDiagnosticUnderlineInfo', '#8BE9FD', nil, 'bold,underline', nil)
highlight('LspDiagnosticUnderlineHint', '#8BE9FD', nil, 'bold,underline', nil)
highlight('DiffChange', '#FF6E6E', nil, nil, nil)
highlight('DiffText', '#FF6E6E', nil, 'bold,italic', nil)
