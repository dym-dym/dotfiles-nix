{ lib, ... }:
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
    ./programs/yazi
    ./programs/zathura
    ./programs/fastfetch
  ];

  alacritty.enable = lib.mkDefault false;
  kitty.enable = lib.mkDefault true;
  atuin.enable = lib.mkDefault true;
  cava.enable = lib.mkDefault true;
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
  yazi.enable = lib.mkDefault true;
  zathura.enable = lib.mkDefault true;
}
