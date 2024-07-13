{ pkgs, ... }:
{

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Puerto_Rico";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_PR.UTF-8";
    LC_IDENTIFICATION = "es_PR.UTF-8";
    LC_MEASUREMENT = "es_PR.UTF-8";
    LC_MONETARY = "es_PR.UTF-8";
    LC_NAME = "es_PR.UTF-8";
    LC_NUMERIC = "es_PR.UTF-8";
    LC_PAPER = "es_PR.UTF-8";
    LC_TELEPHONE = "es_PR.UTF-8";
    LC_TIME = "es_PR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm = {
        enable = true;
      };
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 170 90
      '';
    };
    xkb = {
      layout = "us";
      variant = "";
    };
    # autoRepeatDelay = 170;
    # autoRepeatInterval = 90;
    # xkb.options = "caps:escape";

    # desktopManager = {
    #   xterm.enable = false;
    #   xfce = {
    #     enable = true;
    #     noDesktop = true;
    #     enableXfwm = false;
    #   };
    #   wallpaper = {
    #     # NOTE: it will source $HOME/.background-image as the wallpaper by default
    #     mode = "fill";
    #     combineScreens = false;
    #   };
    # };

    # windowManager = { i3.enable = true; };
  };
  services.desktopManager = {
    plasma6 = {
      enable = true;
    };
  };

  services.displayManager = {
    defaultSession = "plasma";
  };
  # services.displayManager = { defaultSession = "none+i3"; };

  # set caps and left control (hhkb) to both Escape (tap) + Control (hold with another key)
  services.interception-tools = {
    enable = true;
    udevmonConfig =
      let
        dualFunctionKeysConfig = builtins.toFile "dual-function-keys.yaml" ''
          TIMING:
            TAP_MILLISEC: 200
            DOUBLE_TAP_MILLISEC: 0

          MAPPINGS:
            - KEY: KEY_CAPSLOCK
              TAP: KEY_ESC
              HOLD: KEY_LEFTCTRL
            - KEY: KEY_LEFTCTRL
              TAP: KEY_ESC
              HOLD: KEY_LEFTCTRL
        '';
      in
      ''
        - JOB: |
            ${pkgs.interception-tools}/bin/intercept -g $DEVNODE \
              | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c ${dualFunctionKeysConfig} \
              | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK]
      '';
  };

  # Set XDG environment
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_CACHE_HOME = "\${HOME}/.local/cache";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    PATH = [ "\${XDG_BIN_HOME}" ];
    XCURSOR_SIZE = "25";
  };

  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rami = {
    isNormalUser = true;
    description = "rami";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  environment.localBinInPath = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.dconf.enable = true;
  # programs.dconf = {
  #   enable = true;
  #   settings = {
  #     "org/virt-manager/virt-manager/connections" = {
  #       autoconnect = ["qemu:///system"];
  #       uris = ["qemu:///system"];
  #     };
  #   };
  # };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    firefox-devedition
  ];

  system.stateVersion = "24.05";

  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
