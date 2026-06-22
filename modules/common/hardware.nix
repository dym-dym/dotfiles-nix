{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./nvidia.nix];

  hardware = {
    bluetooth.enable = config.bluetooth.enable;

    keyboard.qmk.enable = true;

    graphics = {
      enable = true;
      extraPackages = with pkgs; (
        if config.nvidia.enable
        then [
          #vaapiVdpau
          libva-vdpau-driver
          libvdpau
          libvdpau-va-gl
          nvidia-vaapi-driver
          vdpauinfo
          libva
          libva-utils
        ]
        else []
      );
    };
  };
}
