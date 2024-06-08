{
  description = "NixOS system and related tools by Emanuel Ramirez";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim Overlay
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
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

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
