return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = {
      parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
      install_dir = vim.fn.stdpath("data") .. "/treesitter",
      ensure_installed = {
        "c",
        "cpp",
        "css",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "scss",
        "typescript",
        "tsx",
        "vue",
        "go",
        "python",
        "rust",
      },
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- Guard against parser/highlight cost on very large files.
        disable = function(_, bufnr)
          local max_filesize = 200 * 1024 -- 200 KB
          local uv = vim.uv or vim.loop
          local ok, stats = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
          return ok and stats and stats.size and stats.size > max_filesize
        end,
      },
    },
    config = function(_, opts)
      if opts.parser_install_dir and opts.parser_install_dir ~= "" then
        vim.fn.mkdir(opts.parser_install_dir, "p")
        vim.opt.runtimepath:append(opts.parser_install_dir)
      end

      local ok_configs, configs = pcall(require, "nvim-treesitter.configs")
      if ok_configs then
        configs.setup(opts)
        return
      end

      -- Compatibility path for the rewritten nvim-treesitter API.
      local ok_ts, ts = pcall(require, "nvim-treesitter")
      if not ok_ts then
        return
      end

      ts.setup({
        install_dir = opts.install_dir,
      })

      local langs = opts.ensure_installed or {}
      if type(langs) == "table" and #langs > 0 then
        if type(ts.get_available) == "function" then
          local available = {}
          for _, lang in ipairs(ts.get_available()) do
            available[lang] = true
          end
          langs = vim.tbl_filter(function(lang)
            return available[lang] == true
          end, langs)
        end

        pcall(function()
          ts.install(langs)
        end)
      end

      if opts.highlight and opts.highlight.enable then
        local group = vim.api.nvim_create_augroup("rami-treesitter-highlight", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
          group = group,
          callback = function(args)
            local disable = opts.highlight.disable
            if type(disable) == "function" and disable(args.match, args.buf) then
              return
            end
            pcall(vim.treesitter.start, args.buf)
          end,
        })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 1,
    },
  },
}
