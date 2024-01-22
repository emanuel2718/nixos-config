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

      pkgs.vimPlugins.rustaceanvim
    ];
  };
}
