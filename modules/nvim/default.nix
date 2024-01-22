{ pkgs, lib, ... }:
{
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


    ];
  };
}
