{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly.overrideAttrs (_: { CFLAGS = "-O3"; });
    plugins = [
      # Telescope
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = builtins.readFile config/plugins/telescope.lua;
        type = "lua";
      }
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-fzf-native-nvim
    ];
  };
}
