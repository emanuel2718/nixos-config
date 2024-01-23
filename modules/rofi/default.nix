{ pkgs, ... }:
{
  programs = {
    rofi = {
      enable = true;
      plugins = [
        pkgs.rofi-calc
        pkgs.rofi-top
      ];
    };
  };
}