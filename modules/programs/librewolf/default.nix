{ config, lib, pkgs, inputs, ... }:
{
  options = {
    librewolf.enable = lib.mkEnableOption "enable librewolf";
  };

  config = lib.mkIf config.librewolf.enable {
    programs.librewolf = {
      enable = true;

      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
      };
    };
  };
}
