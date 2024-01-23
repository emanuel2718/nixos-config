{ inputs, nixpkgs, home-manager, user, ... }:
let
  system = "x86_64-linux";
  overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = overlays;
  };

in {
  nixos = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user pkgs; };
    modules = [
      ./nixos/configuration.nix
      ./nixos/hardware.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = let
          machine = "nixos";
        in {
          inherit user inputs machine;
        };
        home-manager.users.${user} = import ../nix/home-manager.nix;
      }
    ];
  };
}
