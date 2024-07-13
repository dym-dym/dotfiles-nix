{ config, pkgs, ... }:

{
dconf.settings = {
  "org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
};
	qt.enable = true;
#	
#	# platform theme "gtk" or "gnome"
	qt.platformTheme.name = "gtk";
#	
#	# name of the qt theme
	qt.style.name = "adwaita-dark";
#	
#	# detected automatically:
#	# adwaita, adwaita-dark, adwaita-highcontrast,
#	# adwaita-highcontrastinverse, breeze,
#	# bb10bright, bb10dark, cde, cleanlooks,
#	# gtk2, motif, plastique
#	
#	# package to use
#	qt.style.package = pkgs.adwaita-qt;
#
	gtk.enable = true;
  gtk.theme.name = "Adwaita-dark";
#	
#	gtk.cursorTheme.package = pkgs.bibata-cursors;
#	gtk.cursorTheme.name = "Bibata-Modern-Ice";
#	
#	gtk.theme.package = pkgs.adw-gtk3;
#	gtk.theme.name = "adw-gtk3";

  # gtk.iconTheme.package
}
