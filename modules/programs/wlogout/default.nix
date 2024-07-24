{ config, pkgs, lib, ... }:
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
				    background-image: image(url("./lock.png"));
				}
				#lock:focus {
				    background-image: image(url("./lock-hover.png"));
				}

				#logout {
				    background-image: image(url("./logout.png"));
				}
				#logout:focus {
				    background-image: image(url("./logout-hover.png"));
				}

				#suspend {
				    background-image: image(url("./sleep.png"));
				}
				#suspend:focus {
				    background-image: image(url("./sleep-hover.png"));
				}

				#shutdown {
				    background-image: image(url("./power.png"));
				}
				#shutdown:focus {
				    background-image: image(url("./power-hover.png"));
				}

				#reboot {
				    background-image: image(url("./restart.png"));
				}
				#reboot:focus {
				    background-image: image(url("./restart-hover.png"));
				}
				#hibernate {
				    background-image: image(url("./hibernate.png"));
				}
				#hibernate:focus {
				    background-image: image(url("./hibernate-hover.png"));
				}
	    '';
	  };
  };
}