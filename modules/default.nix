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

    ./services/wlsunset
    ./services/dunst
  ];


  alacritty.enable = lib.mkDefault true;
  atuin.enable = lib.mkDefault true;
  cava.enable = lib.mkDefault true;
  dunst.enable = lib.mkDefault true;
  firefox.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  librewolf.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  qutebrowser.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  texlive.enable = lib.mkDefault false;
  wlsunset.enable = lib.mkDefault true;
  wlogout.enable = lib.mkDefault true;
  wofi.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;
  zathura.enable = lib.mkDefault true;
}
