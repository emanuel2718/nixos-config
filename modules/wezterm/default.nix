{ pkgs, specialArgs, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
    local wezterm = require("wezterm")
    local act = wezterm.action
    local config = {}

    if wezterm.config_builder then
      config = wezterm.config_builder()
    end

    config.warn_about_missing_glyphs = false

    config.color_scheme = 'Pastel White (terminal.sexy)'

    config.animation_fps = 1

    config.enable_tab_bar = false
    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true

    config.window_close_confirmation = "NeverPrompt"
    config.audible_bell = "Disabled"
    config.cursor_thickness = "1"

    config.enable_scroll_bar = false
    config.adjust_window_size_when_changing_font_size = false
    config.window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
    }

    config.keys = {
      { key = "/", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
    }

    return config
    '';
  };
}
