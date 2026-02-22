# KDE Plasma (Wayland)
{ lib, pkgs, ... }: {
  specialisation.plasma.configuration = {
    services.xserver.displayManager.lightdm.enable = lib.mkForce false;
    services.xserver.windowManager.i3.enable = lib.mkForce false;
    services.displayManager.defaultSession = lib.mkForce "plasma";

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
