{ pkgs, lib, ...}:
{
  imports = [
    ./programs/zotero

    ./services/sddm
  ];

	sddm.enable = true;
  zotero.enable = true;
}
