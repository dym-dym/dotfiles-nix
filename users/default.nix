{pkgs, ...}: {
  ## == Users ==

  imports = [
    ./dymdym.nix
  ];

  users = {
    defaultUserShell = pkgs.nushell;
  };
}
