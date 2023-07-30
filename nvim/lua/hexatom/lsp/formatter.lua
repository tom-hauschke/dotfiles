local formatter_status_ok, formatter = pcall(require, 'formatter')
if not formatter_status_ok then return end

-- Utilities for creating configurations
local util = require('formatter.util')

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    json = {
      require('formatter.filetypes.json').jq,
      function()
        return {
          exe = 'jq',
          args = { '.' },
          stdin = true,
        }
      end,
    },
    markdown = {
      require('formatter.filetypes.markdown').prettier,
    },
    lua = {
      require('formatter.filetypes.lua').stylua,
      function()
        return {
          exe = 'stylua',
          args = {
            '--search-parent-directories',
            '--stdin-filepath',
            util.escape_path(util.get_current_buffer_file_path()),
            '--config-path',
            '~/.config/nvim/lua/hexatom/lsp/configs/stylua.toml',
            '--',
            '-',
          },
          stdin = true,
        }
      end,
    },
    sh = {
      require('formatter.filetypes.sh').shfmt,
      function()
        local shiftwidth = vim.opt.shiftwidth:get()
        local expandtab = vim.opt.expandtab:get()

        if not expandtab then shiftwidth = 0 end

        return {
          exe = 'shfmt',
          args = { '-i', shiftwidth },
          stdin = true,
        }
      end,
    },
    terraform = {
      require('formatter.filetypes.terraform').terraformfmt,
      function()
        return {
          exe = 'terraform',
          args = { 'fmt', '-' },
          stdin = true,
        }
      end,
    },
    yaml = {
      require('formatter.filetypes.yaml').yamlfmt,
      function()
        return {
          exe = 'yamlfmt',
          args = { '-in', '-conf', '~/.config/nvim/lua/hexatom/lsp/configs/yamlfmt.yaml' },
          stdin = true,
        }
      end,
    },
    ['*'] = {
      require('formatter.filetypes.any').remove_trailing_whitespace,
    },
  },
})
