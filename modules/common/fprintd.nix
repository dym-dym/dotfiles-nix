{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.fingerprint-reader.enable {
    security.pam.services.login.fprintAuth = false;
    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
  };
}
