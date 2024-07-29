{ config, lib, pkgs, ... }:
{
  options = {
    cava.enable = lib.mkEnableOption "enable Cava";
  };

  config = lib.mkIf config.cava.enable {
    programs.cava = {
      enable = true;
      package = pkgs.cava;
      settings = {

        output = {
          vertex_shader = "pass_through.vert";
          fragment_shader = "bar_spectrum.frag";
          method = "ncurses";
        };

        color = {
          # gradient = 1;
          gradient_count = 8;

          gradient_color_1 = "#94e2d5";
          gradient_color_2 = "#89dceb";
          gradient_color_3 = "#74c7ec";
          gradient_color_4 = "#89b4fa";
          gradient_color_5 = "#cba6f7";
          gradient_color_6 = "#f5c2e7";
          gradient_color_7 = "#eba0ac";
          gradient_color_8 = "#f38ba8";
        };
      };
    };
  };
}

