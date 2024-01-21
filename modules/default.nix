{ ... }:
{
  imports = 
    [(import ../modules/config/fish)]
    ++ [(import ../modules/config/git)]
    ++ [(import ../modules/config/starship)]
    ++ [(import ../modules/config/nvim)];
}
