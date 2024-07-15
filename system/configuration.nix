# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./sddm.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    # systemd-boot.device = "/dev/nvme0n1p3";
    # grub = {
      # enable = false;
      # useOSProber = true;
      # device = "/dev/nvme0n1p3";
    # };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the KDE Plasma Desktop Environment.
   #  services.displayManager.sddm.enable = true;
   # services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    # enable = true;
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
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "#nvidia-x11"
    ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
#      offload = {
#        enable = true;
#        enableOffloadCmd = true;
#      };

      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:60:0:0";
    };
  };

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

  users.users.dymdym.shell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dymdym = {
    isNormalUser = true;
    description = "dymdym";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # kdePackages.kate
      # thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin = { 
    enable = false;
    user = "dymdym";
  };

  # Install firefox.
  programs = {
    firefox.enable = true;
    fish.enable = true;
    hyprland.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    neovim
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
    starship
    alacritty
    wofi
    waybar
    fira-code-nerdfont
    font-awesome
    texliveFull
    swaybg
    # swayosd
    waypaper
    wttrbar
    librewolf
    qutebrowser
    jellyfin-media-player
    pavucontrol
    lxappearance
    pcmanfm
    blueberry
    btop
    webcord
    discord
    mpv
    thunderbird
    mangohud
    heroic
    #fprintd
    gnome.nautilus
    kio-admin
    tealdeer
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  programs.nm-applet.enable = true;

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

#  services.fprintd = {
#    enable = true;
#    package = pkgs.fprintd-tod;
#    tod = {
#      enable = true;
#      driver = pkgs.libfprint-2-tod1-vfs0090;
#    };
#  };

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
