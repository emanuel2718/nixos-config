{ pkgs, user, inputs, ... }:
{

  imports = [ (import ../modules { inherit pkgs; } ) ];


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
  xdg.enable = true;


  # TODO: merge this to a nix modules
  home.file.".vimrc".text = builtins.readFile ../modules/config/.vimrc;
  home.file.".xprofile".text = builtins.readFile ../modules/config/.xprofile;
  

  xdg.configFile = {
    "i3/config".text = builtins.readFile ../modules/config/i3config;
    "i3status/config".text = builtins.readFile ../modules/config/i3status;
    "wezterm/wezterm.lua".text = builtins.readFile ../modules/config/wezterm.lua;
    "fish/functions/fish_user_key_bindings.fish".text = builtins.readFile ../modules/fish/fish_user_key_bindings.fish;
  };


  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
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
      ranger
      ripgrep
      rsync
      unzip
      vscode
      wezterm
      xclip
      zathura
    ];
  };

  programs.zoxide.enable = true;
}
