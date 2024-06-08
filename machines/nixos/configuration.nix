{ pkgs, config, nixpkgs, ... }: {
  imports = [
     ./hardware.nix
     ../shared.nix
   ];

  networking.hostName = "nixos";


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.grub.useOSProber = true;

  systemd.sleep.extraConfig = "HibernateDelaySec=4h";

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Name = "Rami";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
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


  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    arandr
    python313
    # polychromatic
  ];

  system.stateVersion = "24.05";
}
