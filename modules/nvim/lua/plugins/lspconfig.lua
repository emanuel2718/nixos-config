local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local telescope_builtin = require('telescope.builtin')
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('rami-lsp-attach', { clear = true }),
  callback = function(event)
    local bufnr = event.buf
    local opts = vim.tbl_extend('force', { noremap = true, silent = true }, { buffer = event.buf })
    map('n', 'gd', telescope_builtin.lsp_definitions, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', telescope_builtin.lsp_references, opts)
    map('n', 'gi', telescope_builtin.lsp_implementations, opts)
    map('n', 'gt', telescope_builtin.lsp_type_definitions, opts)
    map('n', '<leader>si', telescope_builtin.lsp_document_symbols, opts)
    map('n', '<leader>sI', telescope_builtin.lsp_dynamic_workspace_symbols, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gl', function() vim.diagnostic.open_float {} end, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    map('n', '<leader>li', '<cmd>LspInfo<cr>', opts)
    map('n', '<leader>lr', '<cmd>LspRestart<cr>', opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    map('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    map('n', '<C-c>', function()
      vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
    end)
    map('n', "<leader>lf", function()
      require('conform').format({ bufnr = bufnr, lsp_fallback = true })
    end, opts)


    --[[ vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      callback = vim.lsp.buf.clear_references,
    }) ]]
  end
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


local lspconfig = require('lspconfig')


-- Vue/TS/JS/JSON
lspconfig.volar.setup {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  capabilities = capabilities,
}

-- Rust
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}

-- C++
lspconfig.clangd.setup {
  capabilities = capabilities,
}

-- Python
lspconfig.pyright.setup {
  capabilities = capabilities,
}

-- Nix
lspconfig.rnix.setup {
  capabilities = capabilities,
}

-- Tailwindcss
lspconfig.tailwindcss.setup {
  capabilities = capabilities,
}

-- Lua
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      diagnostics = {
        globals = { "vim", "PLUG" },
      },
      runtime = {
        version = "LuaJIT",
        special = {
          PLUG = "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      hint = {
        enable = false,
        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
        await = true,
        paramName = "Disable",  -- "All" | "Literal" | "Disable"
        paramType = true,
        semicolon = "All",      -- "All" | "SameLine" | "Disable"
        setType = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

require('neodev').setup {}
