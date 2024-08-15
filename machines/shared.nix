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

  # Set XDG environment
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_CACHE_HOME = "\${HOME}/.local/cache";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    PATH = [ "\${XDG_BIN_HOME}" ];
    # XCURSOR_SIZE = "25";
  };

  # Enable printing
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define user account. Dont' forget to set a password with `passwd`
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

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    firefox
    fish
  ];


  system.stateVersion = "24.05";

  # Enable Nix Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
