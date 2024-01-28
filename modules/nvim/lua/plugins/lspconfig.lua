local lspconfig = require('lspconfig')

local servers = {
    -- "rust_analyzer",
}


local diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = 'E' },
        { name = "DiagnosticSignWarn", text = 'W' },
        { name = "DiagnosticSignHint", text = 'H' },
        { name = "DiagnosticSignInfo", text = 'I' },
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
}

vim.diagnostic.config(diagnostic_config)

for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
require("lspconfig.ui.windows").default_options.border = "rounded"


local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local bmap = vim.api.nvim_buf_set_keymap
  local map = vim.keymap.set

  bmap(bufnr, "n", "gd", "<cmd>FzfLua lsp_definitions<cr>", opts)
  bmap(bufnr, "n", "gD", "<cmd>FzfLua lsp_declarations<cr>", opts)
  bmap(bufnr, "n", "gt", "<cmd>FzfLua lsp_typedefs<cr>", opts)
  bmap(bufnr, "n", "gr", "<cmd>FzfLua lsp_references<cr>", opts)
  bmap(bufnr, "n", "gi", "<cmd>FzfLua lsp_implementations<cr>", opts)
  bmap(bufnr, 'n', '<leader>si', '<cmd>FzfLua lsp_document_symbols<cr>', opts)
  bmap(bufnr, 'n', '<leader>sI', '<cmd>FzfLua lsp_workspace_symbols<cr>', opts)
  bmap(bufnr, 'n', '<C-c>', '<cmd>FzfLua lsp_code_actions<cr>', opts)
  bmap(bufnr, 'n', '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', opts)
  bmap(bufnr, 'n', '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', opts)

  bmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
  bmap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  bmap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
  bmap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  bmap(bufnr, "n", "<leader>lr", "<cmd>LspRestart<cr>", opts)
  bmap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
  bmap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
  bmap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

  map("n", "<leader>lf", function()
    require('conform').format({ bufnr = bufnr, lsp_fallback = true })
  end, opts)
end


local function on_attach(client, bufnr)
  lsp_keymaps(bufnr)
end


local function capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end


local server_opts = { on_attach = on_attach, capabilities = capabilities() }

require('neodev').setup({})

-- Server setups
lspconfig.rust_analyzer.setup(server_opts)
