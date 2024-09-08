{ pkgs, config, ... }:
{
  imports = [
    ./hardware.nix
    ../shared.nix
    # ../../modules/i3
    ../../modules/system/fonts.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/sound.nix
    ../../modules/system/razer.nix
    ../../modules/system/nvidia.nix
  ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.sleep.extraConfig = "HibernateDelaySec=4h";

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;

  networking.hostName = "blade";

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
