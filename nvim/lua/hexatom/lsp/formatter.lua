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
    go = {
      function()
        return {
          exe = 'golines',
          args = {
            '--base-formatter',
            'goimports',
            '--chain-split-dots',
            '-m',
            '120',
            '-t',
            '2',
          },
          stdin = true,
        }
      end,
    },
    json = {
      require('formatter.filetypes.json').jq,
    },
    lua = {
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
    markdown = {
      require('formatter.filetypes.markdown').prettier,
    },
    sh = {
      require('formatter.filetypes.sh').shfmt,
    },
    terraform = {
      require('formatter.filetypes.terraform').terraformfmt,
    },
    yaml = {
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
