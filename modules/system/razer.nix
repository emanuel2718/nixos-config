{ pkgs, ... }:
{
  hardware.openrazer.enable = true;
  boot.kernelParams = [ "button.lid_init_state=open" ];
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };
  environment.systemPackages = with pkgs; [ openrazer-daemon ];
}
