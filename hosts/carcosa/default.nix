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
      ../../modules/common/utils/options.nix


      ../../modules/system-modules.nix

      # Users of the machine
      ../../users
    ];

  config = {
    bluetooth.enable = true;
    hostname = "nixos";
    nvidia.enable = true;

    extraBootEntries = ''
/+CachyOS
//Cachy OS
  protocol: linux
  path: uuid(13f1af99-7bf1-4b82-a97d-a9e780265198):/vmlinuz-linux-cachyos
  cmdline: rootflags=subvol=/@ root=UUID=71f0dfa0-c386-44f8-93df-b3ad9ae5affb quiet udev.log_level=3 systemd.show_status=auto nvidia-drm.modeset=1 nvidia-drm.fbdev=1 splash loglevel=3 lsm=landlock,yama,bpf rw
  module_path: uuid(13f1af99-7bf1-4b82-a97d-a9e780265198):/initramfs-linux-cachyos.img
//Cachy OS LTS
  protocol: linux
  path: uuid(13f1af99-7bf1-4b82-a97d-a9e780265198):/vmlinuz-linux-cachyos-lts
  cmdline: rootflags=subvol=/@ root=UUID=71f0dfa0-c386-44f8-93df-b3ad9ae5affb quiet udev.log_level=3 systemd.show_status=auto nvidia-drm.modeset=1 nvidia-drm.fbdev=1 splash loglevel=3 lsm=landlock,yama,bpf rw
  module_path: uuid(13f1af99-7bf1-4b82-a97d-a9e780265198):/initramfs-linux-cachyos-lts.img
'';
  };
}
