{ pkgs, user, inputs, lib, ... }:
let

in {

  imports = [ (import ../modules { inherit pkgs; } ) ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  xdg.enable = true;


  # TODO: merge this to a nix modules
  home.file.".vimrc".text = builtins.readFile ../modules/dots/.vimrc;
  home.file.".xinitrc".text = builtins.readFile ../modules/dots/.xinitrc;
  home.file.".xsessionrc".text = ''xset r rate 170 90'';
  # home.file.".local/bin/" = {
  #     recursive = true;
  #     source = ../bin;
  #     target = ".local/bin";
  #     executable = true;
  # };



  xdg.configFile = {
    "i3/config".text = builtins.readFile ../modules/xdg_config/i3config;
    "i3status/config".text = builtins.readFile ../modules/xdg_config/i3status;
    "fish/functions/fish_user_key_bindings.fish".text = builtins.readFile ../modules/fish/fish_user_key_bindings.fish;
  };


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      home-manager

      _1password-gui

      # _1password-gui
      # btop
      # gh
      # bat
      discord
      fd
      feh
      fzf
      htop
      httpie
      jq
      rofi
      # lazygit
      # maim
      mpv
      neofetch
      # fastfetch
      ranger
      ripgrep
      # rsync
      unzip
      xclip
      # valgrind
      zathura
      # gnumake
      # zig
      # gcc
      # gdb
      # nodejs
      # bun
      xcape
      obsidian
      chromium
      any-nix-shell # fish support for nix-shell
      # gimp
      # hyperfine
      # libreoffice
      # libvirt-glib
      # dunst
      betterlockscreen
      # sqlitebrowser
      # # pulseaudio stuff
      # pavucontrol
      # paprefs
      # pasystray
      # vlc
      terminus-nerdfont
      # fira-code-nerdfont
      # thunderbird
      github-desktop
      qemu

      # cmake-language-server
      # nil
      # # rnix-lsp
      # rust-analyzer
      # clang-tools
      # yarn
      # nodePackages_latest.pnpm
      # nodePackages_latest.pyright
      # nodePackages.vim-language-server
      # nodePackages.volar
      # nodePackages.typescript-language-server
      # lua-language-server
      # buf-language-server
      # tailwindcss-language-server
    ];
  };

  programs.zoxide.enable = true;

  # programs.nix-index = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };


   programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish.enable = true;
  };
}
