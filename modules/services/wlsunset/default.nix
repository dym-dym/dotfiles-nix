{ config, lib, pkgs, ... }:
{
  options = {
    wlsunset.enable = lib.mkEnableOption "enable wlsunset";
  };

  config = lib.mkIf config.wlsunset.enable {
    services.wlsunset = {
      enable = true;
      latitude = -23; 
      longitude = -46;
    };
  };
}
