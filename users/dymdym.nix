{ pkgs, pkgs-unstable, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    dymdym = {
      # shell = pkgs.fish;
      shell = pkgs.nushell;
      isNormalUser = true;
      description = "dymdym";
      extraGroups = [ "networkmanager" "wheel" ]; # "libvirtd" ];

      # User packages
      packages = 
        (with pkgs; [
          telegram-desktop
          signal-desktop
          android-tools
          lshw
          # support 64-bit only
          (wine.override { wineBuild = "wine64"; })
          # support 64-bit only
          wine64
          # wine-staging (version with experimental features)
          wineWow64Packages.staging
          # winetricks (all versions)
          winetricks
          zoxide
          fd
          usbimager
          jellyfin-mpv-shim
          gnumake
          bat
          awww
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
        (with pkgs-unstable; [
        ]);
    };
  };
}
