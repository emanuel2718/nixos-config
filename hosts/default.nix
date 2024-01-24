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
  vm-x86 = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user pkgs; };
    modules = [
      ./vm-x86/configuration.nix
      ./vm-x86/hardware.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = let
          host = "vm-x86";
        in {
          inherit user inputs host;
        };
        home-manager.users.${user} = import ../nix/home-manager.nix;
      }
    ];
  };
  x220 = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user pkgs; };
    modules = [
      ./x220/configuration.nix
      ./x220/hardware.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = let
          host = "x220";
        in {
          inherit user inputs host;
        };
        home-manager.users.${user} = import ../nix/home-manager.nix;
      }
    ];
  };
  blade = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user pkgs; };
    modules = [
      ./blade/configuration.nix
      ./blade/hardware.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = let
          host = "blade";
        in {
          inherit user inputs host;
        };
        home-manager.users.${user} = import ../nix/home-manager.nix;
      }
    ];
  };
}
