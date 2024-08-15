{ pkgs, user, lib, ... }:
{

  imports = [ (import ../modules { inherit pkgs; }) ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  xdg.enable = true;

  home.file.".local/bin/" = {
    recursive = true;
    source = ../bin;
    target = ".local/bin";
    executable = true;
  };

  xdg.configFile = {
    # "i3/config".text = builtins.readFile ../modules/xdg_config/i3config;
    # "i3status/config".text = builtins.readFile ../modules/xdg_config/i3status;
    "fish/functions/fish_user_key_bindings.fish".text =
      builtins.readFile ../modules/fish/fish_user_key_bindings.fish;
  };


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionVariables = {
      TERMINAL = lib.mkDefault "alacritty";
      COLORTERM = lib.mkDefault "truecolor";
      BROWSER = lib.mkDefault "firefox";
    };
    packages = with pkgs; [
      home-manager

      # Audio
      # pavucontrol
      # alsa-utils
      # kdePackages.plasma-pa # needed for volume keys to work on plasma

      # Applications
      _1password-gui
      chromium
      discord
      firefox-devedition
      libreoffice
      xfce.thunar
      zed-editor
      vscode

      # Terminal
      alacritty

      # CLI tools
      rofi
      xclip
      yazi
      fd
      fzf
      ripgrep
      unzip
      btop
      jq
      neofetch
      httpie
      any-nix-shell # fish support for nix-shell
      zoxide

      # Dev
      gcc
      gdb
      gnumake
      valgrind
      sqlitebrowser
      python313 # python 3.13.0b3 at the time of writing
      nodejs
      nodePackages.pnpm
      yarn
      bun

      # LSP
      nil
      pyright

      # Formatters
      nixfmt-rfc-style
      isort
      black
    ];
  };

  programs.zoxide.enable = true;
}
