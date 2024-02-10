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
  extensions = {
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'pdf' },
      find_cmd = 'fd',
    },
  },
})
