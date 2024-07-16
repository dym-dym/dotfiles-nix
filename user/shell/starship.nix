{ config, pkgs, ... }:
{

  programs.starship = {
    enable = true;

    enableFishIntegration = true;

    settings = pkgs.lib.importTOML ./starhip.toml;
    };
}
