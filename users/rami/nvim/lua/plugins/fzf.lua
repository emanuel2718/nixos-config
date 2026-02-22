return {
  "ibhagwan/fzf-lua",
  cmd = "Fzf",
  config = function()
    local fzf = require('fzf-lua')
    local opts = {
      { "max-perf" },
      ui_select = true,
      --  defaults = { formatter = { "path.dirname_first", v = 2 } },
      files = { fzf_opts = { ["--tiebreak"] = "end", ["--ansi"] = true } },
      grep = {
        rg_glob = true,
        glob_separator = "%s%s+",
      },
      zoxide = {
        actions = {
          enter = function(selected, opts)
            -- automatically open a file search...we did this manually everytime so automating it
            require("fzf-lua.actions").zoxide_cd(selected, opts)
            vim.schedule(function()
              require("fzf-lua").files({ cwd = vim.uv.cwd() })
            end)
          end,
        },
      },
      lsp = {
        finder = {
          { "ivy", "hide" },
          providers = {
            { "definitions",     prefix = fzf.utils.ansi_codes.green("def ") },
            { "declarations",    prefix = fzf.utils.ansi_codes.magenta("decl") },
            { "implementations", prefix = fzf.utils.ansi_codes.green("impl") },
            { "typedefs",        prefix = fzf.utils.ansi_codes.red("tdef") },
            { "references",      prefix = fzf.utils.ansi_codes.blue("ref ") },
            { "incoming_calls",  prefix = fzf.utils.ansi_codes.cyan("in  ") },
            { "outgoing_calls",  prefix = fzf.utils.ansi_codes.yellow("out ") },
            { "type_sub",        prefix = fzf.utils.ansi_codes.cyan("sub ") },
            { "type_super",      prefix = fzf.utils.ansi_codes.yellow("supr") },
          },
        },
        document_symbols = { { "ivy", "hide" }, path_shorten = 1, },
        workspace_symbols = { path_shorten = 1, },
        code_actions = {
          { "border-fused" },
          winopts = {
            relative = "cursor",
            row = 1,
            col = 0,
            height = 0.4,
            preview = { vertical = "down:70%" },
          },
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          preview_pager = "delta --width=$COLUMNS --hunk-header-style=omit --file-style=omit",
        },
      },
    }
    fzf.setup(opts)
  end,
  keys = {
    ---@format disable
      -- file search
      { "<leader>ff", function() require('fzf-lua').files() end, desc = "Find Files" },
      -- NOTE: we use `fff.nvim` for finding files now
      { "<leader>.", function() require('fzf-lua').files({ hidden = true }) end, desc = "Find Files (ALL)" },
      { "<leader>b.", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>r.", function() require("fzf-lua").resume() end, desc = "Resume" },
      { "<leader>r/", function() require("fzf-lua").search_history() end, desc = "Command History" },
      { "<leader>fo", function() require("fzf-lua").oldfiles({ include_current_session = true }) end, desc = "Oldfiles (All)" },
      { "<leader>fO", function() require("fzf-lua").oldfiles({ cwd = vim.uv.cwd(), cwd_header = true, cwd_only = true, include_current_session = true }) end, desc = "Oldfiles (cwd)" },

      { "<leader>s?", function() require("fzf-lua").builtin() end, desc = "FzfLua Builtins", mode = { "n", "v" } },
      { "<leader>sh", function() require("fzf-lua").helptags() end, desc = "Help Tags" },
      { "<leader>hh", function() require("fzf-lua").helptags() end, desc = "Help Tags" }, -- old habits
      { "<leader>sk", function() require("fzf-lua").keymaps() end, desc = "Keymaps" },
      { "<leader>ht", function() require("fzf-lua").colorschemes({ winopts = { height = 0.45, width = 0.30 } }) end, desc = "Colorschemes" },
      { "<leader>z", function() require("fzf-lua").zoxide() end, desc = "Zoxide" },

      -- git
      { "<leader>g.", function() require("fzf-lua").git_blame() end, desc = "Git Blame", mode = { "n", "v" } },
      { "<leader>gB", function() require("fzf-lua").git_branches() end, desc = "Git Branches", },
      { "<leader>gc", function() require("fzf-lua").git_bcommits() end, desc = "Git File Changes History", mode = { "n", "v" } },
      { "<leader>gl", function() require("fzf-lua").git_commits() end, desc = "Git Log" },
      { "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git Status" },
      { "<leader>gh", function() require("fzf-lua").git_hunks({ path_shorten = true }) end, desc = "Git Diff (hunks)" },
      { "<leader>gt", function() require("fzf-lua").git_tags() end, desc = "Git Tags" },

      -- Grep
      { "<leader>sp", function()
        if vim.fn.executable("git") ~= 1 then
          require("fzf-lua").live_grep()
          return
        end

        local inside_worktree = vim.trim(vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })) == "true"
        if vim.v.shell_error ~= 0 or not inside_worktree then
          require("fzf-lua").live_grep()
          return
        end

        local tracked_files = vim.fn.systemlist({ "git", "-c", "core.quotepath=off", "ls-files" })
        if vim.v.shell_error ~= 0 or #tracked_files == 0 then
          vim.notify("No tracked files found in current git repo", vim.log.levels.WARN)
          return
        end

        require("fzf-lua").live_grep({
          search_paths = tracked_files,
        })
      end, desc = "Grep (tracked files)" },
      { "<leader>sP", function() require("fzf-lua").live_grep({ hidden = true, no_ignore = true }) end, desc = "Grep (all hidden + ignored)" },
      { "<leader>s/", function() require("fzf-lua").blines() end, desc = "Buffer Lines", mode = { "n", "v" } },
      { "<leader>s.", function() require("fzf-lua").grep_cword() end, desc = "Grep word", mode = { "n" } },
      { "<leader>s.", function() require("fzf-lua").grep_visual() end, desc = "Grep Visual selection", mode = "v" },

      -- lsp
      { "gd", function() require("fzf-lua").lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() require("fzf-lua").lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() require("fzf-lua").lsp_references() end, nowait = true, desc = "References" },
      { "gi", function() require("fzf-lua").lsp_implementations() end, desc = "Goto Implementation" },
      { "gt", function() require("fzf-lua").lsp_typedefs() end, desc = "Goto T[y]pe Definition" },
      { "<C-c>", function() require("fzf-lua").lsp_code_actions() end, desc = "Code Actions" },
      { "<leader>ll", function() require("fzf-lua").lsp_document_symbols() end, desc = "LSP Symbols (buffer)" },
      { "<leader>lL", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "LSP Symbols (workspace)" },
      { "<leader>ld", function() require("fzf-lua").diagnostics_document() end, desc = "Buffer Diagnostics" },
      { "<leader>lD", function() require("fzf-lua").diagnostics_workspace() end, desc = "Workspace Diagnostics" },
      { "<leader>lt", function() require("fzf-lua").treesitter() end, desc = "Treesitter" },
  }
}
