# Ed~/.dotfiles/user/sheloit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, lib, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../modules/system-modules.nix
      # Login Manager
      # VPN
      # ./wireguard.nix
    ];

  # Bootloader.
  # boot.kernelPackages = pkgs.linuxPackages_6_14;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    # systemd-boot.enable = true;
    # systemd-boot.configurationLimit = 5;

    limine = {
      enable = true;
      maxGenerations = 5;
      efiSupport = true;
      secureBoot.enable = false;

      style = {
        interface.resolution = "1920x1080";
        wallpapers = [ "/home/dymdym/.dotfiles/system/disco.png" ];
      };

    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  boot.plymouth = {
    enable = true;
    theme = "owl";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "owl" ];
        })
      ];

  };

  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
  };


  networking = {

    hostName = "nixos"; # Define your hostname.

    # Setup DNS
    nameservers = [ "100.100.100.100" "9.9.9.9" "1.1.1.1" ];

  # Enable networking
    networkmanager.enable = true;
    dhcpcd.extraConfig = ''
      nohook resolv.conf
    '';

    firewall.checkReversePath = false;
  };

  ## == Locales ==

  # Set your time zone.
  # time.timeZone = "Europe/London";
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

  # Configure keymap in X11


  # Configure console keymap
  console.keyMap = "us-acentos";

  # Hardware config
  hardware = {

    uinput.enable = true;

    sane = {
      enable = true;

      extraBackends = [
        pkgs.sane-airscan
        pkgs.hplipWithPlugin
      ];
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
      ];
    };

    keyboard.qmk.enable = true;
  };

  # Nvidia

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
      version = "595.80";

      sha256_64bit = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
      persistencedSha256 = lib.fakeSha256;
    };

    prime = {
      reverseSync.enable = true;
      # sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:60:0:0";
    };
  };

  ## == Audio ==

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber = {
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/11-bluetooth-policy.conf" ''
          wireplumber.settings = { bluetooth.autoswitch-to-headset-profile = false }
        '')
      ];
    };
  };

  ## == Users ==

  # users.users.dymdym.shell = pkgs.fish;
  users.defaultUserShell = pkgs.nushell;
  users.users.dymdym.shell = pkgs.nushell;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dymdym = {
    isNormalUser = true;
    description = "dymdym";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "uinput" "docker" ]; # "libvirtd" ];

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
        wineWowPackages.staging
        # winetricks (all versions)
        winetricks
        wlsunset
        zoxide
        fd
        blueman
        usbimager
        jellyfin-mpv-shim
        gnumake
        bat
        swww
        gimp
        zoom
        xautoclick

        qmk
        qbittorrent
        feh
        lean4
        elan
        vscodium

      ])

      ++

      (with pkgs-unstable; [
      ]);
  };

  ## == Programs and Services ==

  programs = {
    fish.enable = true;
    hyprland.enable = true;
    nm-applet.enable = true;
    pay-respects.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
    niri.enable = true;
    kdeconnect.enable = true;
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [

      # Fish

      # Terminal
	    git
	    fzf
	    grc
	    btop
	    tealdeer
	    eza
	    ripgrep

      # Secure boot
      sbctl

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
	    mpv

      # Sound
	    pavucontrol
	    blueberry

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

      # Niri packages
      niri
      xwayland-satellite
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

      # VPN
      wireguard-tools
      protonvpn-gui

      gamemode
      mangohud
    ])
    ++
    (with pkgs-unstable; [
    ]);

  ## == Environment Variables ==

  environment.sessionVariables = {
    # STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/dymdym/.steam/root/compatibilitytools.d";
  };


  services = {
  	gvfs.enable = true;
  	udisks2.enable = true;
  	devmon.enable = true;
  	upower.enable = true;
  	fwupd.enable = true;

    dbus.packages = [ pkgs.nautilus
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];

    # Enable the OpenSSH daemon.
  	openssh.enable = true;
  	openssh.settings.PasswordAuthentication = true;

    kanata = {
      enable = true;
      keyboards = {
      "laptop".config = ''
(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)

(deflayer capsmod
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  esc  a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
  '';
        };
    };
  # Enable automatic login for the user.
    displayManager.autoLogin = {
      enable = false;
      user = "dymdym";
    };

    avahi.enable = true;
    avahi.nssmdns4 = true;

    xserver = {
      xkb = {
        layout = "us";
        variant = "intl";
      };
      videoDrivers = [ ];
    };
    # Enable CUPS to print documents.
    printing.enable = true;

    udev.enable = true;
  };


  # List services that you want to enable:


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
    services.dlm.wantedBy = [ "multi-user.target" ];
	};

  programs.gnome-disks.enable = true;


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

  # system.autoUpgrade = {
  #  enable = true;
  #  # channel = "https://nixos.org/channels/nixos-24.05";
  #  flake = "github:dym-dym/dotfiles-nix/laptop";
  #  dates = "daily";
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
