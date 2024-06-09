{ pkgs ? import
  (fetchTarball "https://github.com/NixOS/nixpkgs/archive/release-24.05.tar.gz")
  { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # nixpkgs-fmt
    # rnix-lsp
    # docker-client
    gnumake

    # go development
    go
    go-outline
    gopls
    gopkgs
    go-tools
    delve
  ];

  hardeningDisable = [ "all" ];
}
