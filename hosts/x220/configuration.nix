{ pkgs, ... }: {
  imports = [
     ./hardware.nix
     ../../nix/shared.nix
   ];

  networking.hostName = "x220";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.blueman.enable = false;
  hardware.bluetooth.enable = false;
  system.stateVersion = "23.11";
}
