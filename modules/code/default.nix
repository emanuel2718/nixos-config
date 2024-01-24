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

      # formatters and linters
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      christian-kohler.path-intellisense
      github.copilot
      vscodePkgs.volar
    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";

      "editor.accessibilitySupport" = "off";
      "editor.hover.sticky" = true;
      "editor.guides.identation" = false;
      "editor.minimap.enabled" = false;

      "workbench.sideBar.location" = "right";

      # Language settings
      "[rust]"."editor.tabSize" = 4;
      "[cpp]"."editor.tabSize" = 4;
      "[c]"."editor.tabSize" = 4;
      "[nix]"."editor.tabSize" = 2;
      "[vue]" = {
        "editor.tabSize" = 2;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.tabSize" = 2;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.tabSize" = 2;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      # Vim
      "vim.leader" = "<space>";
      "vim.normalModeKeyBindings" = [
        {
          before = ["K"];
          commands = ["editor.action.showHover"];
        }
        {
          before = ["<C-c>"];
          commands = ["editor.action.quickFix"];
        }
        {
          before = [ "leader" "f" "s" ];
          commands = ["workbench.action.files.save"];
        }
        {
          before = [ "leader" "." ];
          commands = ["workbench.action.quickOpen"];
        }
        {
          before = [ "leader" "o" ];
          commands = ["workbench.action.closeEditorsInGroup"];
        }
        {
          before = [ "leader" "m" ];
          commands = ["workbench.action.splitEditor"];
        }
        {
          before = [ "leader" "n" ];
          commands = ["workbench.action.splitEditorDown"];
        }
        {
          before = [ "leader" "s" "i" ];
          commands = ["workbench.action.showAllSymbols"];
        }
        {
          before = [ "leader" "s" "p" ];
          commands = ["workbench.action.findInFiles"];
        }
        {
          before = [ "leader" "l" "f" ];
          commands = ["editor.action.format"];
        }
        {
          before = [ "leader" "h" "t" ];
          commands = ["workbench.action.selectTheme"];
        }
      ];
      "vim.visualModeKeyBindings" = [
        { before = [">"]; commands = ["editor.action.indentLines"]; }
        { before = ["<"]; commands = ["editor.action.outdentLines"]; }
        { before = ["<S-j>"]; commands = ["editor.action.moveLinesDownAction"]; }
        { before = ["<S-k>"]; commands = ["editor.action.moveLinesUpAction"]; }
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
