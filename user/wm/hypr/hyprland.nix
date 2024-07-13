{ config, lib, pkgs, ... }:

{

  services.swayosd.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  
  wayland.windowManager.hyprland.systemd.variables = ["--all"];

  wayland.windowManager.hyprland.settings = {

    monitor = "eDP-1,1920x1080@60,0x0,1";

    source = "~/.config/hypr/mocha.conf";
    
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
      "col.active_border" = "0xffb072d1";
      "col.inactive_border" = "0xff292a37";
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
      "col.shadow" = "rgba(00000090)";
    };

    animations = {
      enabled = "yes";

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.0";
      animation = [
        "windows, 1, 5, myBezier"
        "windowsOut, 1, 5, default, popin 80%"
	      "border, 1, 10, default"
	      "borderangle, 1, 8, default"
	      "fade, 1, 7, default"
	      "workspaces, 1, 2, myBezier"
      ];
    };

    dwindle = {
      pseudotile = "1";
    };

    master = {
      always_center_master = true;
    };

    gestures = { 
      workspace_swipe = true;
      workspace_swipe_fingers = "3";
      workspace_swipe_invert = true;
      workspace_swipe_distance = "200";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      disable_autoreload = true;
    };

    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
			"XDG_SESSION_TYPE,wayland"
			"XDG_SESSION_DESKTOP,Hyprland"
			
			## QT
			"QT_AUTO_SCREEN_SCALE_FACTOR,1"
			"QT_QPA_PLATFORM=wayland;xcb    # Not yet working for onlyoffice-editor"
			"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
			"QT_QPA_PLATFORMTHEME,qt6ct"
			
			## Toolkit
			"SDL_VIDEODRIVER,wayland"
			"_JAVA_AWT_WM_NONEREPARENTING,1"
			"CLUTTER_BACKEND,wayland"
			"GDK_BACKEND,wayland,x11"
    ];

    windowrule = [
      "float, title:^(Open)$"
      "float, title:^(Choose Files)$"
      "float, title:^(Save As)$"
      "float, title:^(Confirm to replace files)$"
      "float, title:^(File Operation Progress)$"
      "center, pavucontrol"
      "float, pavucontrol"
      "idleinhibit fullscreen, firefox"
      "idleinhibit fullscreen, mpv"
      "idleinhibit fullscreen, librewolf"
    ];

    windowrulev2 = [
      "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"
      "maxsize 1 1,class:^(xwaylandvideobridge)$"
      "noblur,class:^(xwaylandvideobridge)$"
    ];

    exec-once = [
      "dunst"
      # "~/.config/hypr/scripts/randombackground"
      "waypaper --restore"
      "killall -q waybar; sleep .5 && waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css"
      "swayosd-server"
    ];

    exec = [
    ];

    "$mod" = "SUPER";

    bind =
      [
        "$mod, B, exec, librewolf"
        "$mod, Return, exec, alacritty"
	      "$mod SHIFT, Return, exec, wofi"
	      "$mod, C, killactive"
				"$mod, Space, fullscreen, 0"
				"$mod, h, movefocus, l"
				"$mod, l, movefocus, r"
				"$mod, k, movefocus, u"
				"$mod, j, movefocus, d"
				"$mod SHIFT, h, movewindow, l"
				"$mod SHIFT, l, movewindow, r"
				"$mod SHIFT, k, movewindow, u"
				"$mod SHIFT, j, movewindow, d"
        "$mod SHIFT, r, exec, hyprctl reload"

				",XF86MonBrightnessUp,exec,swayosd-client --brightness raise"
				",XF86MonBrightnessDown,exec,swayosd-client --brightness lower"
				",XF86AudioRaiseVolume,exec,swayosd-client --output-volume raise"
				",XF86AudioLowerVolume,exec,swayosd-client --output-volume lower"
				",XF86AudioMute,exec,swayosd-client --output-volume mute-toggle"
				",XF86AudioMicMute,exec,swayosd-client --input-volume mute-toggle"
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
              "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
            ]
          )
          10)
      );
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };


}
