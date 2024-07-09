{ config, pkgs, ... }:

{
  programs = {
    fish.enable = true;
    starship.enable = true;
  };
}
