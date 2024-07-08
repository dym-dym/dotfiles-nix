{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;

  # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
}
