{
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
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
          ".atuin"
          ".config/discord"
          ".dotfiles"
          ".librewolf"
          ".local"
          ".mozilla"
          ".ssh"
          ".thunderbird"
          ".zen"
          ".zotero"
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
