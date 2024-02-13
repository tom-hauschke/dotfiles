local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then return end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status_ok then return end

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then return end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status_ok then return end

local status_ok, lspl = pcall(require, 'lsp_lines')
if not status_ok then return end

lspl.setup()

mason.setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '',
      package_uninstalled = '✗',
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    'lua_ls',
    'jsonls',
    'yamlls',
    'bashls',
    'helm_ls',
    'tflint',
    'terraformls',
    'gopls',
    'ansiblels',
    'azure_pipelines_ls',
    'dockerls',
  },
})

-- Default handlers for LSP
local default_handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

-- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
local servers = {
  ansiblels = {},
  azure_pipelines_ls = {},
  bashls = {},
  dockerls = {},
  gopls = {},
  helm_ls = {
    ['helm_ls'] = {
      yamlls = {
        path = 'yaml-language-server',
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lua_ls = {
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
  },
  terraformls = {},
  tflint = {},
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local default_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Iterate over our servers and set them up
for name, config in pairs(servers) do
  lspconfig[name].setup({
    capabilities = default_capabilities,
    filetypes = config.filetypes,
    handlers = vim.tbl_deep_extend('force', {}, default_handlers, config.handlers or {}),
    settings = config.settings,
  })
end

-- Configure borderd for LspInfo ui
require('lspconfig.ui.windows').default_options.border = 'rounded'

-- Configure diagostics border
vim.diagnostic.config({
  float = {
    border = 'rounded',
  },
  virtual_text = false,
  virtual_lines = {
    only_current_line = true,
  },
})
