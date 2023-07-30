local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then return end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status_ok then return end

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then return end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status_ok then return end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = { 'lua_ls', 'jsonls', 'yamlls', 'bashls', 'helm_ls', 'tflint' },
})

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.jsonls.setup({
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})
lspconfig.bashls.setup({})
lspconfig.helm_ls.setup({})
lspconfig.tflint.setup({})
