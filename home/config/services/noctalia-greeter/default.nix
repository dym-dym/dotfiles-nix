{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.greeter == "noctalia"){

    services.displayManager.noctalia-greeter = {
      enable = true;
      passwordless-sync-users = [ "dymdym" ];
      settings = {
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
      };
    };
  };
}
