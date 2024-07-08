{ config, pkgs, ... }:
{
  programs.waybar.enable = true;

  include = "~/.config/waybar/configs/custom_modules/modules";
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
    "custom/wrap-left"
    "custom/pacman-update"
    "custom/wrap-right"
  ];
  modules-center = [
    "custom/window-name"
    "custom/dot"
    "hyprland/workspaces"
    "custom/dot"
    "custom/separator"
    "tray"
  ];
  "modules-right" = [
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
  "hyprland/workspaces" = {
    "all-outputs" = true;
    "sort-by-number" = true;
    "active-only" = false;
    "on-click" = "activate";
    "format" = "{icon}";
    "on-scroll-up" = "hyprctl dispatch workspace e+1";
    "on-scroll-down" = "hyprctl dispatch workspace e-1";
    "format-icons" = {
      "1" = "";
      "2" = "";
      "3" = "";
      "4" = "";
      "5" = "";
      "6" = "";
      "urgent" = "";
      "active" = "";
      "default" = "";
    }
  };
  "tray" = {
    "icon-size" = 20;
    "spacing" = 8;
  };
  "clock" = {
    "format" = "<b>{ =%H =%M %p}</b>";
    "format-alt" = "<b>{ =%a.%d;%b}</b>";
    "tooltip-format" = "<big>{ =%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
  };
  "cpu" = {
    "interval" = 10;
    "format" = "🖳 <b>{usage}%</b>";
    "max-length" = 10;
    "tooltip" = false;
  };
  "memory" = {
    "interval" = 30;
    "format" = "<b> {used}GiB</b>";
    "format-alt" = " {used =0.1f}G";
    "max-length" = 10;
  };
  "backlight" = {
    "device" = "amdgpu_bl1";
    "format" = "{icon} {percent}";
    "tooltip" = false;
    "format-icons" = [
      ""
      ""
      ""
    ]
  };
  "network" = {
    "format-wifi" = " {essid}";
    "on-click" = "iwgtk";
    "format-ethernet" = " wired";
    "tooltip" = false;
    "format-disconnected" = "";
  };
  "pulseaudio" = {
    "format" = "{icon} <b>{volume}</b>";
    "format-bluetooth" = " ";
    "format-bluetooth-muted" = "";
    "tooltip" = false;
    "format-muted" = "";
    "format-icons" = {
      "default" = [
        ""
        ""
        ""
      ]
    };
    "on-click" = "pavucontrol";
  };
  "battery" = {
    "bat" = "BAT0";
    "interval" = "60";
    "states" = {
      "warning" = "30";
      "critical" = "15";
    };
    "format" = "{icon} {capacity}%";
    "format-icons" = [
      " "
      " "
      " "
      " "
    ];
    "max-length" = "25";
    "tooltip" = false;
  };
  "custom/right-arr" = {
    "format" = "  ";
  };
  "custom/launcher" = {
    "format" = "";
  };
  "custom/separator" = {
    "format" = " ";
  };
  "custom/window-name" = {
    "format" = "<b>{}</b>";
    "interval" = "1";
    "exec" = "hyprctl activewindow | grep class | awk '{print $2}'";
  };
  "custom/pacman-update" = {
    "format" = "  <b>{}</b> ";
    "interval" = "3600";
    "exec" = "checkupdates | wc -l";
    "signal" = "8";
  };
  "custom/window-icon" = {};
  "temperature" = {
    "thermal-zone" = "0";
    "critical-threshold" = "80";
    "format-critical" = " <b>{temperatureC}°C</b>";
    "format" = " <b>{temperatureC}°C</b>";
  };
  "custom/wrap-left" = {
    "format" = "<b>[</b>";
  };
  "custom/wrap-right" = {
    "format" = "<b>]</b>";
  };
  "custom/weatherNancy" = {
    "format" = "{}";
    "tooltip" = true;
    "interval" = "3600";
    "exec" = "wttrbar --custom-indicator '{ICON} {temp_C}°C' --location Nancy ";
    "return-type" = "json";
  };
  "custom/weatherMontpellier" = {
    "format" = "{}";
    "tooltip" = true;
    "interval" = "3600";
    "exec" = "wttrbar --custom-indicator '{ICON} {temp_C}°C' --location Montpellier ";
    "return-type" = "json";
  };
}
