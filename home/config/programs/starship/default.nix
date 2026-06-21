{ config, lib, pkgs, ... }:
{
  options = {
    starship.enable = lib.mkEnableOption "enable starship prompt";
  };

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;

      enableFishIntegration = true;

      settings = pkgs.lib.importTOML ./starship.toml;
    };
  };
}
