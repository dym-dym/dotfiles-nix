{ pkgs, lib, ...}:
{
  imports = [
    ./services/sddm
  ];

	sddm.enable = true;

}
