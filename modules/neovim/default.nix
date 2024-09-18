{ inputs, pkgs, lib, ... }:
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

  gitCloneIt = {
    hybrid = {
      plugin = gitClone "HoNamDuong/hybrid.nvim" "master" "8838621a2e299582a0af5b8b96d5515f27b5d058";
    };
    cmp = {
      plugin = gitClone "hrsh7th/nvim-cmp" "main" "ae644feb7b67bf1ce4260c231d1d4300b19c6f30";
    };
    monokai = {
      plugin = gitClone "tanvirtin/monokai.nvim" "master" "b8bd44d5796503173627d7a1fc51f77ec3a08a63";
    };
  };

  readLuaFiles = dir: builtins.concatStringsSep "\n" (
    builtins.map (file: builtins.readFile "${dir}/${file}") (
        builtins.attrNames (builtins.readDir dir)
      )
    );
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs; [
      # Autopairs
      vimPlugins.nvim-autopairs

      # Colorizer
      vimPlugins.nvim-colorizer-lua

      # Term
      vimPlugins.toggleterm-nvim

      # Colorscheme
      vimPlugins.base16-nvim
      vimPlugins.gruvbox-community
      gitCloneIt.hybrid
      gitCloneIt.monokai

      # Neotree
      # vimPlugins.nvim-web-devicons
      vimPlugins.nvim-window-picker
      vimPlugins.neo-tree-nvim

      # Oil
      vimPlugins.oil-nvim

      # Lualine
      vimPlugins.lualine-nvim

      # Gitsigns
      vimPlugins.gitsigns-nvim

      # Fzf
      vimPlugins.fzf-lua

      # Treesitter
      vimPlugins.nvim-treesitter
      vimPlugins.nvim-treesitter-textobjects
      vimPlugins.nvim-treesitter-parsers.c
      vimPlugins.nvim-treesitter-parsers.cpp
      vimPlugins.nvim-treesitter-parsers.css
      vimPlugins.nvim-treesitter-parsers.lua
      vimPlugins.nvim-treesitter-parsers.vue
      vimPlugins.nvim-treesitter-parsers.vim
      vimPlugins.nvim-treesitter-parsers.vimdoc
      vimPlugins.nvim-treesitter-parsers.tsx
      vimPlugins.nvim-treesitter-parsers.javascript
      vimPlugins.nvim-treesitter-parsers.typescript
      vimPlugins.nvim-treesitter-parsers.go
      vimPlugins.nvim-treesitter-parsers.zig
      vimPlugins.nvim-treesitter-parsers.sql
      vimPlugins.nvim-treesitter-parsers.nix
      vimPlugins.nvim-treesitter-parsers.yaml
      vimPlugins.nvim-treesitter-parsers.toml
      vimPlugins.nvim-treesitter-parsers.rust
      vimPlugins.nvim-treesitter-parsers.html
      vimPlugins.nvim-treesitter-parsers.bash
      vimPlugins.nvim-treesitter-parsers.python
      vimPlugins.nvim-treesitter-parsers.query

      # Copilot
      vimPlugins.copilot-lua

      # Completion
      gitCloneIt.cmp
      vimPlugins.luasnip
      vimPlugins.lspkind-nvim
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-path
      vimPlugins.cmp-buffer
      vimPlugins.cmp_luasnip

      # LSP
      vimPlugins.nvim-lspconfig
      vimPlugins.neodev-nvim
      vimPlugins.trouble-nvim
      vimPlugins.fidget-nvim
      vimPlugins.conform-nvim
      vimPlugins.SchemaStore-nvim
    ];
    extraLuaConfig = ''
      ${readLuaFiles ./lua/core}
      ${readLuaFiles ./lua/plugins}
    '';
  };
}
