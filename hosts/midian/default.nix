# Ed~/.dotfiles/user/sheloit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./hardware-configuration.nix
      ../../modules/common/boot.nix
      ../../modules/common/hardware.nix
      ../../modules/common/networking.nix
      ../../modules/common/packages.nix
      ../../modules/common/services.nix
      ../../modules/common/systemd.nix
      #../../modules/common/virtualisation.nix
      ../../modules/common/xdg.nix
      ../../modules/common/misc.nix
      ../../modules/common/utils/options.nix


      ../../modules/system-modules.nix

      # Users of the machine
      ../../users
    ];

  config = {
    bluetooth.enable = true;
    hostname = "midian";
    nvidia.enable = true;
  };
}
