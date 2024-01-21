{ config, lib, pkgs, ... }:
{

  home.username = "rami";
  home.homeDirectory = "/home/rami";


  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.enable = true;

  home.packages = with pkgs; [
    htop
    neofetch
    fzf
    chromium
    gh
    jq
    ripgrep
    gopls
    nodejs
    zathura
    rofi
    maim
    xclip
    wezterm
    rustup
    httpie
    zoxide
    starship
    vscode
  ];

  home.file.".vimrc".text = builtins.readFile ./.config/.vimrc;
  home.file.".xprofile".text = builtins.readFile ./.config/.xprofile;
  

  xdg.configFile = {
    "i3/config".text = builtins.readFile ./.config/i3config;
    "i3status/config".text = builtins.readFile ./.config/i3status;
    "wezterm/wezterm.lua".text = builtins.readFile ./.config/wezterm.lua;
  };

  programs.zoxide.enable = true;

  programs.vscode = {
   enable = true;
   extensions = with pkgs.vscode-extensions; [
     vscodevim.vim
   ];
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;
      directory = {
        truncation_length = 1;
        fish_style_pwd_dir_length = 1;
      };
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      git_status = {
        disabled = true;
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      "set -g fish_greeting"
      "fish_vi_key_bindings"
    ]));
    shellAliases = {
      cal = "cal -y";
      pbcopy = "xclip -selection -c";

      cr = "cargo run";
      ct = "cargo test";
      cc = "cargo check";

      gsync = "git stash; and git pull --rebase; and git stash pop";
      gs = "git status";
      gl = "git prettylog";
      gpr = "git pull --rebase";

      neovim = "NVIM_APPNAME=NeoVim nvim";

    };
  };


  programs.git = {
    enable = true;
    userName = "Emanuel Ramirez";
    userEmail = "eramirez2718@gmail.com";
    extraConfig = {
      color.ui = true;
      github.user = "emanuel2718";
      init.defaultBranch = "master";
    };
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    };
    #signing = {
    #  key = "";
    #  signByDefault = true;
    #};
  };


  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };


}
