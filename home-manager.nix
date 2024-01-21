{ config, lib, pkgs, ... }:
{

  home.username = "rami";
  home.homeDirectory = "/home/rami";


  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.enable = true;

  home.packages = [
    pkgs.htop
    pkgs.fzf
    pkgs.chromium
    pkgs.gh
    pkgs.jq
    pkgs.ripgrep
    pkgs.gopls
    pkgs.nodejs
    pkgs.zathura
    pkgs.rofi
    pkgs.maim
    pkgs.xclip
    pkgs.wezterm
  ];



  xdg.configFile = {
    "i3/config".text = builtins.readFile ./.config/i3config;
    "i3status/config".text = builtins.readFile ./.config/i3status;
    "wezterm/wezterm.lua".text = builtins.readFile ./.config/wezterm.lua;
  };


}
