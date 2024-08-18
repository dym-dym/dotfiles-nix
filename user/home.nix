{ config, lib, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dymdym";
  home.homeDirectory = "/home/dymdym";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
     ../modules
  ];

  home.packages = with pkgs; [
      nerdfonts
      jetbrains-mono
	    fira-code-nerdfont
	    font-awesome
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      swayosd
      ueberzugpp
      ffmpegthumbnailer
      unar
      coq
      coqPackages.coq-lsp
      gimp
      irssi
      hexchat
  ];

  home.file = {
    ".XCompose".text = ''
        include "%L"

        <dead_acute> <C> : "Ç"
        <dead_acute> <c> : "ç"
    '';
  };

  home.sessionVariables = {
     EDITOR = "nvim";
  };
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    autoEnable = true;

    image = ./wallpapers/Cloudsnight.jpg;

    cursor.package = pkgs.simp1e-cursors;
    cursor.name = "Simp1e-Catppuccin-Mocha";
    cursor.size = 25;

    targets = {
      fish.enable = true;
      waybar.enable = false;
    };

	  fonts = {
	    monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
	      name = "FiraCode Nerd Font Mono";
	    };
	    sansSerif = {
	       package = pkgs.dejavu_fonts;
	       name = "DejaVu Sans";
	    };
	    serif = {
	      package = pkgs.dejavu_fonts;
	      name = "DejaVu Serif";
	    };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  gtk.iconTheme = {
    # package = pkgs.gnome.adwaita-icon-theme;
    # name = "adwaita-icon-theme";
    # package = pkgs.pop-icon-theme;
    # name = "pop-icon-theme";
    # package = pkgs.flat-remix-icon-theme;
    # name = "Flat-Remix-Teal-Dark";
    package = pkgs.dracula-icon-theme;
    name = "Dracula";
    # package = pkgs.kanagawa-icon-theme;
    # name = "Kanagawa";
  };

  qt = {
    enable = true;
    # platformTheme.name = lib.mkForce "gtk";
    # style.name = lib.mkForce "adwaita-dark";
    # style.package = lib.mkForce pkgs.adwaita-qt;
  };

  programs.eza.enable = true;
  programs.ripgrep.enable = true;

  programs.git = {
    enable = true;
    userName = "Dylan Bettendroffer";
    userEmail = "dylan.bettendroffer@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  texlive.enable = true;

  services.udiskie.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
