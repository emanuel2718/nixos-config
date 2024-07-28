{ pkgs, user, ... }: {

  imports = [ (import ../modules { inherit pkgs; }) ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  xdg.enable = true;

  # TODO: merge this to a nix modules
  home.file.".vimrc".text = builtins.readFile ../modules/dots/.vimrc;
  home.file.".xinitrc".text = builtins.readFile ../modules/dots/.xinitrc;
  home.file.".xsession".text = builtins.readFile ../modules/dots/.xsession;
  # home.file.".xsessionrc".text = "xset r rate 170 90";
  home.file.".local/bin/" = {
    recursive = true;
    source = ../bin;
    target = ".local/bin";
    executable = true;
  };

  xdg.configFile = {
    "i3/config".text = builtins.readFile ../modules/xdg_config/i3config;
    "i3status/config".text = builtins.readFile ../modules/xdg_config/i3status;
    "fish/functions/fish_user_key_bindings.fish".text =
      builtins.readFile ../modules/fish/fish_user_key_bindings.fish;
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      home-manager

      _1password-gui
      # btop
      # gh
      # bat
      autorandr
      tldr
      sesh
      discord
      fd
      feh
      fzf
      htop
      httpie
      jq
      rofi
      dmenu
      # lazygit
      # maim
      mpv
      neofetch
      fastfetch
      ranger
      yazi
      ripgrep
      # rsync
      unzip
      xclip
      zathura
      libreoffice
      slack
      mullvad-vpn

      # zig

      gcc
      gdb
      gnumake
      valgrind

      # rustup
      # rustc
      # cargo
      # rustfmt
      # clippy

      xcape
      obsidian
      chromium
      google-chrome
      librewolf
      any-nix-shell # fish support for nix-shell
      gimp
      hyperfine
      # libreoffice
      # libvirt-glib
      dunst
      betterlockscreen
      sqlitebrowser
      # # pulseaudio stuff
      alsa-scarlett-gui
      pavucontrol
      paprefs
      pasystray
      vlc

      # fonts
      terminus-nerdfont
      fixedsys-excelsior
      # fira-code-nerdfont

      # thunderbird
      github-desktop
      qemu
      kdePackages.kalk
      kdePackages.kolourpaint

      # Web Dev
      nodejs
      yarn
      bun
      nodePackages_latest.pnpm

      # LSPs
      nil
      pyright
      clang-tools
      rust-analyzer
      lua-language-server
      yaml-language-server
      tailwindcss-language-server
      nodePackages.typescript-language-server
      nodePackages.vim-language-server
      nodePackages.volar

      # Formatters
      nixfmt-rfc-style
      isort
      black
      stylua
      prettierd
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

  # programs.autorandr = {
  #   enable = true;
  #   profiles = {
  #     default = {
  #       fingerprint = { # autorandr --fingerprint
  #         DP-4 = "00ffffffffffff001c5414270101010110200104b53c2278fbb8e5a65337b9260a5054254a00d1c081c0010101010101010101010101565e00a0a0a0295030203500544f2100001a000000fd0c30f0878767010a202020202020000000fc004d32375120580a202020202020000000ff003232313630423030313038310a0265020330714a0203111213042f1f103f23091707830100006d1a0000020130f0000000000000e305c301e6060d0162624ab78c80c87038644018102500544f2100001ab8bc0050a0a055500820f80c544f2100001a22e50050a0a067500820f80c544f2100001a00000000000000000000000000000000000000000000000000fb70123f000003013c45090104ff094f002f001f009f057600020004005f380104ff099f002f001f009f051d000200040086860104ff09a7002f001f009f05560002000400f1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f19f";
  #         HDMI-0 = "00ffffffffffff0006b32124766f0100011f010380351e782a51b5a4544fa0260d5054bfcf00814081809500714f81c0b30001010101023a801871382d40582c45000f282100001e3a7f808870381440182035000f282100001e000000fd0030901eb422000a202020202020000000fc00415355532056473234390a20200105020332f14f010304131f120211900e0f1d1e3f40230907078301000067030c00100000446d1a000002013090e6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b";
  #         eDP-1-1 = "00ffffffffffff0009e5040800000000011d0104a5221378024c30a454519b270c5054000000010101010101010101010101010101019d8580a070383e406c30aa0058c11000001a9d8580a070387d466c30aa0058c110000000000000fe00424f452048460a202020202020000000fe004e5631353646484d2d4e344b0a00d8";
  #       };
  #       config = {
  #         DP-4 = {
  #           enable = true;
  #           primary = true;
  #           position = "0x141";
  #           mode = "2560x1440";
  #           rate = "144.00"; # 165.00
  #           rotate = "normal";
  #         };
  #         HDMI-0 = {
  #           enable = true;
  #           primary = false;
  #           position = "2560x0";
  #           mode = "1080x1920";
  #           rate = "144.00";
  #           rotate = "right";
  #         };
  #         eDP-1-1 = {
  #           enable = false;
  #           primary = false;
  #         };
  #       };
  #     };
  #   };
  # };
}
