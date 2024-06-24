{ pkgs, ... }:
let
  vscodePkgs = {
    volar = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      # https://marketplace.visualstudio.com/items?itemName=Vue.volar
      publisher = "Vue";
      name = "volar";
      version = "2.0.21";
      sha256 = "sha256-7GyCilXKo4YEuHxZJmglLKeS+67vSLem8aO4+NKLD5U=";

    };
  };
in {
  programs.vscode = {
    enable = true;
      extensions = with pkgs.vscode-extensions; [
      vscodevim.vim

      # qol
      editorconfig.editorconfig
      christian-kohler.path-intellisense
      github.copilot


      # theme
      jdinhlife.gruvbox

      # lsp
      sumneko.lua
      bbenoist.nix
      ms-python.python
       ms-vscode.cpptools
      rust-lang.rust-analyzer
      bradlc.vscode-tailwindcss
      vscodePkgs.volar


      # formatters/linters
      esbenp.prettier-vscode
      ms-python.isort
      ms-python.black-formatter
      dbaeumer.vscode-eslint
      brettm12345.nixfmt-vscode
    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.settings.editor" = "json";
      "workbench.editor.closeFileOnDelete" = true;
      "workbench.panel.defaultLocation" = "bottom";
      "workbench.sideBar.location" = "right";
      "workbench.activityBar.location" = "top";

      "window.titleBarStyle" = "custom";
      "window.commandCenter" = false;
      "window.menuBarVisibility" = "toggle";

      "search.smartCase" = true;
      "search.quickOpen.includeHistory" = false;


      "editor.accessibilitySupport" = "off";
      "editor.hover.sticky" = true;
      "editor.guides.identation" = false;
      "editor.minimap.enabled" = false;
      "editor.inlayHints.enbled" = false;
      "editor.lightbulb.enabled" = false;
      "editor.renderWhitespace" = "trailing";
      "editor.scrollbar.horizontal" = "hidden";
      "editor.scrollbar.vertical" = "hidden";
      "editor.suggestSelection" = "first";
      "editor.wordWrap" = "off";
      "editor.quickSuggestions" = {
      "other" = "on";
        "strings" = "on";
        "comments" = "off";
      };

      "[rust]"."editor.tabSize" = 4;
      "[lua]"."editor.tabSize" = 2;
      "[cpp]"."editor.tabSize" = 4;
      "[c]"."editor.tabSize" = 4;
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

      "nixfmt.path" = pkgs.nixfmt-rfc-style + /bin/nixfmt;
      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.indent_size" = 2;
        "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
      };

      "vim.leader" = "<space>";
      "vim.easymotion" = true;
      "vim.smartcase" = true;
      "vim.incsearch" = true;
      "vim.hlsearch" = true;
      "vim.useSystemClipboard" = false;
      "vim.useCtrlKeys" = true;
      "vim.highlightedyank.enable" = true;
      "vim.highlightedyank.color" = "rgba(255, 140, 0, 0.5)";
      "vim.normalModeKeyBindings" = [
        { before = [ "leader" "f" "s" ]; commands = [ "workbench.action.files.save" ]; }
        { before = [ "leader" "." ]; commands = [ "workbench.action.quickOpen" ]; }
        { before = [ "K" ]; commands = [ "editor.action.showHover" ]; }
        { before = [ "<C-c>" ]; commands = [ "editor.action.quickFix" ]; }
        { before = [ "leader" "o" ]; commands = [ "workbench.action.closeEditorsInGroup" ]; }
        { before = [ "leader" "m" ]; commands = [ "workbench.action.splitEditor" ]; }
        { before = [ "leader" "n" ]; commands = [ "workbench.action.splitEditorDown" ]; }
        { before = [ "leader" "s" "i" ]; commands = [ "workbench.action.showAllSymbols" ]; }
        { before = [ "leader" "s" "p" ]; commands = [ "workbench.action.findInFiles" ]; }
        { before = [ "leader" "l" "f" ]; commands = [ "editor.action.format" ]; }
        { before = [ "leader" "h" "t" ]; commands = [ "workbench.action.selectTheme" ]; }
        { before = [ "leader" "j" ]; commands = [ "editor.action.marker.nextInFiles" ]; }
        { before = [ "leader" "k" ]; commands = [ "editor.action.marker.prevInFiles" ]; }
        { before = [ "leader" "r" "n" ]; commands = [ "editor.action.rename" ]; }
      ];
      "vim.visualModeKeyBindings" = [
        { before = [ ">" ]; commands = [ "editor.action.indentLines" ]; }
        { before = [ "<" ]; commands = [ "editor.action.outdentLines" ]; }
        { before = [ "<S-j>" ]; commands = [ "editor.action.moveLinesDownAction" ]; }
        { before = [ "<S-k>" ]; commands = [ "editor.action.moveLinesUpAction" ]; }
      ];
    };
     keybindings = [
      { key = "cmd+p"; command = "workbench.action.showCommands"; }
      { key = "cmd+c"; command = "editor.action.clipboardCopyAction"; }
      { key = "cmd+v"; command = "editor.action.clipboardPasteAction"; }
      { key = "cmd+."; command = "editor.action.triggerParameterHints"; when = "editorHasSignatureHelpProvider && editorTextFocus"; }
      { key = "ctrl+f"; command = "editor.action.inlineSuggest.commit"; when = "editorFocus"; }

      { key = "ctrl+;"; command = "workbench.action.toggleActivityBarVisibility"; }
      { key = "ctrl+e"; command = "workbench.action.toggleSidebarVisibility"; }
      { key = "ctrl+e"; command = "workbench.files.action.focusFilesExplorer"; when = "editorTextFocus"; }
      { key = "ctrl+t"; command = "workbench.action.terminal.toggleTerminal"; }

      { key = "a"; command = "explorer.newFile"; when = "filesExplorerFocus && !inputFocus"; }
      { key = "r"; command = "renameFile"; when = "filesExplorerFocus && !inputFocus"; }
      { key = "d"; command = "deleteFile"; when = "filesExplorerFocus && !inputFocus"; }
      { key = "c"; command = "filesExplorer.copy"; when = "filesExplorerFocus && !inputFocus"; }
      { key = "p"; command = "filesExplorer.paste"; when = "filesExplorerFocus && !inputFocus"; }
      { key = "Enter"; command = "filesExplorer.openFilePreserveFocus"; when = "filesExplorerFocus && !inputFocus"; }
    ];
  };
}
