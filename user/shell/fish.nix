{ config, pkgs, ... }:

{
  programs = {
    fish.enable = true;
    starship.enable = true;
  };

  programs.fish.shellInit = "";
  programs.fish.interactiveShellInit = "";
}
