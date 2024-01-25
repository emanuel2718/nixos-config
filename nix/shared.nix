{ pkgs, user, lib, inputs, ... }:
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
    layout = "us";
    xkbVariant = "";
    autoRepeatDelay = 170;
    autoRepeatInterval = 90;
    displayManager = {
      lightdm = {
        enable = true;
      };
      defaultSession = "none+i3";
      # sessionCommands = ''
      #  ${pkgs.xorg.setxkbmap}/bin/setxkbmap -option "caps:ctrl_modifier"
      #  ${pkgs.xcape}/bin/xcape "Caps_Lock=Escape"
      #  ${pkgs.xorg.setxkbmap}/bin/setxkbmap -option "caps:ctrl_modifier"
      #  ${pkgs.xcape}/bin/xcape "Caps_Lock=Escape;Control_L=Escape;Control_R=Escape"
      #  # ${pkgs.xorg.xrandr}/bin/xrandr xrandr --output HDMI-0 --primary --mode 2560x1440 --rate 144 --output eDP-1-1 --off
      # '';
    };
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = false;
        noDesktop = true;
      };
      wallpaper = {
          # NOTE: it will source $HOME/.background-image as the wallpaper by default
        mode = "scale";
        combineScreens = false;
      };
    };

    windowManager = {
      i3.enable = true;
    };
  };

  # Set XDG environment
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_CACHE_HOME = "\${HOME}/.local/cache";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    PATH = ["\${XDG_BIN_HOME}"];
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
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  system.stateVersion = "23.11";

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
