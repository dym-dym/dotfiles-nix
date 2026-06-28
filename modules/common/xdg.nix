{
  pkgs,
  lib,
  ...
}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      # pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ 
          "gtk" 
        ]; 
      };
      niri = lib.mkDefault {
        default = [
          "gtk"
          # "gnome"
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
}
