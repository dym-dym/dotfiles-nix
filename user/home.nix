{ config, pkgs, ... }:

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
     ./wm/hypr/hyprland.nix 
     ./wm/hypr/hyprlock.nix 
     ./wm/wofi/wofi.nix
     ./wm/wlogout
     # ./wm/global_theme/theme.nix
     ./shell/fish.nix
     ./shell/starship.nix
     ./terminal/alacritty.nix
     ./bar/waybar/waybar.nix
     ./notifications/dunst.nix
     ./text-editors/neovim.nix
     ./atuin/atuin.nix
     ./browser/librewolf/librewolf.nix
  ];
# The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
      cargo
      rustc
      opam
      ocaml
      gcc
      gnumake
      swayosd
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".XCompose".text = ''
        include "%L"

        <dead_acute> <C> : "Ç"
        <dead_acute> <c> : "ç"
    '';
#    ".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
   
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dymdym/etc/profile.d/hm-session-vars.sh
  #
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
      fish.enable = false;
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

  programs.eza.enable = true;
  programs.ripgrep.enable = true;

  services.udiskie.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
