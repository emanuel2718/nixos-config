<h1 align="center" style="font-size: 3rem;">
NixOS Config
</h1>

![vie 26 ene 2024 07:03:01 AST](https://github.com/emanuel2718/nixos-config/assets/55965894/5a087e46-5d74-4b89-a761-7cc9a95008c7)



## Install


```shell
nix-shell -p vim git

mkdir -p $HOME/git/dotfiles
git clone https://github.com/emanuel2718/nixos-config.git $HOME/git/dotfiles
sudo cp /etc/nixos/hardware-configuration.nix $HOME/git/dotfiles/machines/<MACHINE>/hardware.nix

cd $HOME/git/dotfiles
sudo nixos-rebuild switch --flake .#<MACHINE>
sudo reboot now
```


## TODO
- [x] add tmux sessionizer
- [ ] fully port Nvim config to nix (currently 50/50 lua/nix)
