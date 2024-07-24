{ config, pkgs, lib, ... }:
let
  lock = ./lock.png;
  lock-hover = ./lock-hover.png;
  logout = ./logout.png;
  logout-hover = ./logout-hover.png;
  sleep = ./sleep.png;
  sleep-hover = ./sleep-hover.png;
  power = ./power.png;
  power-hover = ./power-hover.png;
  restart = ./restart.png;
  restart-hover = ./restart-hover.png;
  hibernate = ./hibernate.png;
  hibernate-hover = ./hibernate-hover.png;
in
{
  options = {
    wlogout.enable = lib.mkEnableOption "enable wlogout";
  };

  config = lib.mkIf config.wlogout.enable {
	  programs.wlogout = {
	    enable = true;
	    layout = [
	      {
				    label = "lock";
				    action = "hyprlock";
				    text = "Lock";
				    keybind = "l";
				}
				{
				    label = "reboot";
				    action = "systemctl reboot";
				    text = "Reboot";
				    keybind = "r";
				}
				{
				    label = "shutdown";
				    action = "systemctl poweroff";
				    text = "Shutdown";
				    keybind = "s";
				}
				{
				    label = "logout";
				    action = "hyprctl dispatch exit 0";
				    text = "Logout";
				    keybind = "e";
				} {
				    label = "suspend";
				    action = "systemctl suspend";
				    text = "Suspend";
				    keybind = "u";
				}
				{
				    label = "hibernate";
				    action = "systemctl hibernate";
				    text = "Hibernate";
				    keybind = "h";
				}
	    ];

	    style = ''
				window {
				    font-family: monospace;
				    font-size: 14pt;
				    color: #cdd6f4; /* text */
				    background-color: rgba(30, 30, 46, 0.5);
				}

				button {
				    background-repeat: no-repeat;
				    background-position: center;
				    background-size: 25%;
				    border: none;
				    background-color: rgba(30, 30, 46, 0);
				    margin: 5px;
				    transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
				}

				button:hover {
				    background-color: rgba(49, 50, 68, 0.1);
				}

				button:focus {
				    background-color: #cba6f7;
				    color: #1e1e2e;
				}

				#lock {
				    background-image: image(url("${lock}"));
				}
				#lock:focus {
				    background-image: image(url("${lock-hover}"));
				}

				#logout {
				    background-image: image(url("${logout}"));
				}
				#logout:focus {
				    background-image: image(url("${logout-hover}"));
				}

				#suspend {
				    background-image: image(url("${sleep}"));
				}
				#suspend:focus {
				    background-image: image(url("${sleep-hover}"));
				}

				#shutdown {
				    background-image: image(url("${power}"));
				}
				#shutdown:focus {
				    background-image: image(url("${power-hover}"));
				}

				#reboot {
				    background-image: image(url("${restart}"));
				}
				#reboot:focus {
				    background-image: image(url("${restart-hover}"));
				}
				#hibernate {
				    background-image: image(url("${hibernate}"));
				}
				#hibernate:focus {
				    background-image: image(url("${hibernate-hover}"));
				}
	    '';
	  };
  };
}
