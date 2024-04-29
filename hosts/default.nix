{ inputs, nixpkgs, home-manager, user, ... }:
let
  system = "x86_64-linux";
  overlays = [ inputs.neovim-nightly-overlay.overlay ];
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = overlays;
  };

  makeSystem = hostName: nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user pkgs; };
    modules = [
      ./${hostName}/configuration.nix
      ./${hostName}/hardware.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user inputs;
          host = hostName;
        };
        home-manager.users.${user} = import ../nix/home-manager.nix;
      }
    ];
  };
in {
  vm-x86 = makeSystem "vm-x86";
  x220 = makeSystem "x220";
  blade = makeSystem "blade";
}
