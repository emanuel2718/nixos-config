{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one

      # lsp
      bbenoist.nix
      ms-python.python
      ms-pyright.pyright

      # formatters/linters
      ms-python.isort
      ms-python.black-formatter
      brettm12345.nixfmt-vscode

    ];
    userSettings = {
      "telemetry.telemeryLevel" = "off";
      "workbench.editor.closeFileOnDelete" = true;
      "workbench.panel.defaultLocation" = "bottom";
      "workbench.sideBar.location" = "right";
      "workbench.activityBar.location" = "top";

      "nixfmt.path" = pkgs.nixfmt-rfc-style + /bin/nixfmt;
      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.indent_size" = 2;
        "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
      };
    };
  };
}
