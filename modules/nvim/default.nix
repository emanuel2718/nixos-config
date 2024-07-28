{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  gitClone =
    repo: ref: sha:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "http://github.com/${repo}.git";
        ref = ref;
        rev = sha;
      };
    };

  fromConfigFile = with pkgs; {
    gruvbox = {
      plugin = vimPlugins.gruvbox-community;
      config = builtins.readFile lua/plugins/colorscheme.lua;
      type = "lua";
    };
    hybrid = {
      plugin = gitClone "HoNamDuong/hybrid.nvim" "master" "8838621a2e299582a0af5b8b96d5515f27b5d058";
      config = builtins.readFile lua/plugins/colorscheme.lua;
      type = "lua";
    };
    fugitive = {
      plugin = gitClone "tpope/vim-fugitive" "master" "4f59455d2388e113bd510e85b310d15b9228ca0d";
      type = "lua";
    };
    autopairs = {
      plugin = vimPlugins.nvim-autopairs;
      config = builtins.readFile lua/plugins/autopairs.lua;
      type = "lua";
    };
    colorizer = {
      plugin = vimPlugins.nvim-colorizer-lua;
      config = builtins.readFile lua/plugins/colorizer.lua;
      type = "lua";
    };
    term = {
      plugin = vimPlugins.toggleterm-nvim;
      config = builtins.readFile lua/plugins/term.lua;
      type = "lua";
    };
    neotree = {
      plugin = vimPlugins.neo-tree-nvim;
      config = builtins.readFile lua/plugins/neotree.lua;
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
    treesitter = {
      plugin = vimPlugins.nvim-treesitter;
      config = builtins.readFile lua/plugins/treesitter.lua;
      type = "lua";
    };
    telescope = {
      plugin = vimPlugins.telescope-nvim;
      config = builtins.readFile lua/plugins/telescope.lua;
      type = "lua";
    };
    cmp = {
      plugin = gitClone "hrsh7th/nvim-cmp" "main" "a110e12d0b58eefcf5b771f533fc2cf3050680ac";
      # plugin = vimPlugins.nvim-cmp;
      config = builtins.readFile lua/plugins/cmp.lua;
      type = "lua";
    };
    toggle_lsp_diagnostics = {
      plugin =
        gitClone "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim" "main"
          "afcacba44d86df4c3c9752b869e78eb838f55765";
    };
    lsp = {
      plugin = vimPlugins.nvim-lspconfig;
      config = builtins.readFile lua/plugins/lsp.lua;
      type = "lua";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    # package = pkgs.neovim-nightly.overrideAttrs (_: { CFLAGS = "-O3"; });
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraLuaConfig = ''
      ${builtins.readFile lua/core/options.lua}
      ${builtins.readFile lua/core/keymaps.lua}
      ${builtins.readFile lua/core/autocmds.lua}
    '';
    plugins = with pkgs; [

      # Autopairs
      fromConfigFile.autopairs

      # Colorscheme
      # fromConfigFile.gruvbox
      fromConfigFile.hybrid

      # Colorizer
      fromConfigFile.colorizer

      # Telescope
      vimPlugins.nvim-web-devicons
      vimPlugins.plenary-nvim
      vimPlugins.telescope-fzf-native-nvim
      vimPlugins.telescope-ui-select-nvim
      fromConfigFile.telescope

      # Fugitive
      fromConfigFile.fugitive

      # Terminal
      fromConfigFile.term

      # Neotree
      vimPlugins.nvim-window-picker
      fromConfigFile.neotree

      # Lualine
      fromConfigFile.lualine

      # Oil
      fromConfigFile.oil

      # Treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-textobjects
      vimPlugins.nvim-treesitter-parsers.c
      vimPlugins.nvim-treesitter-parsers.cpp
      vimPlugins.nvim-treesitter-parsers.css
      vimPlugins.nvim-treesitter-parsers.lua
      vimPlugins.nvim-treesitter-parsers.vue
      vimPlugins.nvim-treesitter-parsers.vim
      vimPlugins.nvim-treesitter-parsers.tsx
      vimPlugins.nvim-treesitter-parsers.javascript
      vimPlugins.nvim-treesitter-parsers.typescript
      vimPlugins.nvim-treesitter-parsers.go
      # vimPlugins.nvim-treesitter-parsers.zig
      # vimPlugins.nvim-treesitter-parsers.ocaml
      # vimPlugins.nvim-treesitter-parsers.haskell
      # vimPlugins.nvim-treesitter-parsers.prisma
      vimPlugins.nvim-treesitter-parsers.sql
      vimPlugins.nvim-treesitter-parsers.nix
      vimPlugins.nvim-treesitter-parsers.yaml
      vimPlugins.nvim-treesitter-parsers.toml
      vimPlugins.nvim-treesitter-parsers.rust
      vimPlugins.nvim-treesitter-parsers.html
      vimPlugins.nvim-treesitter-parsers.bash
      vimPlugins.nvim-treesitter-parsers.python
      fromConfigFile.treesitter

      # Completion
      vimPlugins.luasnip
      vimPlugins.lspkind-nvim
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-path
      vimPlugins.cmp-buffer
      vimPlugins.cmp_luasnip
      fromConfigFile.cmp

      # LSP
      vimPlugins.neodev-nvim
      vimPlugins.trouble-nvim
      vimPlugins.fidget-nvim
      vimPlugins.conform-nvim
      vimPlugins.SchemaStore-nvim
      fromConfigFile.toggle_lsp_diagnostics
      fromConfigFile.lsp
    ];
  };
}
