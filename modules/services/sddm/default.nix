{ config, lib, pkgs, ... }:
let
  sddm-astronaut-custom = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura"; # The name of the theme you most loved
    # themeConfig = {
    #   Background = "../../../user/wallpapers/Cloudsday.jpg"; # This theme also accepts videos
    # };
  };
in
{

  options = {
    sddm.enable = lib.mkEnableOption "enable SDDM";
  };

  config = lib.mkIf config.sddm.enable {

    environment.systemPackages = with pkgs; [
      sddm-astronaut-custom
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard

    ];

    services.xserver.displayManager.setupCommands = ''
/run/current-system/sw/bin/xrandr --output DP-1 --primary
/run/current-system/sw/bin/xrandr --output HDMI-A-2 --left-of DisplayPort-0
    '';

    services.xserver.resolutions = [
      {
        x = 1920;
        y = 1200;
      }
    ];

    services.xserver.enable = true;


    services.displayManager.sddm = {

      extraPackages = with pkgs; [
        sddm-astronaut
      ];

      enable = true; # Enable SDDM.

      package = pkgs.kdePackages.sddm;

      wayland = {
        enable = true;
        compositor = "kwin";
      };

      theme = "sddm-astronaut-custom";
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme"; # Remains the same
        };
      };

      enableHidpi = true;

      autoNumlock = true;
    };
  };
}
