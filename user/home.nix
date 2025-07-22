{ config, lib, pkgs, pkgs-unstable, inputs, ... }:
let
  system = "x86_64-linux";
  theme = "tokyo-night-dark";
  polarity = "dark";
  wallpaper = "SELInternet.jpg";

  # jellyfin-tui = pkgs.callPackage ./../modules/programs/jellyfin-tui { };
in
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

  home.packages = (with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono

	    font-awesome
      nerd-fonts.noto
      noto-fonts-extra
      noto-fonts-emoji
      swayosd
      ueberzugpp
      ffmpegthumbnailer
      unar
      coq
      # coqPackages.coq-lsp
      # gimp
      irssi
      hexchat
      inputs.zen-browser.packages."${system}".default
      fastfetch
      komikku
      comma
      neovim-remote

      protonvpn-gui
      bitwarden-desktop
      # jellyfin-tui
  ])
    ++
  (with pkgs-unstable; [
      supersonic-wayland

  ])
  ;

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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    inherit polarity;
    autoEnable = true;

    image = ./wallpapers/${wallpaper};

    cursor.package = pkgs.simp1e-cursors;
    cursor.name = "Simp1e-Catppuccin-Mocha";
    cursor.size = 25;

    targets = {
      # fish.enable = true;
      alacritty.enable = true;
      waybar.enable = false;
      swaync.enable = false;
      rofi.enable = false;
    };

	  fonts = {
	    # monospace = {
	    #    package = pkgs.nerd-fonts.override {fonts = ["FiraCode"];};
	    #   name = "FiraCode Nerd Font Mono";
	    # };
      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "DejaVu Sans Mono";
      };
	    sansSerif = {
	       package = pkgs.nerd-fonts.dejavu-sans-mono;
	       name = "DejaVu Sans";
	    };
	    serif = {
	      package = pkgs.nerd-fonts.dejavu-sans-mono;
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

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["pcmanfm.desktop"]; # Directories
        "text/plain" = ["neovim.desktop"]; # Plain text
        # "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["onlyoffice-desktopeditors.desktop"]; # .docx
        # "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["onlyoffice-desktopeditors.desktop"]; # .pptx
        "application/pdf" = ["zathura.desktop"]; # .pdf
        "application/x-pdf" = ["zathura.desktop"]; # .pdf
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
      associations.added = {
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
      };
    };
  };

  programs.keepassxc.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
