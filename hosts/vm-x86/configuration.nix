{ pkgs, ... }: {
  imports = [
     ./hardware.nix
     ../../nix/shared.nix
   ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "vm-x86";
  services.blueman.enable = false;
  hardware.bluetooth.enable = false;
  system.stateVersion = "23.11";
}
