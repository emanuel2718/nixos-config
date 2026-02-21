{
  description = "NixOS system by Emanuel Ramirez";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # extremely unstable, use with caution!
    nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      # follow nightly
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # macOS
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvim overlay
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # WSL support
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Snapd
    nix-snapd.url = "github:io12/nix-snapd";

    # Fish plugins
    fish-fzf.url = "github:PatrickF1/fzf.fish";
    fish-fzf.flake = false;
  };


  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let
    overlays = [

      (final: prev: rec {
        gh = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.gh;
        claude-code = (import inputs.nixpkgs-unstable {
          inherit (prev) system;
          config.allowUnfree = true;
        }).claude-code;
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    nixosConfigurations.vm-aarch64 = mkSystem "vm-aarch64" {
      system = "aarch64-linux";
      user   = "rami";
    };

    darwinConfigurations.mini = mkSystem "mini" {
      system = "aarch64-darwin";
      user   = "rami";
      darwin = true;
    };
  };
}
