local status_ok, wilder = pcall(require, 'wilder')
if not status_ok then return end

-- Enable wilder when pressing :, / or ?
wilder.setup({ modes = { ':', '/', '?' } })

-- Enable fuzzy matching for commands and buffers
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
    }),
    wilder.vim_search_pipeline({
      fuzzy = 1,
    })
  ),
})

wilder.set_option(
  'renderer',
  wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    highlighter = wilder.basic_highlighter(),
    pumblend = 5,
    min_width = '100%',
    min_height = '25%',
    max_height = '25%',
    border = 'rounded',
    left = { ' ', wilder.popupmenu_devicons() },
    right = { ' ', wilder.popupmenu_scrollbar() },
  }))
)
