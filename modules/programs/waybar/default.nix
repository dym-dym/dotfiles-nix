{ config, pkgs, lib, ... }:
{

  options = {
    waybar.enable = lib.mkEnableOption "enable waybar";
  };

  config = lib.mkIf config.waybar.enable {
	  programs.waybar.enable = true;

	  programs.waybar.settings.mainBar = {

      output = "DP-1";
	    layer = "top";
	    height = 30;
	    margin-top = 4;
	    margin-left = 0;
	    margin-bottom = 0;
	    margin-right = 0;
	    spacing = 0;

	    modules-left = [
	      "custom/launcher"
	      "custom/separator"
	      "cpu"
	      "memory"
	      "temperature"
	      "custom/dot"
	      "custom/separator"
	    ];

	    modules-center = [
	      "custom/window-name"
	      "custom/dot"
	      "hyprland/workspaces"
	      "custom/dot"
	      "custom/separator"
	      "tray"
	    ];

	    modules-right = [
	      "backlight"
	      "battery"
	      "pulseaudio"
	      "custom/dot"
	      "custom/separator"
	      "custom/weatherNancy"
	      "custom/separator"
	      "custom/weatherMontpellier"
	      "custom/separator"
	      "custom/dot"
	      "clock"
	    ];

	    "custom/launcher" = {
	#      format = "";
	      format = "";
	      on-click = "pkill wofi || wofi";
	      tooltip = false;
	    };

	    "custom/separator" = {
	      format = " ";
	    };

	    "cpu" = {
	      interval = 10;
	      format = "🖳 <b>{usage}%</b>";
	      max-length = 10;
	      tooltip = false;
	    };

	    "memory" = {
	      interval = 30;
	      format = " <b>{used}GiB</b>";
	      format-alt = "  {used:0.1f}G";
	      max-length = 10;
	    };

	    "temperature" = {
        thermal-zone = 0;
        hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
	      critical-threshold = 80;
	      format-critical = " <b>{temperatureC}°C</b>";
	      format = " <b>{temperatureC}°C</b>";
	    };

	    "custom/wrap-left" = {
	      format = "<b>[</b>";
	    };
	    "custom/wrap-right" = {
	      format = "<b>]</b>";
	    };

	    "hyprland/workspaces" = {
	      all-outputs = true;
	      sort-by-number = true;
	      active-only = false;
	      on-click = "activate";
	      format = "{icon}";
	      on-scroll-up = "hyprctl dispatch workspace e+1";
	      on-scroll-down = "hyprctl dispatch workspace e-1";
	      format-icons = {
	        "1" = "";
	        "2" = "";
	        "3" = "";
	        "4" = "";
	        "5" = "";
	        "6" = "";
	        urgent = "";
	        active = "";
	        default = "";
	      };
	    };

	    "custom/pacman-update" = {
	      format = "  <b>{}</b> ";
	      # interval = 3600;
	      # exec = "checkupdates | wc -l";
	      # signal = 8;
	    };

	    tray = {
	      icon-size = 20;
	      spacing = 8;
	    };

	    "clock" = {
	      format = "<b>{:%H:%M %p}</b>";
	      format-alt = "<b>{:%a.%d,%b}</b>";
	      tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
	    };

	    "backlight" = {
	      device = "amdgpu_bl1";
	      format = "{icon} <b>{percent}</b>";
	      tooltip = false;
	      format-icons = [
	        # ""
	        # ""
	        # ""
	        "💡"
	      ];
	    };

	    "network" = {
	      format-wifi = " {essid}";
	      on-click = "iwgtk";
	      format-ethernet = " wired";
	      tooltip = false;
	      format-disconnected = "";
	    };
	    "pulseaudio" = {
	      format = "{icon}  <b>{volume}</b>";
	      format-bluetooth = " ";
	      # format-bluetooth-muted = " 🔇";
	      format-bluetooth-muted = "🔇";
	      tooltip = false;
	      # format-muted = "";
	      format-muted = "🔇";
	      format-icons = {
	        default = [
	          ""
	          ""
	          ""
	        ];
	      };
	      on-click = "pavucontrol";
	    };
	   "battery" = {
	      bat = "BAT0";
	      interval = 60;
	      states = {
	        warning = 30;
	        critical = 15;
	      };
	      format = "{icon} <b>{capacity}</b>%";
	      format-icons = [
	        " "
	        " "
	        " "
	        " "
	      ];
	      max-length = 25;
	      tooltip = false;
	    };
	    "custom/right-arr" = {
	      format = "  ";
	    };


	    "custom/window-name" = {
	      format = "<b>{}</b>";
	      interval = 1;
	      exec = "hyprctl activewindow | grep class | awk '{print $2}'";
	    };

	    "custom/window-icon" = {};

	    "custom/weatherNancy" = {
	      format = "{}";
	      tooltip = true;
	      interval = 3600;
	      exec = "wttrbar --custom-indicator '{ICON} {temp_C}°C' --location Nancy ";
	      return-type = "json";
	    };

	    "custom/weatherMontpellier" = {
	      format = "{}";
	      tooltip = true;
	      interval = 3600;
	      exec = "wttrbar --custom-indicator '{ICON} {temp_C}°C' --location Montpellier ";
	      return-type = "json";
	    };
	    "custom/dot" = {
	      format = "  ";
	      tooltip = false;
	    };
	    "custom/dot-alt" = {
	      format = "  ";
	      tooltip = false;
	    };
	  };

	  programs.waybar.style = ''
	    * {
			  padding: 0;
			  margin: 0;
        font-family: JetBrainsMono Nerd Font;
			  font-size: 16px;
			}

			window#waybar {
			  background: transparent;
			}
			/*
			  background: rgba(30, 30, 46, 0.6);
			*/
			#custom-launcher {
			  font-size: 20px;
			  color: #00bfff; /* deepskyblue */
			  padding: 0px 15px 0px 15px;
			}

			#pulseaudio,
			#cpu,
			#memory,
			#temperature,
			#battery,
			#clock,
			#custom-wrap-left,
			#custom-wrap-right,
			#custom-pacman-update,
			#tray,
			#custom-window-name
			{
			  font-size:14px;
			  background: #363a4f;
			  margin: 5px 0px 5px 0px;
			}

			#cpu,
			#memory,
			#temperature
			{
			  font-size: 14px;
			}

			#pulseaudio,
			#clock,
			#custom-window-name,
			#modules-right,
			#tray
			{
			  margin: 0px 5px 0px 0px;
			  padding: 0px 10px 0px 12px;
			  border-radius: 8px 8px 8px 8px;
			}

			#cpu,
			#custom-wrap-left
			{
			  border-radius: 8px 0px 0px 8px;
			  padding: 0px 0px 0px 12px;
			}

			#cpu
			{
			  color: #eed49f;
			  padding: 5px 10px 0px 12px;
			}

			#memory {
			  color: #a6da95;
			  padding: 0px 10px 0px 0px;
			}

			#temperature
			{
			  color: #8aadf4;
			}

			#temperature,
			#custom-wrap-right
			{
			  padding: 0px 12px 0px 0px;
			  border-radius: 0px 8px 8px 0px;
			}

			#custom-wrap-left {
			  font-size: 18px;
			}

			#custom-wrap-right {
			  font-size: 18px;
			}

			#custom-pacman-update {
			  color: #8bd5ca;
			}

			#workspaces button:nth-child(1) label {
			  color: #8aadf4;
			  margin: 0px 8px;
			}

			#workspaces button:nth-child(2) label {
			  color: #ed8796;
			  margin: 0px 8px;
			}

			#workspaces button:nth-child(3) label {
			  color: #a6da95;
			  margin: 0px 8px;
			}

			#workspaces button:nth-child(4) label {
			  color: #c6a0f6;
			  margin: 0px 8px;
			}

			#workspaces button:nth-child(5) label {
			  color: #f4dbd6;
			  margin: 0px 8px;
			}

			#workspaces button:nth-child(6) label {
			  color: #f5a97f;
			  margin: 0px 8px;
			}

			/*#pulseaudio,*/
			#backlight,
			#battery
			{
			  font-size: 14px;
			  background: #363a4f;
			  margin: 5px 0px 5px 0px;
			}

			#battery {
			  color: #a6da95;
			  padding: 0px 10px 0px 0px;
			}

			#backlight {
			  color: #eed49f;
			  padding: 0px 10px 0px 10px;
			  border-radius: 8px 0px 0px 8px;
			}

			#pulseaudio {
			  color: #91d7e3;
			  padding: 0px 10px 0px 10px;
			  border-radius: 8px 8px 8px 8px;
			}

			#custom-right-arr {
			  color: #8aadf4;
			}

			#network {
			  color: #c6a0f6;
			}

			#custom-dot {
			  color: #6e738d;
			}

			#custom-dot-alt {
			  color: #a5adcb;
			}

			/*# sourceMappingURL=style.css.map */
		'';
  };
}
