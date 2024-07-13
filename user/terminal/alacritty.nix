{ config, pkgs, ... } :
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # opacity = 1;
	      dynamic_padding = true;
	      decorations = "none";
	      startup_mode = "Maximized";
	      dynamic_title = true;
	      # gtk_theme_variant = "dark";
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


      # Catppuccin!
#      colors = {
#
#        draw_bold_text_with_bright_colors = true;
#        # Default colors
#        primary = {
#          background =  "0x1E1D2F";
#          foreground = "0xD9E0EE";
#	      };
#
#        # Colors the cursor will use if `custom_cursor_colors` is true
#        cursor = {
#          text = "0x1E1D2F";
#          cursor = "0xF5E0DC";
#	      };
#
#        # Normal colors
#        normal = {
#          black =   "0x6E6C7E";
#          red =     "0xF28FAD";
#          green =   "0xABE9B3";
#          yellow =  "0xFAE3B0";
#          blue =    "0x96CDFB";
#          magenta = "0xF5C2E7";
#          cyan =    "0x89DCEB";
#          white =   "0xD9E0EE";
#	      };
#
#        # Bright colors
#        bright = {
#          black =   "0x988BA2";
#          red =     "0xF28FAD";
#          green =   "0xABE9B3";
#          yellow =  "0xFAE3B0";
#          blue =    "0x96CDFB";
#          magenta = "0xF5C2E7";
#          cyan =    "0x89DCEB";
#          white =   "0xD9E0EE";
#	      };
#      
##        indexed_colors = {
##          - { index = 16, color = "0xF8BD96" }
##          - { index = 17, color = "0xF5E0DC" }
##        };
#       
#      };
    };
  };
}
