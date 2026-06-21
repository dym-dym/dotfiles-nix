{ ... }:
{

  imports = [
      ./boot.nix
      ./hardware.nix
      ./networking.nix
      ./packages.nix
      ./services.nix
      ./systemd.nix
      #./virtualisation.nix
      ./xdg.nix
      ./misc.nix
      ./utils/options.nix
  ];
}
