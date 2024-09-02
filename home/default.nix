{
  pkgs,
  user,
  lib,
  ...
}:
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
    "i3/config".text = builtins.readFile ../xdg_config/i3config;
    "i3status/config".text = builtins.readFile ../xdg_config/i3status;
    "fish/functions/fish_user_key_bindings.fish".text = builtins.readFile ../modules/fish/fish_user_key_bindings.fish;
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionVariables = {
      TERMINAL = lib.mkDefault "alacritty";
      COLORTERM = lib.mkDefault "truecolor";
      BROWSER = lib.mkDefault "firefox";
      NIX_SHELL_PRESERVE_PROMPT=1;
    };
    packages = with pkgs; [
      home-manager

      # Audio
      # pavucontrol
      # alsa-utils
      # kdePackages.plasma-pa # needed for volume keys to work on plasma

      # Applications
      _1password-gui
      anki
      chromium
      google-chrome
      discord
      brave
      libreoffice
      xfce.thunar
      zed-editor
      vscode
      gimp
      qemu
      vlc

      # Terminal
      alacritty

      # CLI tools
      rofi
      sesh
      xclip
      yazi
      dunst
      fd
      fzf
      ripgrep
      unzip
      btop
      jq
      neofetch
      httpie
      any-nix-shell # fish support for nix-shell
      libvirt-glib
      zoxide

      # Dev
      gcc
      gdb
      gnumake
      valgrind
      sqlitebrowser
      python313 # python 3.13.0b3 at the time of writing

      # web dev
      nodejs
      nodePackages.pnpm
      yarn
      bun

      # rust
      rustc
      cargo
      rustfmt
      clippy

      # LSP
      nil
      pyright
      lua-language-server
      rust-analyzer
      yaml-language-server
      tailwindcss-language-server
      nodePackages.typescript-language-server
      nodePackages.vim-language-server
      nodePackages.volar

      # Formatters
      nixfmt-rfc-style
      stylua
      isort
      prettierd
      black
    ];
  };

  # TODO: move this to modules maybe(?)
  programs.zoxide.enable = true;
}
