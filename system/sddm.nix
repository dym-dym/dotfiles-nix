{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [(
    pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./background.jpg}";
      loginBackground = true;
    }
  )];

  services.xserver.resolutions = [
    {
      x = 1920;
      y = 1080;
    }
  ];

  services.displayManager.sddm = {
    enable = true; # Enable SDDM.

    wayland = {
      enable = true;
    };

    theme = "catppuccin-mocha";
    enableHidpi = true;

    autoNumlock = true;

#    sugarCandyNix = {
#      enable = false; # This set SDDM's theme to "sddm-sugar-candy-nix".
#      settings = {
#        # Set your configuration options here.
#        # Here is a simple example:
#        Background = lib.cleanSource ./background.jpg;
#        ScreenWidth = 1920;
#        ScreenHeight = 1080;
#        FormPosition = "left";
#        HaveFormBackground = true;
#        PartialBlur = true;
#        # ...
#      };
#   };
  };
}
