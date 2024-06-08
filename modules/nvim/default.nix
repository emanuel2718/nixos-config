{ inputs, pkgs, lib, ... }:
let
  clone = repo: ref: sha:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "http://github.com/${repo}.git";
        ref = ref;
        rev = sha;
      };
  };

  # fromConfigFile = with pkgs; {};

  in {
    programs.neovim = {
      enable = true;
      viAlias = true;
      # package = pkgs.neovim-nightly.overrideAttrs (_: { CFLAGS = "-O3"; });
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      extraLuaConfig = ''
        ${builtins.readFile lua/core/options.lua}
        ${builtins.readFile lua/core/keymaps.lua}
        ${builtins.readFile lua/core/autocmds.lua}
      '';
      # plugins = with pkgs; [];
    };
  }
