{ config, pkgs, lib, ... }:

{
  programs.atuin = {
    enableFishIntegration = true;
    settings = {
      enable = true;
      sync_address = "https://atuin.dylanbettendroffer.fr";
    };
  };
}
