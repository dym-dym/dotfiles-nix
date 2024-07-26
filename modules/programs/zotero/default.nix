{ config, lib, pkgs, ... }:
{
  options = {
    zotero.enable = lib.mkEnableOption "enable zotero";
  };
  config = lib.mkIf config.zotero.enable {
    users.users.dymdym.packages = [
      pkgs.zotero
    ];
  };
}
