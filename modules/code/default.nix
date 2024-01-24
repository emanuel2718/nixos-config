{ pkgs, ... }:
let
  vscodePkgs = {
    volar = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      # https://marketplace.visualstudio.com/items?itemName=Vue.volar
      publisher = "Vue";
      name = "volar";
      version = "1.8.27";
      sha256 = "sha256-6FktlAJmOD3dQNn2TV83ROw41NXZ/MgquB0RFQqwwW0=";
    };
  };
in {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim

      # languages
      bbenoist.nix
      brettm12345.nixfmt-vscode
      rust-lang.rust-analyzer
      ms-python.python
      yzhang.markdown-all-in-one

      github.copilot
      vscodePkgs.volar
    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "[nix]"."editor.tabSize" = 2;
      "editor.minimap.enabled" = false;
      "vim.leader" = "<space>";
      "vim.normalModeKeyBindings" = [
        {
          before = [ "leader" "." ];
          commands = ["workbench.action.quickOpen"];
        }
      ];
    };
    keybindings = [
      {
        key = "ctrl+f";
        command = "workbench.action.findInFiles";
      }
      {
        key = "cmd+p";
        command = "workbench.action.showCommands";
      }
    ];
  };
}
