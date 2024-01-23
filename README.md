<h1 align="center" style="font-size: 3rem;">
NixOS Config
</h1>


![dom 21 ene 2024 11:41:40 AST](https://github.com/emanuel2718/dotmaker/assets/55965894/25349c23-054a-4464-898b-276ddd068359)



## Install


```shell
git clone git@github.com:emanuel2718/nixos-config.git $HOME/.dotfiles
cp /etc/nixos/hardware-configuratioun.nix ~/nixos-config/machines/<M>/.
cd $HOME/.dotfiles
sudo nixos-rebuild switch --flake .#<M>
sudo reboot now
```


## TODO
- [ ] fully port Nvim config to nix (currently 50/50 lua/nix)
