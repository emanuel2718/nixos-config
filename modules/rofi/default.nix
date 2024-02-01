{ pkgs, ... }:
{
  programs = {
    rofi = {
      enable = true;
      plugins = with pkgs; [ rofi-calc rofi-top ];
      terminal = "${pkgs.wezterm}/bin/wezterm";
    };
  };
}
