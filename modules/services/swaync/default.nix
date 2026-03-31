{ config, lib, pkgs, ... }:

{

  options = {
    swaync.enable = lib.mkEnableOption "enable swaync";
  };

  config = lib.mkIf config.swaync.enable {
	  services.swaync = {
	    enable = true;

      style = ''
        @define-color cc-bg ${config.lib.stylix.colors.withHashtag.base02};
        @define-color noti-border-color rgba(255, 255, 255, 0.15);
        @define-color noti-bg rgba(48, 48, 48, 0.8);
        @define-color noti-bg-opaque rgb(48, 48, 48);
        @define-color noti-bg-darker rgb(38, 38, 38);
        @define-color noti-bg-hover rgb(56, 56, 56);
        @define-color noti-bg-hover-opaque rgb(56, 56, 56);
        @define-color noti-bg-focus rgba(68, 68, 68, 0.6);
        @define-color noti-close-bg rgba(255, 255, 255, 0.1);
        @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
        @define-color text-color ${config.lib.stylix.colors.withHashtag.base05};
        @define-color text-color-disabled rgb(150, 150, 150);
        @define-color bg-selected rgb(0, 128, 255);

* {
	color: @foreground;
}

.blank-window {
	background: transparent;
}

.notification-action,
.notification-default-action,
.control-center {
	//border-radius: 0.75em;
	//border: 2px solid alpha(@color11, 0.3);
	background: @cc-bg;
}

.notification {
	box-shadow: 2px 2px 3px 0px rgba(0,0,0,0.5);
}


.notification-content {
	margin: 5px;
}

.control-center .notification-row {
	background: @cc-bg;
}

.widget-dnd {
	font-weight: bold;
	margin: 1em;
}

.widget-dnd>switch {
	border: 1px solid alpha(@color11, 0.3);
	border-radius: 0.75em;
	background: @cc-bg;
	padding: 1px;
}

.widget-dnd> switch slider {
	border: 1px solid alpha(@color11, 0.3);
	border-radius: 0.75em;
	//background: rgb(15, 15, 15);
	box-shadow: none;
}

.widget-mpris {
	border-radius: 0.75em;
	background: @cc-bg;
	margin: 1em;
}

.widget-buttons-grid {
	margin: 1em;
	background: @cc-bg;
}

.widget-buttons-grid>flowbox>flowboxchild>button {
	box-shadow: none;
	color: @foreground;
	font-style: normal;
	border: 1px solid alpha(@color11, 0.3);
	background: @cc-bg;
}

.widget-buttons-grid>flowbox>flowboxchild>button:hover {
	background: @cc-bg;
}

    '';

    settings = {
      positionX = "right";
      positionY = "top";
        # layer = "top";
        # control-center-layer = "top";
        # layer-shell = true;
        # cssPriority = "user";
      control-center-margin-top = 10;
      control-center-margin-bottom = 100;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-icon-size = 32;
      notification-body-image-height = 200;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      relative-timestamps = true;
      control-center-width = 350;
      control-center-height = 600;
      notification-window-width = 350;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = [
        # "inhibitors"
        "title"
        "dnd"
        "notifications"
        "mpris"
        "volume"
        "backlight"
          # "buttons-grid"
      ];

      widget-config = {
        inhibitors = {
          "text" = "Inhibitors";
          "button-text" = "Clear All";
          "clear-all-button" = true;
        };
        title = {
          "text" = "󰂚 Notifications";
          "clear-all-button" = true;
          "button-text" = "󰎟";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notification Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };

        volume = {
            "label" = "󰕾 ";
          # "text" = "Volume";
          # "slider" = true;
          # "min" = 0;
          # "max" = 100;
          # "step" = 1;
          # "action-increase" = "sh ~/.config/swaync/volume.sh increase";
          # "action-decrease" = "sh ~/.config/swaync/volume.sh decrease";
          # "action-mute" = "sh ~/.config/swaync/volume.sh mute";
        };
        backlight = {
            "label" = "󰃟 ";
          # "device" = "nvidia_0";
          # "text" = "Brightness";
          # "slider" = true;
          # "min" = 5;
          # "max" = 100;
          # "step" = 10;
          # "action-increase" = "brightnessctl set 1%+";
          # "action-decrease" = "brightnessctl set 1%-";
        };
        buttons-grid = {
          actions = [
            {
              "label" = "󰐥";
              "command" = "systemctl poweroff";
            }
            {
              "label" = "󰜉";
              "command" = "systemctl reboot";
            }
            {
              "label" = "󰌾";
              "command" = "swaylock-corrupter";
            }
            {
              "label" = "󰍃";
              "command" = "swaymsg exit";
            }
            {
              "label" = "󰆴";
              "command" = "swaync-client -C";
            }
            {
              "label" = "󰕾";
              "command" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
              "type" = "toggle";
            }
            {
              "label" = "󰍬";
              "command" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
              "type" = "toggle";
            }
            {
              "label" = "󰖩";
              "command" = "iwgtk";
            }
            {
              "label" = "󰂯";
              "command" = "blueman-manager";
            }
            {
              "label" = "";
              "command" = "kooha";
            }
          ];
        };
      };
      };
    };
  };
}
