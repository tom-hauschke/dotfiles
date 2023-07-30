local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then return end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then return end

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local kind_icons = {
  Text = '󰦨',
  Method = 'm',
  Function = '󰊕',
  Constructor = '',
  Field = '',
  Variable = '󰫧',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<c-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<esc>'] = cmp.mapping.abort(),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<cr>'] = cmp.mapping.confirm({ select = false }),
    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
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
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[LUA]',
        luasnip = '[SNIPPET]',
        buffer = '[FILE]',
        path = '[PATH]',
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'path' },
  }),
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
  },
  experimental = {
    ghost_text = true,
  },
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  view = {
    entries = { name = 'wildmenu', separator = '|' },
  },
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  view = {
    entries = { name = 'wildmenu', separator = '|' },
  },
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
