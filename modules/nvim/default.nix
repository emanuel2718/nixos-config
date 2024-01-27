{ pkgs, lib, ... }:
let
  gitClone = repo: ref: sha:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "http://github.com/${repo}.git";
        ref = ref;
        rev = sha;
      };
    };
in {
  

  # xdg.configFile."nvim" = { source = ./config; recursive = true; };
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
      vimPlugins.plenary-nvim
      vimPlugins.telescope-fzf-native-nvim
      {
        plugin = vimPlugins.telescope-nvim;
        config = builtins.readFile lua/plugins/telescope.lua;
        type = "lua";
      }

      # Formatter
      vimPlugins.conform-nvim

      # LSP
      vimPlugins.neodev-nvim
      vimPlugins.fzf-lua
      pkgs.vimPlugins.rustaceanvim
      {
        plugin = vimPlugins.nvim-lspconfig;
        config = builtins.readFile lua/plugins/lspconfig.lua;
        type = "lua";
      }

      # cmp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-path
      vimPlugins.cmp-nvim-lua
      vimPlugins.cmp-nvim-lsp
      vimPlugins.lspkind-nvim
      vimPlugins.cmp-cmdline
      vimPlugins.luasnip
      vimPlugins.cmp_luasnip
      {
        plugin = vimPlugins.nvim-cmp;
        config = builtins.readFile lua/plugins/cmp.lua;
        type = "lua";
      }


      ## Treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-textobjects
      {
        plugin = vimPlugins.nvim-treesitter;
        config = builtins.readFile lua/plugins/treesitter.lua;
        type = "lua";
      }

      # Neogit
      vimPlugins.diffview-nvim
      {
        plugin = vimPlugins.neogit;
        config = ''
          vim.keymap.set('n', '<leader>g.', '<cmd>Neogit<cr>', { noremap = true, silent = true })
          require('neogit').setup({
            integrations = { diffview = true, fzf_lua = true }
          })
        '';
        type = "lua";
      }

      # Oil
      vimPlugins.nvim-web-devicons
      {
        plugin = vimPlugins.oil-nvim;
        config = builtins.readFile lua/plugins/oil.lua;
        type = "lua";
      }

      # Fidget
      vimPlugins.fidget-nvim

      # Comment
      {
        plugin = vimPlugins.comment-nvim;
        config = "require('Comment').setup()";
        type = "lua";
      }

      # Autopairs
      {
        plugin = vimPlugins.nvim-autopairs;
        config = ''
          require('nvim-autopairs').setup({
            map_char = {
                all = "(",
                tex = "{"
            },
            enable_check_bracket_line = false,
            check_ts = true,
            ts_config = {
                lua = {"string", "source"},
                javascript = {"string", "template_string"},
                java = false
            },
            disable_filetype = {"TelescopePrompt", "spectre_panel"},
            ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
            enable_moveright = true,
            disable_in_macro = false,
            enable_afterquote = true,
            map_bs = true,
            map_c_w = false,
            disable_in_visualblock = false
          })
        '';
        type = "lua";
      }

      # Colorizer
      {
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
      }


      # Terminal

      {
        plugin = vimPlugins.FTerm-nvim;
        config = ''
          vim.keymap.set('n', '<C-T>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
          vim.keymap.set('t', '<C-T>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
          require("FTerm").setup({
            border = "solid",
            blend = 10,
          })
        '';
        type = "lua";
      }

      # Trouble
      {
        plugin = vimPlugins.trouble-nvim;
        config = ''
          local map = vim.keymap.set
          map("n", "<leader>d.", function() require("trouble").toggle("document_diagnostics") end, { noremap = true, silent = true }) 
        '';
        type = "lua";
      }


      # Toggle LSP Diagnostics
      {
        plugin = gitClone "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim" "main" "4fbfb51e3902d17613be0bc03035ce26b9a8d05d";
        config = builtins.readFile lua/plugins/toggle-diagnostics.lua;
        type = "lua";
      }

      # Neotree
      {
        plugin = gitClone "nvim-neo-tree/neo-tree.nvim" "main" "e578fe7a5832421b0d2c5b3c0a7a1e40e0f6a47a";
        config = builtins.readFile lua/plugins/neotree.lua;
        type = "lua";
      }
    ];
  };
}
