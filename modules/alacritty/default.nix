{ pkgs, specialArgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#000000";
        };
      };
      font = {
        # normal = {
        #   family = "JetBrainsMono Nerd Font";
        #   style = "Medium";
        # };
        size = 10;
      };
      keyboard.bindings = [
        { key = "C"; mods = "Super"; action = "Copy"; }
        { key = "V"; mods = "Super"; action = "Paste"; }
        { key = "="; mods = "Super"; action = "IncreaseFontSize"; }
        { key = "-"; mods = "Super"; action = "DecreaseFontSize"; }
        { key = "/"; mods = "Super"; action = "SearchForward"; }
        { key = "v"; mods = "Super | Shift"; action = "ToggleViMode"; }
      ];
      selection.save_to_clipboard = true;
      shell.program = "${pkgs.fish}/bin/fish";
      window = {
        decorations = "full";
        padding = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
