{pkgs, ...}: let
  theme = "tokyo-night-dark";
  polarity = "dark";
  wallpaper = "SELInternet.jpg";
in {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    # polarity = "dark";
    inherit polarity;
    autoEnable = true;

    image = ./wallpapers/${wallpaper};

    cursor = {
      package = pkgs.simp1e-cursors;
      name = "Simp1e-Catppuccin-Mocha";
      size = 25;
    };

    targets = {
      fish.enable = true;
      waybar.enable = false;
      ghostty.enable = false;
      rofi.enable = false;
      # gtk.enable = false;
      # qt.enable = false;
      yazi.enable = false;
      librewolf.profileNames = ["dymdym"];
      firefox.profileNames = ["dymdym"];
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVu Sans Mono";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVu Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
