{
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        # "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
	      #  {
	      #   directory = "/tmp";
	      #   mode = "1777";
	      #   user = "dymdym";
	      # }
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
	        # how = "symlink";
	        # configureParent = true;
        }
      ];

      # Preserve user files
      users.dymdym = {
        directories = [
          ".atuin"
          ".dotfiles"
          ".librewolf"
          ".local"
          ".mozilla"
          ".ssh"
          ".thunderbird"
          ".zen"
          ".steam"
          "Documents"
          "Downloads"
          "Games"
          "Pictures"
          "Zotero"
        ];

        files = [
        ];
      };
    };
  };
}
