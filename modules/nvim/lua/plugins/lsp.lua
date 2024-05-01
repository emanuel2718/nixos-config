local map = vim.keymap.set
local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
  return
end

require("neodev").setup {}

local ts_util = require "nvim-lsp-ts-utils"

local custom_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  if client.name == 'copilot' then
    return
  end

  map('i', '<C-k>', vim.lsp.buf.signature_help, opts)
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map('n', 'gi', '<cmd>FzfLua lsp_implementations<cr>', opts)
  map('n', 'gh', '<cmd>FzfLua lsp_references<cr>', opts)
  map('n', '<C-c>', '<cmd>FzfLua lsp_code_actions<cr>', opts)
  map('n', '<leader>si', '<cmd>FzfLua lsp_document_symbols<cr>', opts)
  map('n', '<leader>di', '<cmd>FzfLua lsp_document_diagnostics<cr>', opts)
  map('n', 'gT', vim.lsp.buf.type_definition, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', 'gl', function() vim.diagnostic.open_float {} end, opts)
  map('n', '<leader>lr', '<cmd>LspRestart<cr>', opts)
  map('n', '<leader>li', '<cmd>LspInfo<cr>', opts)
  map('n', "<leader>lf", function()
    require('conform').format({ bufnr = bufnr, lsp_fallback = true })
  end, opts)
  map("n", "<leader>j", function()
      vim.diagnostic.goto_next { float = false }
  end)
  map("n", "<leader>k", function()
      vim.diagnostic.goto_prev { float = false }
  end)
end



local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

capabilities.textDocument.codeLens = { dynamicRegistration = false }


local servers = {
  bashls = true,
  rust_analyzer = true,
  html = true,
  yamlls = true,
  tailwindcss = true,
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
    },
  },
  pyright = true,
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
    init_options = {
      clangdFileStatus = true,
    },
    filetypes = {
      "c",
    },
  },
  tsserver = {
    init_options = ts_util.init_options,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },

    on_attach = function(client)
      custom_attach(client)
      ts_util.setup { auto_inlay_hints = false }
      ts_util.setup_client(client)
    end,
  },
  volar = {
    filetypes = { "vue" },
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  }

}


local setup_servers = function(server, config)
  if not config then
    return
  end

  if type(config) ~= 'table' then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_attach = custom_attach,
    capabilities = capabilities,
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_servers(server, config)
end
