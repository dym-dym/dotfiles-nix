{ pkgs, lib, ...}:
{
  imports = [
    ./programs/alacritty
    ./programs/atuin
    ./programs/cava
    ./programs/firefox
    ./programs/fish
    ./programs/hyprland
    ./programs/hyprlock
    ./programs/librewolf
    ./programs/neovim
    ./programs/qutebrowser
    ./programs/starship
    ./programs/texlive
    ./programs/wlogout
    ./programs/wofi
    ./programs/waybar
    ./programs/yazi
    ./programs/zathura
    ./programs/fastfetch
    ./programs/rofi

    # ./services/swayosd
    ./services/wlsunset
    ./services/dunst
    ./services/swaync
  ];


  alacritty.enable = lib.mkDefault true;
  atuin.enable = lib.mkDefault true;
  cava.enable = lib.mkDefault true;
  dunst.enable = lib.mkDefault false;
  firefox.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  librewolf.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  qutebrowser.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  # swayosd.enable = lib.mkDefault true;
  texlive.enable = lib.mkDefault false;
  wlsunset.enable = lib.mkDefault true;
  wlogout.enable = lib.mkDefault true;
  wofi.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;
  zathura.enable = lib.mkDefault true;
  fastfetch.enable = lib.mkDefault true;
  rofi.enable = lib.mkDefault true;
  swaync.enable = lib.mkDefault true;
}
