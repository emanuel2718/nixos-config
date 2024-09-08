{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#111111";
        };
      };
      font = {
        normal = { family = "Terminess Nerd Font"; style = "Regular"; };
      };
      cursor = {
        style = "Beam";
      };
      keyboard = {
        bindings = [
          { key = "C"; mods = "Super"; action = "Copy"; }
          { key = "V"; mods = "Super"; action = "Paste"; }
          { key = "="; mods = "Super"; action = "IncreaseFontSize"; }
          { key = "-"; mods = "Super"; action = "DecreaseFontSize"; }
          { key = "0"; mods = "Super"; action = "ResetFontSize"; }
          { key = "/"; mods = "Super"; action = "SearchNext"; }
        ];
      };
    };
  };

}
