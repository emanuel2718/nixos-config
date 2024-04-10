{ ... }:
{
  imports = 
    [(import ../modules/fish)]
    ++ [(import ../modules/gitconfig)]
    ++ [(import ../modules/starship)]
    ++ [(import ../modules/vscode)]
    ++ [(import ../modules/tmux)]
    ++ [(import ../modules/rofi)]
    ++ [(import ../modules/alacritty)]
    ++ [(import ../modules/wezterm)]
    ++ [(import ../modules/nvim)];
}
