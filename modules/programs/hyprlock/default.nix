{ config, lib, pkgs, ...}:
{
  options = {
    hyprlock.enable = lib.mkEnableOption "enable hyprlock";
  };

  config = lib.mkIf config.hyprlock.enable {
	  programs.hyprlock = {
	    enable = true;
	    settings = {
	      background = [
	        {
	          path = "screenshot";
	          color = "rgba(25, 20, 20, 1.0)";
	          blur_passes = 3;
	          blur_size = 8;
	          noise = 0.0117;
	          contrast = 0.8916;
	          brightness = 0.8172;
	          vibrancy = 0.1696;
	          vibrancy_darkness = 0.0;
	        }
	      ];
	
	      label = [
	        {
	          text = "";
	          color = "rgba(200, 200, 200, 1.0)";
	          font_size = 25;
	          font_family = "FiraCode Nerd Font";
	          position = "0, 80";
	          halign = "center";
	          valign = "center";
	        }
	      ];
	
	      input-field = [
	        {
				    size = "200, 30";
				    outline_thickness = 1;
				    dots_size = 0.33 ;
	          dots_spacing = 0.15 ;
	          dots_center = false;
	          dots_rounding = -1 ;
	          inner_color = "rgb(151515)";
				    outer_color = "rgb(200, 200, 200)";
				    font_color = "rgb(200, 200, 200)";
				    fade_on_empty = true;
				    fade_timeout = 1000 ;
				    placeholder_text = "<i>Input Password...</i>";
				    hide_input = false;
				    rounding = -1 ;
				    check_color = "rgb(204, 136, 34)";
				    fail_color = "rgb(204, 34, 34)";
				    fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
				    fail_transition = 300 ;
				    capslock_color = -1;
				    numlock_color = -1;
				    bothlock_color = -1;
				    invert_numlock = false;
				    swap_font_color = false;
				    position = "0, -20";
				    halign = "center";
				    valign = "center";
				  }
	      ];
	    };
	  };
  };
}
