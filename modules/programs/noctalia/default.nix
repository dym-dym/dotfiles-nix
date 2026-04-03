{ config, lib, pkgs, ... }:
{
  options = {
    noctalia.enable = lib.mkEnableOption "enable noctalia";
  };

  config = lib.mkIf config.noctalia.enable {

    programs.noctalia-shell = {
      enable = true;

      settings =
        lib.mkDefault (builtins.fromJSON
          (builtins.readFile ./noctalia.json)).settings;

    };
  };
}
