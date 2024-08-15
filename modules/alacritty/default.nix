{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
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
