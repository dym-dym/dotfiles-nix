{ pkgs, inputs, ... }:
let
  system = "x86_64-linux";
  theme = "tokyo-night-dark";
  polarity = "dark";
  wallpaper = "SELInternet.jpg";

in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

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

    packages = with pkgs; [
      signal-desktop
      nerd-fonts.jetbrains-mono
	    nerd-fonts.fira-code
	    font-awesome
      nerd-fonts.noto
      noto-fonts
      noto-fonts-color-emoji
      ueberzugpp
      ffmpegthumbnailer
      unar
      coq
      # coqPackages.coq-lsp
      inputs.zen-browser.packages."${system}".default
      neovim-remote
    ];

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

  imports = [
     ../modules
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    # polarity = "dark";
    inherit polarity;
    autoEnable = true;

    image = ./wallpapers/${wallpaper};

    cursor = {
      package = pkgs.simp1e-cursors;
      name = "Simp1e-Catppuccin-Mocha";
      size = 25;
    };


    targets = {
      fish.enable = true;
      waybar.enable = false;
      ghostty.enable = false;
      rofi.enable = false;
      # gtk.enable = false;
      # qt.enable = false;
      yazi.enable = false;
      librewolf.profileNames = [ "dymdym" ];
      firefox.profileNames = [ "dymdym" ];
    };

	  fonts = {
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
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  gtk.iconTheme = {
    package = pkgs.dracula-icon-theme;
    name = "Dracula";
  };

  qt = {
    enable = true;
  };

  programs = {
    eza.enable = true;
    ripgrep.enable = true;

    git = {
      enable = true;
      settings = {
        user = {
          name = "Dylan Bettendroffer";
          email = "dylan.bettendroffer@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["pcmanfm.desktop"]; # Directories
        "text/plain" = ["neovim.desktop"]; # Plain text
        # "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["onlyoffice-desktopeditors.desktop"]; # .docx
        # "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["onlyoffice-desktopeditors.desktop"]; # .pptx
        "application/pdf" = ["zathura.desktop"]; # .pdf
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

  texlive.enable = true;

  services.udiskie.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
