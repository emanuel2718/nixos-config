<h1 align="center" style="font-size: 3rem;">
NixOS Config
</h1>

![vie 26 ene 2024 07:03:01 AST](https://github.com/emanuel2718/nixos-config/assets/55965894/5a087e46-5d74-4b89-a761-7cc9a95008c7)



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
- [x] add tmux sessionizer
- [ ] fully port Nvim config to nix (currently 50/50 lua/nix)
