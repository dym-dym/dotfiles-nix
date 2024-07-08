{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    
    input = {
      follow_mouse = "1";
      kb_layout = "us";
      kb_variant = "intl";
    };

    general = {
      sensitivity = "1";
      gaps_in = "5";
      gaps_out = "8";
      border_size = "2";
      # col.active_border = "0xffb072d1";
      # col.inactive_border = "0xff292a37";
    };

    decoration = {
      rounding = "5";
      active_opacity = "0.9";
      inactive_opacity = "0.7";

      blur = {
        enabled = true;
	size = "12";
	passes = "3";
	xray = true;
	noise = "0.05";
	ignore_opacity = true;
      };

      drop_shadow = "yes";
      shadow_range = "12";
      shadow_render_power = "3";
      # col.shadow = "rgba(00000090)";
    };

    animations = {
      enabled = "no";
    };

    "$mod" = "SUPER";
    bind =
      [
        "$mod, B, exec, firefox"
        "$mod SHIFT, Return, exec, alacritty"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };
  # home.file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
}
