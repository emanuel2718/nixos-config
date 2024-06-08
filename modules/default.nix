{ ... }:
{
  imports = 
    [(import ../modules/fish)]
    ++ [(import ../modules/git)]
    # ++ [(import ../modules/starship)]
    #++ [(import ../modules/vscode)]
    ++ [(import ../modules/tmux)]
    ++ [(import ../modules/betterlockscreen)]
    #++ [(import ../modules/rofi)]
    #++ [(import ../modules/alacritty)]
    ++ [(import ../modules/nvim)]
    ++ [(import ../modules/wezterm)];
}
