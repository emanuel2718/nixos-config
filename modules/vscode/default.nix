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
    # vueTypescript = pkgs.vscode-utils.extensionFromVscodeMarketplace {
    #   # https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin
    #   publisher = "Vue";
    #   name = "vscode-typescript-vue-plugin";
    #   version = "1.8.27";
    #   sha256 = "sha256-ym1+WPKBcn4h9lqSFVehfiDoGUEviOSEVXVLhHcYvfc=";

    # };
  };
in
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      alefragnani.project-manager
      editorconfig.editorconfig
      christian-kohler.path-intellisense
      github.copilot

      # languages
      bbenoist.nix
      rust-lang.rust-analyzer
      ms-python.python
      yzhang.markdown-all-in-one
      sumneko.lua
      bmewburn.vscode-intelephense-client
      redhat.vscode-yaml
      bradlc.vscode-tailwindcss
      ms-vscode.cpptools
      vscodePkgs.volar
      # vscodePkgs.vueTypescript

      # formatters and linters
      esbenp.prettier-vscode
      ms-python.isort
      ms-python.black-formatter
      dbaeumer.vscode-eslint
      brettm12345.nixfmt-vscode

    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";

      "editor.fontSize" = 16;
      # "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.tabSize" = 2;
      "window.zoomLevel" = 0;
      "editor.fontFamily" = "Terminess Nerd Font";
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

      "workbench.colorTheme" = "Gruber Darker";
      "workbench.settings.editor" = "json";
      "workbench.editor.closeFileOnDelete" = true;
      "workbench.editor.highlightModifiedTabs" = true;
      "workbench.panel.defaultLocation" = "bottom";
      "workbench.sideBar.location" = "right";
      "workbench.activityBar.location" = "top";

      "window.titleBarStyle" = "custom";
      "window.commandCenter" = false;
      "window.menuBarVisibility" = "toggle";

      "explorer.compactFolders" = false;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      "search.smartCase" = true;
      "search.quickOpen.includeHistory" = false;
      "search.exclude" = {
        "**/.nuxt" = true;
        "**/node_modules" = true;
        "**/.git" = true;
        "**/.turbo" = true;
        "**/dist" = true;
        "**/out" = true;
        "**/*.code-search" = true;
        "**/.github" = true;
        "**/.output" = true;
        "**/.pnpm" = true;
        "**/.vscode" = true;
        "**/.yarn" = true;
        "**/bower_components" = true;
        "**/dist/**" = true;
        "**/logs" = true;
        "**/out/**" = true;
        "**/package-lock.json" = true;
        "**/pnpm-lock.yaml" = true;
        "**/tmp" = true;
        "**/yarn.lock" = true;
      };

      # Language settings
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
      "nixfmt.path" = pkgs.nixfmt + /bin/nixfmt;
      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.indent_size" = 2;
        "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
      };

      # Vim
      "vim.leader" = "<space>";
      "vim.easymotion" = true;
      "vim.smartcase" = true;
      "vim.incsearch" = true;
      "vim.hlsearch" = true;
      "vim.useSystemClipboard" = false;
      "vim.useCtrlKeys" = true;
      "vim.highlightedyank.enable" = true;
      "vim.highlightedyank.color" = "rgba(255, 140, 0, 0.5)";
      "vim.normalModeKeyBindingsNonRecursive" = [
        { before = [ "K" ]; commands = [ "editor.action.showHover" ]; }
        { before = ["g" "l"]; commands = ["editor.action.showDefinitionPreviewHover"]; } 
        { before = [ "<C-c>" ]; commands = [ "editor.action.quickFix" ]; }
        { before = [ "leader" "f" "s" ]; commands = [ "workbench.action.files.save" ]; }
        { before = [ "leader" "." ]; commands = [ "workbench.action.quickOpen" ]; }
        { before = [ "leader" "o" ]; commands = [ "workbench.action.closeEditorsInGroup" ]; }
        { before = [ "leader" "m" ]; commands = [ "workbench.action.splitEditor" ]; }
        { before = [ "leader" "n" ]; commands = [ "workbench.action.splitEditorDown" ]; }

        { before = [ "leader" "s" "i" ]; commands = [ "workbench.action.showAllSymbols" ]; }
        { before = [ "leader" "s" "p" ]; commands = [ "workbench.action.findInFiles" ]; }
        { before = [ "leader" "l" "f" ]; commands = [ "editor.action.format" ]; }
        { before = [ "leader" "h" "t" ]; commands = [ "workbench.action.selectTheme" ]; }
        { before = [ "<S-h>" ]; commands = [ ":bprevious" ]; }
        { before = [ "<S-l>" ]; commands = [ ":bnext" ]; }
        { before = ["[" "d"]; commands = ["editor.action.marker.prev"]; }
        { before = ["]" "d"]; commands = ["editor.action.marker.next"]; }
      ];
      "vim.visualModeKeyBindings" = [
        { before = [ ">" ]; commands = [ "editor.action.indentLines" ]; }
        { before = [ "<" ]; commands = [ "editor.action.outdentLines" ]; }
        { before = [ "<S-j>" ]; commands = [ "editor.action.moveLinesDownAction" ]; }
        { before = [ "<S-k>" ]; commands = [ "editor.action.moveLinesUpAction" ]; }
      ];
    };
    keybindings = [
      { key = "ctrl+h"; command = "workbench.action.navigateLeft"; }
      { key = "ctrl+l"; command = "workbench.action.navigateRight"; }

      { key = "ctrl+k"; command = "workbench.action.navigateUp"; when = "!inQuickOpen || !suggestWidgetVisible || !codeActionMenuVisible"; }
      { key = "ctrl+j"; command = "workbench.action.navigateDown"; when = "!inQuickOpen || !suggestWidgetVisible || !codeActionMenuVisible"; }

      { key = "ctrl+k"; command = "workbench.action.quickOpenSelectPrevious"; when = "inQuickOpen"; }
      { key = "ctrl+j"; command = "workbench.action.quickOpenSelectNext"; when = "inQuickOpen"; }

      { key = "ctrl+k"; command = "selectPrevSuggestion"; when = "suggestWidgetVisible && textInputFocus"; }
      { key = "ctrl+j"; command = "selectNextSuggestion"; when = "suggestWidgetVisible && textInputFocus"; }

      { key = "ctrl+k"; command = "selectPrevCodeAction"; when = "codeActionMenuVisible"; }
      { key = "ctrl+j"; command = "selectNextCodeAction"; when = "codeActionMenuVisible"; }


      { key = "ctrl+f"; command = "workbench.action.findInFiles"; }
      { key = "cmd+p"; command = "workbench.action.showCommands"; }
      { key = "cmd+c"; command = "editor.action.clipboardCopyAction"; }
      { key = "cmd+v"; command = "editor.action.clipboardPasteAction"; }
      { key = "cmd+."; command = "editor.action.triggerParameterHints"; when = "editorHasSignatureHelpProvider && editorTextFocus"; }
      { key = "ctrl+y"; command = "editor.action.inlineSuggest.commit"; when = "editorFocus"; }

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
