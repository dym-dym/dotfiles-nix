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
  # boot.kernelPackages = pkgs.linuxPackages_6_14;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5;
  };

  ## == Network ==

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  #networking.networkmanager.ensureProfiles.profiles.ipv4.ignore-auto-dns = true;
  networking.dhcpcd.extraConfig = ''
    nohook resolv.conf
  '';

  # Setup DNS
  networking.nameservers = [ "100.100.100.100" "9.9.9.9" "1.1.1.1" ];

  ## == Locales ==

  # Set your time zone.
  time.timeZone = "Europe/London";
  # time.timeZone = "Europe/Paris";

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
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "intl";
    };
    videoDrivers = [ "displaylink#6.0.0" "nvidia" ];
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  #NvidiaConfig
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
        # vaapiVdpau
        # vaapiIntel
        # libvdpau-va-gl
        # intel-media-driver
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
      version = "575.64";

      sha256_64bit = "sha256-6wG8/nOwbH0ktgg8J+ZBT2l5VC8G5lYBQhtkzMCtaLE=";
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
        # kdePackages.kate
        # thunderbird
        telegram-desktop
        element-desktop
        signal-desktop
        whatsapp-for-linux
        android-tools
        # fastfetch
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
        usbimager
        jellyfin-mpv-shim
        gnumake
        bat
        swww
        gimp
        zoom
        owncloud-client
        xautoclick
        lutris
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

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  ## == Programs and Services ==

  programs = {
    fish.enable = true;
    # nushell.enable = true;
    hyprland.enable = true;
    gamemode.enable = true;
    nm-applet.enable = true;
    pay-respects.enable = true;
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
	    # fishPlugins.done
	    # fishPlugins.fzf-fish
	    # fishPlugins.forgit
	    # fishPlugins.hydro
	    # fishPlugins.grc

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
      # kio-admin

      # Fonts (and TeX)

      # nerdfonts
      nerd-fonts.jetbrains-mono
	    nerd-fonts.fira-code
	    font-awesome
      nerd-fonts.noto
      noto-fonts-extra
      noto-fonts-emoji

      texliveFull

      # Browsers
      librewolf

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
	    discord-canary
	    protonup
      networkmanagerapplet
      simple-scan
      tailscale
      libreoffice
      kanata
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
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

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
  services.openssh.settings.PasswordAuthentication = true;

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

  programs.gnome-disks.enable = true;

  services.fwupd.enable = true;

  services.kanata = {
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

  virtualisation.docker.enable = true;
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
   # channel = "https://nixos.org/channels/nixos-24.05";
   flake = "github:dym-dym/dotfiles-nix/laptop";
   dates = "daily";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
