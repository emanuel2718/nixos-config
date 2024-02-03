{ pkgs, ... }: {
  imports = [
     ./hardware.nix
     ../../nix/shared.nix
   ];

  networking.hostName = "vm-x86";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;


  services.blueman.enable = false;
  hardware.bluetooth.enable = false;
  system.stateVersion = "23.11";
}
