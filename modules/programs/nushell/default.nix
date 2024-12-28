{ config, pkgs, lib, ... }:
{

  options ={
    nushell.enable = lib.mkEnableOption "enable nushell";
  };

  config = lib.mkIf config.nushell.enable {

    programs = {
      nushell = {
        enable = true;
        configFile = {
          text = ''
            let $config = {
              edit_mode : vi
            }
          '';
        };
      };

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
