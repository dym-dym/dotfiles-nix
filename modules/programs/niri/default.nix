{ config, lib, pkgs, ... }:

let
  # randombackground = ./scripts/randombackground;
  # wofi-script = ./scripts/wofi;
  terminal = if (config.alacritty.enable) then "alacritty" else (if config.alacritty.enable then "kitty" else "kitty");
in
{

  imports = [
    ../noctalia
  ];

  options = {
    niri.enable = lib.mkEnableOption "enable niri";
  };

  config = lib.mkIf config.niri.enable {

    noctalia.enable = lib.mkDefault true;

    programs.niri = {
      enable = true;
      settings = {

        xwayland-satellite.enable = true;

        debug = {
          honor-xdg-activation-with-invalid-serial = {};
        };

        prefer-no-csd = true;
        input.keyboard.xkb = {
          layout = "us";
          variant = "intl";
        };
        input.keyboard.numlock = true;

        input.touchpad.tap = true;
        input.touchpad.natural-scroll = false;

        workspaces = {
          "01-main" = {
            name = "1";
          };
          "02-web" = {
            name = "2";
          };
          "03-chat" = {
            name = "3";
          };
          "04-mail" = {
            name = "4";
          };
        };

        window-rules = [
          { clip-to-geometry = true; }
          {
            geometry-corner-radius =
            let
              radius = 2.0;
            in
            {
              top-left = radius;
              top-right = radius;
              bottom-left = radius;
              bottom-right = radius;
            };
          }
        ];

        hotkey-overlay.skip-at-startup = true;

        layer-rules = [
          {
            # matches = [
            #   {
            #     namespace = "^noctalia-overview*";
            #   }
            # ];
            place-within-backdrop = true;
          }
        ];

        overview.workspace-shadow.enable = true;

        layout = {
          gaps = 10;
          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];


          default-column-width = { proportion = 0.5; };

          focus-ring = {
            width = 2;
            active.color = "#7FC8FF"; #TODO: change to stylix preset
            inactive.color = "#505050";
          };

          border.enable = false;
          shadow = {
            enable = true;
            softness = 30;
          };

          background-color = "transparent";

        };

        spawn-at-startup = [
          { argv = ["noctalia-shell"]; }
          # { argv = ["swaync"]; }
          # { argv = ["swayosd-server"]; }
          # { argv = ["swww-daemon"]; }
          # { argv = ["swww" "restore"];}
        ];


        switch-events = {
          # "lid-close".action.spawn = "hyprlock";
          "lid-close".action.spawn = [ "noctalia-shell" "ipc" "call" "lockScreen" "lock" ];
        };

        binds = {

          "Mod+Shift+Slash".action.show-hotkey-overlay = {};

          "Mod+Return".action.spawn = "kitty";
          # "Mod+Shift+Return".action.spawn = [ "rofi" "-show" "drun" ];
          "Mod+Shift+Return".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
          # "Mod+Shift+D".action.spawn = [ "wlogout" "--css" "/home/dymdym/.config/wlogout/style.css" ];
          "Mod+Shift+D".action.spawn = [ "noctalia-shell" "ipc" "call" "lockScreen" "lock" ];
          "Mod+B".action.spawn = "zen-beta";

          # "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "-l" "1.0" ];
          "XF86AudioRaiseVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "increase" ];
          # "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
          "XF86AudioLowerVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "decrease" ];
          # "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
          "XF86AudioMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteOutput" ];
          # "XF86AudioMicMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
          "XF86AudioMicMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteInput" ];

          # "XF86AudioPlay".action.spawn = [ "playerctl" "play-pause" ];
          # "XF86AudioStop".action.spawn = [ "playerctl" "stop" ];
          # "XF86AudioPrev".action.spawn = [ "playerctl" "previous" ];
          # "XF86AudioNext".action.spawn = [ "playerctl" "next" ];

          "XF86MonBrightnessUp".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
          # "XF86MonBrightnessUp".action.spawn = [ "swayosd-client" "--brightness" "raise" ];
          "XF86MonBrightnessDown".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];
          # "XF86MonBrightnessDown".action.spawn = [ "swayosd-client" "--brightness" "lower" ];

          "Mod+O".action.toggle-overview = {};
          "Mod+C".action.close-window = {};

          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;

          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;
          "Mod+Shift+7".action.move-column-to-workspace = 7;
          "Mod+Shift+8".action.move-column-to-workspace = 8;
          "Mod+Shift+9".action.move-column-to-workspace = 9;


          "Mod+U".action.focus-workspace-down = {};
          "Mod+I".action.focus-workspace-up = {};


          "Mod+Shift+H".action.focus-monitor-left = {};
          "Mod+Shift+J".action.focus-monitor-down = {};
          "Mod+Shift+K".action.focus-monitor-up = {};
          "Mod+Shift+L".action.focus-monitor-right = {};


          "Mod+Ctrl+H".action.move-column-left = {};
          "Mod+Ctrl+J".action.move-window-down = {};
          "Mod+Ctrl+K".action.move-window-up = {};
          "Mod+Ctrl+L".action.move-column-right = {};

          "Mod+H".action.focus-column-left = {};
          "Mod+J".action.focus-window-down = {};
          "Mod+K".action.focus-window-up = {};
          "Mod+L".action.focus-column-right = {};

          "Mod+F".action.maximize-column = {};
          "Mod+Space".action.fullscreen-window = {};
          "Mod+Ctrl+R".action.reset-window-height = {};
          "Mod+Ctrl+F".action.expand-column-to-available-width = {};

          "Mod+Minus".action.set-column-width = "-10%";
          "Mod+Equal".action.set-column-width = "+10%";
          "Mod+Shift+Minus".action.set-window-height = "-10%";
          "Mod+Shift+Equal".action.set-window-height = "+10%";

          "Mod+Shift+T".action.toggle-window-floating = {};

          "Print".action.screenshot = {};
          "Ctrl+Print".action.screenshot-screen = {};
          "Alt+Print".action.screenshot-window = {};

          "Mod+Shift+E".action.quit = {};
        };

      };
    };
  };
}
