{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programs/zotero

    ./services/sddm
    ./services/noctalia-greeter
  ];

  sddm.enable = true;
  zotero.enable = true;
}
