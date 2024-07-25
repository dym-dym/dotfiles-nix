{ config, lib, pkgs, ...}:
let
  plugins-repo = pkgs.fetchFromGitHub {
	  owner = "yazi-rs";
	  repo = "plugins";
		rev = "...";
		hash = "sha256-...";
	};
in
{
  options = {
    yazi.enable = lib.makeEnableOption "enable yazi file explorer";
  };

  config = lib.mkIf config.yazi.enable {
    programs = {
      yazi = {
        enable = true;
        enableFishIntegration = true;
	      plugins = {
			    chmod = "${plugins-repo}/chmod.yazi";
			    full-border = "${plugins-repo}/full-border.yazi";
			    max-preview = "${plugins-repo}/max-preview.yazi";
			    starship = pkgs.fetchFromGitHub {
				    owner = "Rolv-Apneseth";
				    repo = "starship.yazi";
				    rev = "...";
				    sha256 = "sha256-...";
			    };
		    };

        initLua = ''
          require("full-border"):setup()
          require("starship"):setup
        '';

      };
    };
  };

}
