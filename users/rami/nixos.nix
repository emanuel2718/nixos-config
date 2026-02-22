{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  # We require this because we use lazy.nvim against the best wishes
  # a pure Nix system so this lets those unpatched binaries run.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  users.users.rami = {
    isNormalUser = true;
    home = "/home/rami";
    extraGroups = [ "docker" "lxd" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$yARfT18zY5XObKKW$6mdO2XDcaZoselDWW7h8rLns3jap2a/lSwuIaH07.tIBfnS28EOJPPK9Am3ijWZI.9kqJtq5N3dC9KMbGdiNx/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjLJQKtccvCreTro7FjVfHY7vgZQHLucukYiVy63E5a eramirez2718@gmail.com"
    ];
  };
}
