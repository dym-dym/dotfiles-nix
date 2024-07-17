{ config, pkgs, lib, ... }:

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = {
      enable = true;
      sync_address = "https://atuin.dylanbettendroffer.fr";
    };
  };
}
