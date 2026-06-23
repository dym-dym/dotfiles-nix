{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  programs = {
    fish.enable = true;
    nm-applet.enable = true;
    pay-respects.enable = true;
    steam = {
      enable = config.gaming.enable;
      gamescopeSession.enable = config.gaming.enable;
    };
    gamescope.enable = config.gaming.enable;
    niri.enable = true;
    kdeconnect.enable = true;
    gnome-disks.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      # Terminal
      git
      git-crypt
      fzf
      grc
      btop
      tealdeer
      eza
      ripgrep

      # File explorers
      pcmanfm
      nautilus

      # Fonts (and TeX)

      # nerdfonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      font-awesome
      nerd-fonts.noto
      noto-fonts
      noto-fonts-color-emoji

      texliveFull

      # Media
      # jellyfin-media-player
      jellyfin-mpv-shim
      mpv

      # Sound
      pavucontrol

      # Misc
      thunderbird
      discord
      simple-scan
      libreoffice
      kanata

      egl-wayland

      # Secure boot
      sbctl

      # Niri packages
      niri
      xwayland-satellite
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

      # VPN
      proton-vpn

      gnome-keyring
      inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    ])
    ++ (
      if config.gaming.enable
      then
        with pkgs; [
          protonup-ng
          mangohud
          gamemode
        ]
      else []
    )
    ++ (with pkgs-unstable; [
      # linuxPackages.nvidia_x11_beta
    ]);
}
