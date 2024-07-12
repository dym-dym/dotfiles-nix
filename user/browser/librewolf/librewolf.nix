{ config, pkgs, ... }:
{
  programs.librewolf.enable = true;
  programs.librewolf.settings = {
    "privacy.resistFingerprinting" = false;
  };
}
