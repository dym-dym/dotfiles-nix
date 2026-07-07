{ lib, ... }: {
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = lib.mkForce {
        "inode/directory" = ["pcmanfm.desktop"]; # Directories
        "text/plain" = ["neovim.desktop"]; # Plain text
        "application/pdf" = lib.mkForce ["org.pwmt.zathura-pdf-mupdf.desktop"]; # .pdf
        "application/zip" = ["xarchiver.desktop"];
        "text/*" = ["neovim.desktop"]; # Any text files
        "video/*" = ["mpv.desktop"]; # Any video files
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
      associations.added = lib.mkForce {
        "x-scheme-handler/http" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "x-scheme-handler/https" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "x-scheme-handler/chrome" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "text/html" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-htm" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-html" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-shtml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/xhtml+xml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-xhtml" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/x-extension-xht" = ["userapp-Zen6RAP32.desktop" "zen-beta.desktop"];
        "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"]; # .pdf
      };
      associations.removed = lib.mkForce {
        "application/pdf" = ["gimp.desktop"]; # .pdf
      };
    };
  };
}
