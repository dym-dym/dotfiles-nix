# Ed~/.dotfiles/user/sheloit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common
      ../../home/config/system-modules.nix
      # Users of the machine
      ../../users
    ];

  config = {
    bluetooth.enable = false;
    hostname = "carcosa";
    nvidia.enable = true;
  };
}
