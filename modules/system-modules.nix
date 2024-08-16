{ pkgs, lib, ...}:
{
  imports = [
    ./programs/zotero

    ./services/sddm
    ./services/swayosd
  ];

	sddm.enable = true;
  swayosd.enable = lib.mkDefault true;
  zotero.enable = true;
}
