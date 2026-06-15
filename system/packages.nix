{ pkgs, pkgs-unstable, inputs, ... }:
{
  programs = {
    fish.enable = true;
    nm-applet.enable = true;
    pay-respects.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
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
	    fzf
	    grc
	    btop
	    tealdeer
	    eza
	    ripgrep


      # Window Manager
	    swaybg
	    waypaper
	    wttrbar
	    sway-contrib.grimshot

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
	    jellyfin-media-player
      jellyfin-mpv-shim
	    mpv
      obs-studio

      # Sound
	    pavucontrol

      # Misc
	    thunderbird
	    mangohud
	    discord-canary
	    discord
	    protonup-ng
      networkmanagerapplet
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
      wireguard-tools
      proton-vpn

      gamemode
      gnome-keyring
    ])
    ++
    (with pkgs-unstable; [
      # linuxPackages.nvidia_x11_beta
    ]);
}
