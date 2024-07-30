# Ed~/.dotfiles/user/sheloit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../modules/system-modules.nix
      # Login Manager
      # ./sddm.nix
      # VPN
      # ./wireguard.nix
    ];

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5;
    # systemd-boot.device = "/dev/nvme0n1p3";
    # grub = {
      # enable = false;
      # useOSProber = true;
      # device = "/dev/nvme0n1p3";
    # };
  };

  ## == Network ==

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Setup DNS
  networking.nameservers = [ "9.9.9.9" ];

  ## == Locales ==

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  ## == Graphical Settings ==

  # Enable the KDE Plasma Desktop Environment.
   #  services.displayManager.sddm.enable = true;
   # services.displayManager.sddm.wayland.enable = true;
  # services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "intl";
    };
    videoDrivers = [ "nvidia" ];
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  #NvidiaConfig
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        vaapiIntel
        libvdpau-va-gl
        intel-media-driver
      ];
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "#nvidia-x11"
    ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.58";

      sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
      persistencedSha256 = lib.fakeSha256;
    };

    # Value of package if you want to get back to stable branch
    # config.boot.kernelPackages.nvidiaPackages.beta;

    prime = {
      reverseSync.enable = true;
      # sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:60:0:0";
    };
  };

  ## == Audio ==

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  ## == Users ==

  users.users.dymdym.shell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dymdym = {
    isNormalUser = true;
    description = "dymdym";
    extraGroups = [ "networkmanager" "wheel" ]; # "libvirtd" ];

    # User packages
    packages = 
      (with pkgs; [
        # kdePackages.kate
        # thunderbird
        telegram-desktop
        element-desktop
        signal-desktop
        whatsapp-for-linux
        android-tools
        neofetch
        lshw
        # atuin
        spotify
        # support 64-bit only
        (wine.override { wineBuild = "wine64"; })
        # support 64-bit only
        wine64
        # wine-staging (version with experimental features)
        wineWowPackages.staging
        # winetricks (all versions)
        winetricks
        wlsunset
        zoxide
        fd
        blueman
        anki
      ])

      ++

      (with pkgs-unstable; [
      ]);
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin = { 
    enable = false;
    user = "dymdym";
  };

  ## == Programs and Services ==

  programs = {
    # firefox.enable = true;
    fish.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
    nm-applet.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = 
    (with pkgs; [

      # Fish 
	    fishPlugins.done
	    fishPlugins.fzf-fish
	    fishPlugins.forgit
	    fishPlugins.hydro
	    fishPlugins.grc

      # Terminal
	    git
      # neovim
	    fzf
	    grc
      # starship
      # alacritty
	    btop
	    tealdeer
	    eza
	    ripgrep

      # Window Manager
      # wofi
      # waybar
	    swaybg
	    waypaper
	    wttrbar
      # wlogout
      # hyprlock
	    sway-contrib.grimshot

      # File explorers
	    pcmanfm
	    gnome.nautilus
	    kio-admin

      # Fonts (and TeX)

      nerdfonts
      jetbrains-mono
	    fira-code-nerdfont
	    font-awesome
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji

      # texliveFull

      # Browsers
      # librewolf
      # qutebrowser

      # Media
	    jellyfin-media-player
	    mpv
      obs-studio

      # Sound
	    pavucontrol
	    blueberry

      # Misc
	    thunderbird
	    mangohud
	    heroic
	    discord
	    protonup
      networkmanagerapplet
    ])
    ++
    (with pkgs-unstable; [
    ]);


  ## == Environment Variables ==

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/dymdym/.steam/root/compatibilitytools.d";
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  systemd = {
	  user.services.polkit-gnome-authentication-agent-1 = {
	    description = "polkit-gnome-authentication-agent-1";
	    wantedBy = [ "graphical-session.target" ];
	    wants = [ "graphical-session.target" ];
	    after = [ "graphical-session.target" ];
	    serviceConfig = {
	        Type = "simple";
	        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	        Restart = "on-failure";
	        RestartSec = 1;
	        TimeoutStopSec = 10;
	      };
	  };
	};

  # stylix = {
  #   enable = true;
  #   polarity = "dark";
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  #   image = ../user/wallpapers/Cloudsnight.jpg;
  #
  #   cursor.package = pkgs.simp1e-cursors;
  #   cursor.name = "Simp1e-Catppuccin-Mocha";
  #   cursor.size = 25;
  #
  #   targets = {
  #     fish.enable = false;
  #   };
  #
  #  fonts = {
  #
  #    monospace = {
  #       package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
  #      name = "FiraCode Nerd Font Mono";
  #    };
  #    sansSerif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Sans";
  #    };
  #    serif = {
  #      package = pkgs.dejavu_fonts;
  #      name = "DejaVu Serif";
  #    };
  #     emoji = {
  #       package = pkgs.noto-fonts-emoji;
  #       name = "Noto Color Emoji";
  #     };
  #   };
  # };

  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  ## == Updates ==

  #Garbage colector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  system.autoUpgrade = {
   enable = true;
   channel = "https://nixos.org/channels/nixos-24.05";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
