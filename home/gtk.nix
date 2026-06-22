{pkgs, ...}: {
  gtk.iconTheme = {
    package = pkgs.dracula-icon-theme;
    name = "Dracula";
  };
}
