{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    kitty.enable = lib.mkEnableOption "enable kitty";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        size = 12;
      };

      settings = {
        opacity = lib.mkDefault 0.9;
        enable_audio_bell = false;
        enableGitIntegration = true;
      };
    };
  };
}
