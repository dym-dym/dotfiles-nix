{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./programs/alacritty
    ./programs/kitty
    ./programs/atuin
    ./programs/cava
    ./programs/firefox
    ./programs/fish
    ./programs/librewolf
    ./programs/neovim
    ./programs/niri
    ./programs/nushell
    ./programs/qutebrowser
    ./programs/starship
    ./programs/texlive
    ./programs/wlogout
    ./programs/wofi
    ./programs/rofi
    ./programs/yazi
    ./programs/zathura
    ./programs/fastfetch

    ./services/wlsunset
    ./services/dunst
  ];

  alacritty.enable = lib.mkDefault false;
  kitty.enable = lib.mkDefault true;
  atuin.enable = lib.mkDefault true;
  cava.enable = lib.mkDefault true;
  dunst.enable = lib.mkDefault false;
  fastfetch.enable = lib.mkDefault true;
  firefox.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault false;
  nushell.enable = lib.mkDefault true;
  librewolf.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  niri.enable = lib.mkDefault true;
  qutebrowser.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  texlive.enable = lib.mkDefault false;
  wlsunset.enable = lib.mkDefault true;
  wlogout.enable = lib.mkDefault true;
  wofi.enable = lib.mkDefault true;
  rofi.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;
  zathura.enable = lib.mkDefault true;
}
