{ ... }:
{
  imports = 
    [(import ../modules/fish)]
    ++ [(import ../modules/gitconfig)]
    ++ [(import ../modules/starship)]
    ++ [(import ../modules/code)]
    ++ [(import ../modules/tmux)]
    ++ [(import ../modules/rofi)]
    ++ [(import ../modules/nvim)];
}
