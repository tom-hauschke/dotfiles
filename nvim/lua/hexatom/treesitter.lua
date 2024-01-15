local treesitter_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not treesitter_ok then return end

configs.setup({
  ensure_installed = 'all',
  auto_install = true,
  sync_install = true,
  modules = {},
  ignore_install = {},
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { 'help' },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = {} },
  rainbow = {
    enable = true,
    disable = {},
    extended_mode = true,
    max_file_lines = nil,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
})
