{ ... }:
{
  imports = 
    [(import ../modules/fish)]
    ++ [(import ../modules/git)]
    ++ [(import ../modules/starship)]
    ++ [(import ../modules/vscode)]
    ++ [(import ../modules/rofi)]
    ++ [(import ../modules/nvim)];
}
