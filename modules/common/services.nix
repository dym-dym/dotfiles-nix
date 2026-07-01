{
  pkgs,
  config,
  ...
}: {
  services = {
    ## == Graphical Settings ==

    # Configure keymap in X11
    xserver = {
      xkb = {
        layout = "us";
        variant = "intl";
      };
      videoDrivers =
        if config.nvidia.enable
        then ["nvidia"]
        else [];
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
      };
    };

    # Enable automatic login for the user.
    displayManager.autoLogin = {
      enable = false;
      user = "dymdym";
    };

    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    upower.enable = true;
    fwupd.enable = true;

    dbus.packages = [
      pkgs.nautilus
      # pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];

    # Enable the OpenSSH daemon.
    openssh.enable = true;
    openssh.settings.PasswordAuthentication = true;

    #Syncthing

    syncthing = {
      enable = true;
      user = "dymdym";
      group = "users";
      configDir = "/home/dymdym/.config/syncthing";
      openDefaultPorts = true;
      guiAddress = "0.0.0.0:8384";

      settings = {
        gui = {
          user = "dymdym";
          password = "password123";
        };

        devices = {
          "Work-laptop" = {id = "STIKJ7C-GQ4RP4B-JG5Q7RO-XHCUKRK-2XBKKYI-ZU3CDYB-C3FWN2G-HCKYGAF";};
        };
      };
    };

    # Key remapping
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

    udev = {
      enable = true;
      packages = with pkgs; [ via ];
    };

    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
  };
}
