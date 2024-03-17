{

  description = "NixOS system and related tools by Emanuel Ramirez";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    gitu = {
      url = "github:altsem/gitu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    gitu,
    ...
  }: let
    user = "rami";
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager user neovim-nightly-overlay gitu;
      }
    );

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
