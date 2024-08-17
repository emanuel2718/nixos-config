{ config, pkgs, ... }:

{
  imports =
    [
      ../shared.nix
      ./hardware.nix
      ../../modules/system/fonts.nix
      # ../../modules/i3
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "vm-x86"; # Define your hostname.

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable KDE Plasma
  services.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable i3
  # Uncomment the i3 import on the `imports`

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
