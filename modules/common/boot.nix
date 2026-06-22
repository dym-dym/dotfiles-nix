{
  config,
  pkgs,
  ...
}: {
  # Bootloader.

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams =
      [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ]
      ++ (
        if config.nvidia.enable
        then ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"]
        else []
      );

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      limine = {
        enable = true;
        maxGenerations = 5;
        efiSupport = true;
        secureBoot.enable = config.secureBoot.enable;

        style = {
          interface.resolution = "1920x1080";
          wallpapers = ["/home/dymdym/.dotfiles/modules/common/disco.png"];
        };

        extraEntries = config.extraBootEntries;
      };
    };

    plymouth = {
      enable = true;
      theme = "owl";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = ["owl"];
        })
      ];
    };
  };
}
