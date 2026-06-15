{ pkgs, ... }:
{
  # Bootloader.

  boot = {

    kernelPackages = pkgs.linuxPackages_latest;

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ];

    loader = {

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      limine = {
        enable = true;
        maxGenerations = 5;
        efiSupport = true;
        secureBoot.enable = false;

        style = {
          interface.resolution = "1920x1080";
          wallpapers = [ "/home/dymdym/.dotfiles/system/disco.png" ];
        };

        extraEntries = ''
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
    };

    plymouth = {
      enable = true;
      theme = "owl";
        themePackages = with pkgs; [
          # By default we would install all themes
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "owl" ];
          })
        ];

    };
  };
}
