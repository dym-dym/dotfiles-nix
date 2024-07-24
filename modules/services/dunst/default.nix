{ config, lib, pkgs, ... }:

{

  options = {
    dunst.enable = lib.mkEnableOption "enable dunst";
  };

  config = lib.mkIf config.dunst.enable {
	  services.dunst = {
	    enable = true;

	    settings = {
	      global = {
	        alignment="center";
	        corner_radius=8;
	        format="<b>%s</b>\n%b";
	        frame_width=3;
	      };
	    };
	  };
  };
}
