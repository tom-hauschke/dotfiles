local comment_ok, comment = pcall(require, 'Comment')
if not comment_ok then return end

local commentstring_ok, ts_cs = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
if not commentstring_ok then return end

comment.setup({
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = {
    line = '<leader>cl',
    block = '<leader>cb',
  },
  opleader = {
    line = '<leader>cl',
    block = '<leader>cb',
  },
  extra = {
    above = '<leader>cu',
    below = '<leader>cd',
    eol = '<leader>ce',
  },
  mappings = {
    basic = true,
    extra = true,
  },
  pre_hook = ts_cs.create_pre_hook(),
  post_hook = nil,
})
