return {
  "williamboman/mason-lspconfig.nvim",
  event = { "VeryLazy", "BufReadPre" },
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "mason-org/mason.nvim" },
    { "j-hui/fidget.nvim" },
  },
  config = function()
    local utils = require("core.utils")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local blink_ok, blink = pcall(require, "blink.cmp")

    if blink_ok then
      capabilities = blink.get_lsp_capabilities(capabilities, true)
    end

    -- all servers will have the same default capabilities
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- diagnostic configuration
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        severity = {
          min = vim.diagnostic.severity.HINT,
        },
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "", -- index:0
          [vim.diagnostic.severity.WARN] = "", -- index:1
          [vim.diagnostic.severity.INFO] = "", -- index:2
          [vim.diagnostic.severity.HINT] = "󰌵", -- index:3
        },
      },
      severity_sort = true,
      float = {
        show_header = false,
        source = "if_many",
        border = "rounded",
      },
    })

    vim.lsp.inlay_hint.enable(false)

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
      callback = function(args)
        local bufnr = args.buf
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "K", vim.lsp.buf.hover, "hover docs [LSP]")
        map("n", "gn", vim.lsp.buf.rename, "rename symbol [LSP]")
        -- map("n", "<leader>rn", vim.lsp.buf.rename, "rename symbol [LSP]")

        vim.keymap.set("n", "<leader>k", function()
          vim.diagnostic.jump({ count = -1 })
        end, { desc = "[diag] previous" })

        vim.keymap.set("n", "<leader>j", function()
          vim.diagnostic.jump({ count = 1 })
        end, { desc = "[diag] next" })
      end,
    })

    -- icons configuration
    for kind, symbol in pairs(utils.icons) do
      local kinds = vim.lsp.protocol.CompletionItemKind
      local index = kinds[kind]

      if index ~= nil then
        kinds[index] = symbol
      end
    end

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        -- "clangd",
        "zls",
        -- "basedpyright",
        "lua_ls",
        -- "ruff",
        "rust_analyzer",
        "cssls",
        "emmet_language_server",
        "eslint",
        "html",
        "jsonls",
        "tailwindcss",
        "vue_ls",
        "vtsls",
        -- "stylua",
        "biome",
      },
      automatic_enable = true,
    })

    local map = vim.keymap.set
    -- keymaps
    map("n", "gl", function()
      vim.diagnostic.open_float({ buffer = 0, scope = "line", border = "rounded" })
    end, { desc = "show line diagnostic [LSP]" })

    map("n", "<leader>dd", function()
      local enabled = true
      local ok, state = pcall(vim.diagnostic.is_enabled)
      if ok then
        enabled = state
      end

      vim.diagnostic.enable(not enabled)
      vim.notify(string.format("Diagnostics %s", not enabled and "ON" or "OFF"))
    end, { desc = "toggle diagnostics [LSP]" })

    map("n", "<leader>li", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local supports_inlay_hints = #vim.lsp.get_clients({
        bufnr = bufnr,
        method = "textDocument/inlayHint",
      }) > 0

      if not supports_inlay_hints then
        vim.notify("inlay hints are not supported for this buffer", vim.log.levels.WARN)
        return
      end

      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, { desc = "toggle inlay hints [LSP]" })
  end,
}
