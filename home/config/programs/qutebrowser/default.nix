{ config, lib, pkgs, ... }:
{
  options = {
    qutebrowser.enable = lib.mkEnableOption "enable qutebrowser";
  };

  config = lib.mkIf config.qutebrowser.enable {
    programs.qutebrowser = {
      enable = true;
    };
  };
}
