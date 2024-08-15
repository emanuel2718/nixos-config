{ pkgs, lib, ... }:
let
  nerdFonts = [ "JetBrainsMono" "Iosevka" ];
in
{
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  fonts = {
    fontconfig = {
      enable = lib.mkForce true;
      antialias = true; # fix pixelation
     # fix antialiasing blur
      hinting = {
        enable = true;
        style = "full";
        autohint = true;
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
    fontDir.enable = true;
    enableGhostscriptFonts = true;
      packages = [
      (pkgs.nerdfonts.override { fonts = nerdFonts; })
    ] ++ builtins.attrValues {
      inherit (pkgs)

      corefonts  # msft free fonts
      inconsolata  # monospaced
      ubuntu_font_family  # ubuntu fonts
      dejavu_fonts
      freefont_ttf
      ;
    };
  };
}
