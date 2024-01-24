{ pkgs, ... }: {
  imports = [
     ./hardware.nix
     ../../nix/shared.nix
   ];

  networking.hostName = "vm-x86";
  services.blueman.enable = false;
  hardware.bluetooth.enable = false;
  system.stateVersion = "23.11";
}
