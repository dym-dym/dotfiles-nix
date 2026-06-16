# Ed~/.dotfiles/user/sheloit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, ... }:

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
      ../../modules/system-modules.nix

      # Users of the machine
      ../../users
    ];

  options = {
    
    hostname = lib.mkOption {
      type = lib.types.string;
      default = "nixos";
    };

    username = lib.mkOption {
      type = lib.types.string;
      default = "dymdym";
    };

    timezone = lib.mkOption {
      type = lib.types.string;
      default = "Europe/London";
    };

    nvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    extraBootEntries = lib.mkOption {
      type = lib.types.string;
      default = '''';
    };

    secureBoot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    wireless.enable = lib.mkOption {
      types = lib.types.bool;
      default = false;
    };
  };

  config = {
    bluetooth.enable = true;
  };
}
