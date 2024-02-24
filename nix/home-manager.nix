{ pkgs, user, inputs, lib, ... }:
let

obsidian = lib.throwIf (lib.versionOlder "1.5.3" pkgs.obsidian.version) "Obsidian no longer requires EOL Electron" (
  pkgs.obsidian.override {
    electron = pkgs.electron_25.overrideAttrs (_: {
      preFixup = "patchelf --add-needed ${pkgs.libglvnd}/lib/libEGL.so.1 $out/bin/electron"; # NixOS/nixpkgs#272912
      meta.knownVulnerabilities = [ ]; # NixOS/nixpkgs#273611
    });
  }
);

in {

  imports = [ (import ../modules { inherit pkgs; } ) ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
  xdg.enable = true;


  # TODO: merge this to a nix modules
  home.file.".vimrc".text = builtins.readFile ../modules/config/.vimrc;
  home.file.".xsessionrc".text = ''xset r rate 170 90'';
  home.file.".local/bin/" = {
      recursive = true;
      source = ../bin;
      target = ".local/bin";
      executable = true;
  };



  xdg.configFile = {
    "i3/config".text = builtins.readFile ../modules/config/i3config;
    "i3status/config".text = builtins.readFile ../modules/config/i3status;
    "fish/functions/fish_user_key_bindings.fish".text = builtins.readFile ../modules/fish/fish_user_key_bindings.fish;
  };


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      _1password-gui
      btop
      discord
      fd
      feh
      fzf
      home-manager
      htop
      httpie
      jq
      lazygit
      maim
      mpv
      neofetch
      fastfetch
      ranger
      ripgrep
      rsync
      unzip
      xclip
      valgrind
      zathura
      gnumake
      zig
      gcc
      gdb
      nodejs
      bun
      xcape
      obsidian
      chromium
      any-nix-shell # fish support for nix-shell
      gimp
      hyperfine
      libreoffice
      dunst
      betterlockscreen
      # pulseaudio stuff
      pavucontrol
      paprefs
      pasystray
      vlc
      terminus-nerdfont
      fira-code-nerdfont
      thunderbird
      github-desktop

      cmake-language-server
      nil
      rnix-lsp
      rust-analyzer
      clang-tools
      nodePackages_latest.pnpm
      nodePackages_latest.pyright
      nodePackages.vim-language-server
      nodePackages.volar
      nodePackages.typescript-language-server
      lua-language-server
      buf-language-server
      tailwindcss-language-server
    ];
  };

  programs.zoxide.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };


   programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish.enable = true;
  };
}
