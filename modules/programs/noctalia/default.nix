{ config, lib, pkgs, ... }:
{
  options = {
    noctalia.enable = lib.mkEnableOption "enable noctalia";
  };

  config = lib.mkIf config.noctalia.enable {

    programs.noctalia = {
      enable = true;

      settings = ./config.toml;
        # lib.mkDefault (builtins.fromJSON
        #   (builtins.readFile ./noctalia.json)).settings;

    };
  };
}
