{
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
        {
	        directory = "/tmp";
	        mode = "755";
	        user = "dymdym";
	      }
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
	        how = "symlink";
	        configureParent = true;
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
          ".bash_history"
        ];
      };
    };
  };
}
