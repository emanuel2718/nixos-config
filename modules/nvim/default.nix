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
    lsp = {
      plugin = vimPlugins.nvim-lspconfig;
      config = builtins.readFile lua/plugins/lsp.lua;
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
    neotree = {
      plugin = vimPlugins.neo-tree-nvim;
      config = builtins.readFile lua/plugins/neotree.lua;
      type = "lua";
    };
    toggleDiagnostics = {
      plugin = clone "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim" "main" "4fbfb51e3902d17613be0bc03035ce26b9a8d05d";
      config = builtins.readFile lua/plugins/toggle-diagnostics.lua;
      type = "lua";
    };
    toggleTerm = {
      plugin = vimPlugins.toggleterm-nvim;
      config = ''
        require('toggleterm').setup {
          direction = 'float'
        }
        vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
        vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
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
         local statusline = require 'mini.statusline'
         statusline.setup { use_icons = vim.g.have_nerd_font }
         statusline.section_location = function()
           return '%2l:%-2v'
         end
      '';
      type = "lua";
    };
    copilot = {
      plugin = vimPlugins.copilot-lua;
      config = builtins.readFile lua/plugins/copilot.lua;
      type = "lua";
    };
    monokai = {
      plugin = clone "tanvirtin/monokai.nvim" "master" "b8bd44d5796503173627d7a1fc51f77ec3a08a63";
      config = ''
       require('monokai').setup { 
        italics = false,
        palette = {
          name = 'monokai',
          base1 = '#272a30',
          base2 = '#1E1E1E',
          base3 = '#2E323C',
          base4 = '#333842',
          base5 = '#4d5154',
          base6 = '#9ca0a4',
          base7 = '#b1b1b1',
          border = '#a1b5b1',
          brown = '#504945',
          white = '#f8f8f0',
          grey = '#8F908A',
          black = '#000000',
          pink = '#f92672',
          green = '#a6e22e',
          aqua = '#66d9ef',
          yellow = '#e6db74',
          orange = '#fd971f',
          purple = '#ae81ff',
          red = '#e95678',
          diff_add = '#3d5213',
          diff_remove = '#4a0f23',
          diff_change = '#27406b',
          diff_text = '#23324d',
        },
        custom_hlgroups = {},
      }
      '';
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
      # vimPlugins.telescope-fzf-native-nvim
      # vimPlugins.telescope-ui-select-nvim
      # fromConfigFile.telescope

      # Comment
      vimPlugins.nvim-ts-context-commentstring
      fromConfigFile.comment

      # Autpairs
      fromConfigFile.autopairs

      # Fzf
      fromConfigFile.fzfLua

      # LSP
      vimPlugins.SchemaStore-nvim
      vimPlugins.neodev-nvim
      vimPlugins.fidget-nvim
      vimPlugins.nvim-lsp-ts-utils
      fromConfigFile.lsp

      # Completion
      vimPlugins.cmp-path
      vimPlugins.cmp-nvim-lua
      vimPlugins.cmp-nvim-lsp
      vimPlugins.luasnip
      vimPlugins.cmp_luasnip
      fromConfigFile.tailwindColorizer
      fromConfigFile.cmp

      # Colorscheme
      fromConfigFile.monokai

      # Colorizer
      fromConfigFile.colorizer

      # Treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-textobjects
      fromConfigFile.treesitter

      # Formatter
      fromConfigFile.conform

      # Neogit
      # vimPlugins.diffview-nvim
      # fromConfigFile.neogit

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
      # fromConfigFile.fterm
      fromConfigFile.toggleTerm
      # vimPlugins.toggleterm-nvim

      # Trouble
      fromConfigFile.trouble

      # Copilot
      fromConfigFile.copilot

      # ToggleDiagnostics
      fromConfigFile.toggleDiagnostics
    ];
  };
}
