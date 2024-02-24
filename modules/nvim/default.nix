{ pkgs, lib, ... }:
let
  clone = repo: ref: sha:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "http://github.com/${repo}.git";
        ref = ref;
        rev = sha;
      };
    };

  # TODO: move this to a sperate file
  fromConfigFile = with pkgs; {
    telescope = {
      plugin = vimPlugins.telescope-nvim;
      config = builtins.readFile lua/plugins/telescope.lua;
      type = "lua";
    };
    comment = {
      plugin = vimPlugins.comment-nvim;
      config = builtins.readFile lua/plugins/comment.lua;
      type = "lua";
    };
    autopairs = {
      plugin = vimPlugins.nvim-autopairs;
      config = builtins.readFile lua/plugins/autopairs.lua;
      type = "lua";
    };
    fzfLua = {
      plugin = vimPlugins.fzf-lua;
      config = builtins.readFile lua/plugins/fzf.lua;
      type = "lua";
    };
    lspconfig = {
      plugin = vimPlugins.nvim-lspconfig;
      config = builtins.readFile lua/plugins/lspconfig.lua;
      type = "lua";
    };
    tailwindColorizer = {
      plugin = clone "roobert/tailwindcss-colorizer-cmp.nvim" "main"
        "bc25c56083939f274edcfe395c6ff7de23b67c50";
      type = "lua";
    };
    cmp = {
      plugin = vimPlugins.nvim-cmp;
      config = builtins.readFile lua/plugins/cmp.lua;
      type = "lua";
    };
    treesitter = {
      plugin = vimPlugins.nvim-treesitter;
      config = builtins.readFile lua/plugins/treesitter.lua;
      type = "lua";
    };
    oil = {
      plugin = vimPlugins.oil-nvim;
      config = builtins.readFile lua/plugins/oil.lua;
      type = "lua";
    };
    lualine = {
      plugin = vimPlugins.lualine-nvim;
      config = builtins.readFile lua/plugins/lualine.lua;
      type = "lua";
    };
    neogit = {
      plugin = vimPlugins.neogit;
      config = ''
        vim.keymap.set('n', '<leader>g.', '<cmd>Neogit<cr>', { noremap = true, silent = true })
        require('neogit').setup({
          integrations = { diffview = true, fzf_lua = true }
        })
      '';
      type = "lua";
    };
    neotree = {
      plugin = vimPlugins.neo-tree-nvim;
      config = builtins.readFile lua/plugins/neotree.lua;
      type = "lua";
    };
    fterm = {
      plugin = vimPlugins.FTerm-nvim;
      config = ''
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }
        require("FTerm").setup {
          border = "solid",
          blend = 10,
        }
        map('n', "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>', opts)
        map('t', "<C-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
      '';
      type = "lua";
    };
    trouble = {
      plugin = vimPlugins.trouble-nvim;
      config = ''
        local map = vim.keymap.set
        map("n", "<leader>d.", function() require("trouble").toggle("document_diagnostics") end, { noremap = true, silent = true }) 
      '';
      type = "lua";
    };
    mini = {
      plugin = vimPlugins.mini-nvim;
      config = ''
        require('mini.ai').setup { n_lines = 500 }
        require('mini.surround').setup {}
      '';
      type = "lua";
    };
    copilot = {
      plugin = vimPlugins.copilot-lua;
      config = builtins.readFile lua/plugins/copilot.lua;
      type = "lua";
    };
    conform = {
      plugin = vimPlugins.conform-nvim;
      config = ''
        require("conform.formatters.stylua").require_cwd = true
        require("conform").setup {
          notify_on_error = false,
          formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rust_analyzer" },
            python = { "isort", "black" },
            typescript = { { "prettier" } },
            javascript = { { "prettier" } },
            vue = { { "prettier" } },
          },
        }
      '';
      type = "lua";
    };
    colorizer = {
      plugin = vimPlugins.nvim-colorizer-lua;
      config = ''
        require("colorizer").setup {
          filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "css",
            "html",
            "astro",
            "lua",
          },
          user_default_options = {
            names = false,
            rgb_fn = true,
            hsl_fn = true,
            tailwind = "both",
          },
          buftypes = {},
        }
      '';
      type = "lua";
    };
    gruberDarker = {
      plugin = clone "blazkowolf/gruber-darker.nvim" "main"
        "a2dda61d9c1225e16951a51d6b89795b0ac35cd6";
      config = ''
        require('gruber-darker').setup {
          bold = false,
          invert = {
            signs = false,
            tabline = false,
            visual = false,
          },
          italic = {
            strings = false,
            comments = true,
            operators = false,
            folds = true,
          },
          undercurl = true,
          underline = true,
        }
        vim.cmd.colorscheme('gruber-darker')
      '';
      type = "lua";
    };
  };
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly.overrideAttrs (_: { CFLAGS = "-O3"; });
    extraLuaConfig = ''
      ${builtins.readFile lua/core/options.lua}
      ${builtins.readFile lua/core/keymaps.lua}
      ${builtins.readFile lua/core/autocmds.lua}
    '';
    plugins = with pkgs; [
      # Telescope
      vimPlugins.nvim-web-devicons
      vimPlugins.plenary-nvim
      vimPlugins.telescope-fzf-native-nvim
      vimPlugins.telescope-ui-select-nvim
      fromConfigFile.telescope

      # Comment
      vimPlugins.nvim-ts-context-commentstring
      fromConfigFile.comment

      # Autpairs
      fromConfigFile.autopairs

      # Fzf
      fromConfigFile.fzfLua

      # LSP
      vimPlugins.neodev-nvim
      vimPlugins.fidget-nvim
      fromConfigFile.lspconfig

      # Completion
      vimPlugins.cmp-path
      vimPlugins.cmp-nvim-lua
      vimPlugins.cmp-nvim-lsp
      vimPlugins.luasnip
      vimPlugins.cmp_luasnip
      fromConfigFile.tailwindColorizer
      fromConfigFile.cmp

      # Colorscheme
      fromConfigFile.gruberDarker

      # Colorizer
      fromConfigFile.colorizer

      # Treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-textobjects
      fromConfigFile.treesitter

      # Formatter
      fromConfigFile.conform

      # Neogit
      vimPlugins.diffview-nvim
      fromConfigFile.neogit

      # GitSigns
      vimPlugins.gitsigns-nvim

      # Lualine
      fromConfigFile.lualine

      # Mini
      fromConfigFile.mini

      # Neotree
      vimPlugins.nvim-window-picker
      vimPlugins.nui-nvim
      fromConfigFile.neotree

      # Terminal
      fromConfigFile.fterm

      # Trouble
      fromConfigFile.trouble

      # Copilot
      fromConfigFile.copilot
    ];
  };
}
