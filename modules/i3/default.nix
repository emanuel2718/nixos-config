{ lib, pkgs, ... }:
{
  services.libinput.enable = true;
  services.displayManager.defaultSession = "xfce+i3";
  services.xserver = {
    enable = true;
    # xkb.layout = "us";
    # xkb.variant = "dvp";
    # xkb.options = "altwin:swap_alt_win";

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    excludePackages = [ pkgs.xterm ];

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        rofi
        i3status
        i3lock
      ];
      extraConfig = ''
        
      '';
    };
  };
}
