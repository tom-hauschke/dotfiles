local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then return end

local lspkind_status_ok, lspkind = pcall(require, 'lspkind')
if not lspkind_status_ok then return end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then return end

local ap_status_ok, npairs = pcall(require, 'nvim-autopairs')
if not ap_status_ok then return end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false, -- change that
  },
  disable_filetype = { 'TelescopePrompt' },
  fast_wrap = false,
  map_bs = false,
})

cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done({ map_char = { tex = '' } }))

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<c-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<esc>'] = cmp.mapping.abort(),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<s-tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  formatting = {
    expandable_indicator = true,
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        path = '[PATH]',
      },
      maxwidth = 50,
      ellipsis_char = '...',
      symbol_map = {
        Copilot = '',
      },
    }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer', max_item_count = 5 },
    { name = 'path', max_item_count = 3 },
    { name = 'luasnip', max_item_count = 3 },
  }),
  experimental = {
    ghost_text = true,
  },
})

luasnip.setup({
  enable_autosnippets = true,
  ft_func = require('luasnip.extras.filetype_functions').from_cursor,
})

-- Umlaute snippets
luasnip.add_snippets('all', {
  s('oe', {
    t('ö'),
  }),
  s('ae', {
    t('ä'),
  }),
  s('ue', {
    t('ü'),
  }),
  s('sz', {
    t('ß'),
  }),
}, {
  type = 'autosnippets',
  key = 'all_auto',
})

-- Go snippets
luasnip.add_snippets('go', {
  s('iferr', {
    t({ 'if err != nil {', '\t' }),
    i(0),
    t({ '\t', '}' }),
  }),
}, {
  key = 'go',
})
