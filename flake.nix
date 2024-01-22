{

  description = "NixOS system and related tools by Emanuel Ramirez";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    neovim-nightly-overlay,
    ...
  }: let
    user = "rami";
  in {
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager user neovim-nightly-overlay;
      }
    );
    # homeConfigurations = {
    #   rami = home-manager.lib.homeManagerConfiguration {
    #     modules = [ ./nix/home-manager.nix ];
    #   };
    # };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
