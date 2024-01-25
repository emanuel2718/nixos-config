<h1 align="center" style="font-size: 3rem;">
NixOS Config
</h1>


![dom 21 ene 2024 11:41:40 AST](https://github.com/emanuel2718/dotmaker/assets/55965894/25349c23-054a-4464-898b-276ddd068359)

![lun 22 ene 2024 20:51:45 AST](https://github.com/emanuel2718/dotmaker/assets/55965894/400caebc-98f4-4d6f-9c82-65a72b7514de)




## Install


```shell
nix-shell -p vim git

git clone https://github.com/emanuel2718/nixos-config.git $HOME/.dotfiles
sudo cp /etc/nixos/hardware-configuration.nix $HOME/.dotfiles/hosts/<HOST>/hardware.nix
cd $HOME/.dotfiles
sudo nixos-rebuild switch --flake .#<HOST>
sudo reboot now
```


## TODO
- [ ] add tmux sessionizer
- [ ] fully port Nvim config to nix (currently 50/50 lua/nix)
