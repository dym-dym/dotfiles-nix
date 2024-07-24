{ config, pkgs, lib, ... }:

{
  options = {
    atuin.enable = lib.mkEnableOption "enable atuin";
  };

  config = lib.mkIf config.atuin.enable {
	  programs.atuin = {
	    enable = true;
	    enableFishIntegration = true;
	    enableBashIntegration = true;
	    settings = {
	      enable = true;
	      sync_address = "https://atuin.dylanbettendroffer.fr";
	    };
	  };
  };
}
