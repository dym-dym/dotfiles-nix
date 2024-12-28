{ config, pkgs, lib, ... }:
{

  options ={
    fish.enable = lib.mkEnableOption "enable fish";
  };

  config = lib.mkIf config.fish.enable {

    programs = {
      nushell.enable = true;

      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [
          "--cmd cd"
        ];
      };

    };
  };

}
