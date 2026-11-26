{...}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./packages.nix
    ./stylix.nix
    ./qt.nix
    ./gtk.nix
    ./xdg.nix
    ./config
    ./hermes.nix
    # ./questline.nix
    # ../modules
  ];

  home = {
    username = "dymdym";
    homeDirectory = "/home/dymdym";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.

    stateVersion = "26.05";

    file = {
      ".XCompose".text = ''
        include "%L"

        <dead_acute> <C> : "Ç"
        <dead_acute> <c> : "ç"
      '';
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # Fixes us intl keyboard issues with deadkey characters
  xdg.desktopEntries = {
    signal-desktop = {
      name = "Signal";
      exec = "signal-desktop --ozone-platform=x11";
      icon = "signal-desktop";
      terminal = false;
      categories = [ "Network" "InstantMessaging" ];
    };
    # discord = {
    #   name = "Discord";
    #   exec = "discord --ozone-platform=x11";
    #   icon = "discord";
    #   terminal = false;
    #   categories = [ "Network" "InstantMessaging" ];
    # };
  };

  # texlive.enable = true;

  services.udiskie.enable = true;
  services.gnome-keyring.enable = true;

  # Let Home Manager install and manage itself.
}
