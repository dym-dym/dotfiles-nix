{
  pkgs,
  lib,
  ...
}: {
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = false;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
      ];
      config = {
        common = {
          default = [
            "wrl"
          ];
        };
        niri = lib.mkForce {
          default = [
            "wlr"
          ];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = lib.mkForce "wlr";
          "org.freedesktop.portal.ScreenCast" = lib.mkForce "wlr";
        };
      };
    };

    mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["pcmanfm.desktop"]; # Directories
        "text/plain" = ["neovim.desktop"]; # Plain text
        # "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["onlyoffice-desktopeditors.desktop"]; # .docx
        # "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["onlyoffice-desktopeditors.desktop"]; # .pptx
        "application/pdf" = lib.mkForce ["zathura.desktop"]; # .pdf
        "application/zip" = ["xarchiver.desktop"];
        "text/*" = ["neovim.desktop"]; # Any text files
        "video/*" = ["mpv.desktop"]; # Any video files
        # "x-scheme-handler/https" = ["librewolf.desktop"]; # Links
        # "x-scheme-handler/http" = ["librewolf.desktop"]; # Links
        # "x-scheme-handler/mailto" = ["librewolf.desktop"]; # Links
        # "x-scheme-handler/https" = ["zen-beta.desktop"]; # Links
        # "x-scheme-handler/http" = ["zen-beta.desktop"]; # Links
        # "x-scheme-handler/mailto" = ["zen-beta.desktop"]; # Links
        "image/*" = ["feh.desktop"]; # Images
        "image/png" = ["feh.desktop"];
        "image/jpeg" = ["feh.desktop"];
        "x-scheme-handler/http" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "x-scheme-handler/https" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "x-scheme-handler/mailto" = ["zen-beta.desktop"];
        "x-scheme-handler/chrome" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "text/html" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-htm" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-html" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-shtml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/xhtml+xml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-xhtml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-xht" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      };
      # associations.added = {
      #   "x-scheme-handler/http" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "x-scheme-handler/https" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "x-scheme-handler/chrome" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "text/html" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "application/x-extension-htm" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "application/x-extension-html" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "application/x-extension-shtml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "application/xhtml+xml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "application/x-extension-xhtml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "application/x-extension-xht" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
      #   "application/pdf" = ["zathura.desktop"]; # .pdf
      # };
    };
  };
}
