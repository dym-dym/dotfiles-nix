{ config, lib, pkgs, ... }:
let
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ./tokyo-night-sddm { };
  sugar-dark-sddm = pkgs.libsForQt5.callPackage ./sugar-dark-sddm { };
  eucalyptus-drop-sddm = pkgs.libsForQt5.callPackage ./eucalyptus-drop-sddm { };
in
{

  options = {
    sddm.enable = lib.mkEnableOption "enable SDDM";
  };

  config = lib.mkIf config.sddm.enable {

    environment.systemPackages = with pkgs; [
      tokyo-night-sddm
      sugar-dark-sddm
      eucalyptus-drop-sddm
    ];

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

      # theme = "sugar-dark-sddm";
      theme = "sugar-dark-sddm";
      enableHidpi = true;

      autoNumlock = true;
    };
  };
}
