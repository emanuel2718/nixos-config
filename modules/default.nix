{ ... }:
{
  imports = 
    [(import ../modules/fish)]
    ++ [(import ../modules/git)]
    ++ [(import ../modules/tmux)]
    #++ [(import ../modules/betterlockscreen)]
    #++ [(import ../modules/rofi)]
    ++ [(import ../modules/nvim)]
    ++ [(import ../modules/vscode)]
    ++ [(import ../modules/alacritty)]
    ++ [(import ../modules/wezterm)];
}
