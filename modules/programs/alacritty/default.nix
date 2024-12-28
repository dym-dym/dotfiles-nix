{ config, pkgs, lib, ... } :
{

  options = {
    alacritty.enable = lib.mkEnableOption "enable alcritty";
  };

  config = lib.mkIf config.alacritty.enable {
	  programs.alacritty = {
	    enable = true;
	    settings = {
	      window = {
		      dynamic_padding = true;
		      decorations = "none";
		      startup_mode = "Maximized";
		      dynamic_title = true;
	      };

	      font = {
	        normal = {
		        family = "FiraCode Nerd Font Mono";
		        style = "Regular";
		      };
	        bold = {
		        family = "FiraCode Nerd Font";
		        style = "Bold";
		      };
	        italic = {
		        family = "FiraCode Nerd Font";
		        style = "Italic";
		      };
		      size = 12;
		      offset = {
		        x = 0;
		        y = 0;
		      };
		      glyph_offset = {
		        x = 0;
		        y = 0;
		      };
	      };

	    };
	  };
  };
}
