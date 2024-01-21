{ 
  description = "NixOS system and related tools by Emanuel Ramirez";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      

  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; overlays = overlays; };
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        rami = home-manager.lib.homeManagerConfiguration {
	        inherit pkgs;
          modules = [ ./home-manager.nix ];
        };
      };
    };
}

