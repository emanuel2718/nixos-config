{ pkgs, config, nixpkgs, ... }: {
  imports = [
     ./hardware.nix
     ../../nix/shared.nix
   ];

  networking.hostName = "blade";


  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Razer blade specific stuff
  hardware.openrazer.enable = true;
  boot.kernelParams = [ "button.lid_init_state=open" ];
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  hardware.nvidia = {
    powerManagement.enable = true;
    modesetting.enable = true;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };

  # services.xserver.displayManager.setupCommands = ''
  #   LAPTOP="eDP-1-1"
  #   MONITOR="HDMI-0"
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output $MONITOR --primary --mode 2560x1440 --rate 144 --output $LAPTOP --off
  # '';

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    firefox
    openrazer-daemon
    arandr
    python313
    # polychromatic
  ];

  system.stateVersion = "23.11";
}
