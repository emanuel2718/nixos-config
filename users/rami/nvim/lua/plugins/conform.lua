return {
  "stevearc/conform.nvim",
  config = function()
    if vim.g.disable_autoformat == nil then
      vim.g.disable_autoformat = false
    end

    local function toggle_autoformat_global()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify(string.format("Autoformat %s", vim.g.disable_autoformat and "OFF" or "ON"))
    end

    local function toggle_autoformat_buffer()
      vim.b.disable_autoformat = not vim.b.disable_autoformat
      vim.notify(string.format("Buffer autoformat %s", vim.b.disable_autoformat and "OFF" or "ON"))
    end

    vim.keymap.set("n", "<leader>f.", toggle_autoformat_global, { desc = "Toggle autoformat (global)" })
    vim.keymap.set("n", "<leader>fM", toggle_autoformat_buffer, { desc = "Toggle autoformat (buffer)" })

    vim.keymap.set("v", "fm", function()
      require("conform").format({
        async = false,
        timeout_ms = 1000,
        lsp_format = "fallback",
      })
    end, { desc = "Format range" })

    require("conform").setup({
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end

        return {
          timeout_ms = 1000,
        }
      end,
      notify_on_error = true,
      notify_no_formatters = true,
      formatters_by_ft = {
        ---@format disable
        lua = { "stylua" },
        python = { "ruff" },
        css = { "biome", "prettierd", stop_after_first = true },
        markdown = { "biome", "prettierd", stop_after_first = true },
        html = { "biome", "prettierd", stop_after_first = true },
        yaml = { "biome", "prettierd", stop_after_first = true },
        toml = { "biome", "prettierd", stop_after_first = true },
        json = { "biome", "prettierd", stop_after_first = true },
        jsonc = { "biome", "prettierd", stop_after_first = true },
        vue = { "biome", "prettierd", stop_after_first = true },
        typescript = { "biome", "prettierd", stop_after_first = true },
        javascript = { "biome", "prettierd", stop_after_first = true },
        javascriptreact = { "biome", "prettierd", stop_after_first = true },
        typescriptreact = { "biome", "prettierd", stop_after_first = true },
        nix = { "nixpkgs_fmt" },
      },
    })
  end,
}
