{ config, pkgs, pkgs-unstable, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    dymdym = {
      shell = pkgs.nushell;
      isNormalUser = true;
      # initialPassword = "password123";
      description = "dymdym";
      extraGroups = [ "networkmanager" "wheel" ]; # "libvirtd" ];

      # User packages
      packages = 
        (with pkgs; [
          telegram-desktop
          signal-desktop
          android-tools
          lshw

          zoxide
          fd
          usbimager
          jellyfin-mpv-shim
          gnumake
          bat
          gimp
          zoom
          xautoclick

          qmk
          qbittorrent
          feh
          lean4
          elan
          lazygit
        ])
        ++
        (if config.gaming.enable then
          with pkgs; [
            # support 64-bit only
            (wine.override { wineBuild = "wine64"; })
            # support 64-bit only
            wine64
            # wine-staging (version with experimental features)
            wineWow64Packages.staging
            # winetricks (all versions)
            winetricks
          ]
        else [])
        ++
        (with pkgs-unstable; [
        ]);
    };
  };
}
