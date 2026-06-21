{ config, lib, pkgs, ...}:
# let
	#  plugins-repo = pkgs.fetchFromGitHub {
	#   owner = "yazi-rs";
	#   repo = "plugins";
	#    rev = "06e5fe1c7a2a4009c483b28b298700590e7b6784";
	#    hash = "sha256-jg8+GDsHOSIh8QPYxCvMde1c1D9M78El0PljSerkLQc=";
	# };
# in
{
  options = {
    yazi.enable = lib.mkEnableOption "enable yazi file explorer";
  };

  config = lib.mkIf config.yazi.enable {
    programs = {
      yazi = {
        enable = true;
        # enableFishIntegration = true;
	      # plugins = {
			    # chmod = "${plugins-repo}/chmod.yazi";
			    # full-border = "${plugins-repo}/full-border.yazi";
			    # max-preview = "${plugins-repo}/max-preview.yazi";
			    # starship = pkgs.fetchFromGitHub {
			    #  owner = "Rolv-Apneseth";
			    #  repo = "starship.yazi";
			    #      rev = "0a141f6dd80a4f9f53af8d52a5802c69f5b4b618";
			    #      sha256 = "sha256-OL4kSDa1BuPPg9N8QuMtl+MV/S24qk5R1PbO0jgq2rA=";
			    # };
		    # };
		    #
		    #   initLua = ''
		    #     require("full-border"):setup()
		    #     require("starship"):setup
		    #   '';

      };
    };
  };

}
