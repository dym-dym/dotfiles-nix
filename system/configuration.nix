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
      # ./sddm.nix
      # VPN
      # ./wireguard.nix
    ];

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest;


  boot.loader = {

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

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

  # boot.loader = {
  #   systemd-boot.enable = true;
  #   systemd-boot.configurationLimit = 20;
  #   # systemd-boot.device = "/dev/nvme0n1p3";
  #   # grub = {
  #     # enable = false;
  #     # useOSProber = true;
  #     # device = "/dev/nvme0n1p3";
  #   # };
  };
  # boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11_beta ];

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
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ];
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
  time.timeZone = "Europe/London";

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
    keyboard.qmk.enable = true;
    # graphics.enable = true;
    graphics = {
      enable = true;
      # driSupport = true;
      # driSupport32Bit = true;
      extraPackages = with pkgs; [
        #vaapiVdpau
        libva-vdpau-driver
        libvdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        vdpauinfo
        libva
        libva-utils
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
      version = "610.43.02";

      sha256_64bit = "sha256-MDSgVLtM33dS/43CclZMsQVROAS/9TU4lFkBsWyndGM=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
      persistencedSha256 = lib.fakeSha256;
    };

    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "560.31.02";
    #
    #   sha256_64bit = "sha256-0cwgejoFsefl2M6jdWZC+CKc58CqOXDjSi4saVPNKY0=";
    #   sha256_aarch64 = lib.fakeSha256;
    #   openSha256 = lib.fakeSha256;
    #   settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
    #   persistencedSha256 = lib.fakeSha256;
    # };

    # Value of package if you want to get back to stable branch
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
    # package = config.boot.kernelPackages.nvidiaPackages.stable;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  ## == Users ==

  # users.users.dymdym.shell = pkgs.fish;
  users.defaultUserShell = pkgs.nushell;
  users.users.dymdym.shell = pkgs.nushell;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dymdym = {
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

	    protonup-ng
      networkmanagerapplet
      egl-wayland

      blueberry

      # Secure boot
      sbctl

      # Niri packages
      niri
      xwayland-satellite
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

      # VPN
      wireguard-tools
      protonvpn-gui

      gamemode
      gnome-keyring
    ])
    ++
    (with pkgs-unstable; [
      # linuxPackages.nvidia_x11_beta
    ]);


  ## == Environment Variables ==

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/dymdym/.steam/root/compatibilitytools.d";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "niri";
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



    avahi.enable = true;
    avahi.nssmdns4 = true;
    #
    # xserver = {
    #   xkb = {
    #     layout = "us";
    #     variant = "intl";
    #   };
    #   videoDrivers = [ ];
    # };
    # Enable CUPS to print documents.
    # printing.enable = true;

    udev.enable = true;
  };

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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    # wlr.settings = {
    #   screencast = {
    #     output_name = "DP-1";
    #     chooser_type = "simple";
    #     chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    #   };
    # };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ "*" ];
      };
      niri = {
        default = [
          "gtk"
          "gnome"
        ];
        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.Notification" = "gtk";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.portal.ScreenCast" = "wlr";
      };
    };
  };

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

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
