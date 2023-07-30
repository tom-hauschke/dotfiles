local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then return end

telescope.load_extension('media_files')

local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    path_display = { 'smart' },

    mappings = {
      i = {
        ['<c-n>'] = actions.cycle_history_next,
        ['<c-p>'] = actions.cycle_history_prev,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,

        ['<c-c>'] = actions.close,

        ['<cr>'] = actions.select_default,

        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,

        ['<c-?>'] = actions.which_key,
      },

      n = {
        ['q'] = actions.close,
        ['<cr>'] = actions.select_default,

        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,

        ['gg'] = actions.move_to_top,
        ['G'] = actions.move_to_bottom,

        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,

        ['?'] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {'png', 'jpg', 'mp4', 'webm', 'pdf'}
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
      find_cmd = 'rg', -- find command (defaults to `fd`)
    },
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
})
