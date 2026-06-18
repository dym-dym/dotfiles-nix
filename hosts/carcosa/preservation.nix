{
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
        "/tmp"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      # Preserve user files
      users.dymdym = {
        directories = [
          ".ssh"
          ".mozilla"
          ".cache"
          ".rustup"
          ".steam"
          ".dotfiles"
          ".local"
          ".zen"
          "Documents"
          "Downloads"
          "Games"
          "Pictures"
          "Zotero"
        ];

        files = [
          ".gtkrc-2.0"
          ".bash_history"
          "shell.nix"
          "these.md"
        ];
      };
    };
  };
}
