{
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/var/log"
        "/var/lib"
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
          how = "symlink";
          configureParent = true;
        }
      ];

      # Preserve user files
      users.dymdym = {
        directories = [
          ".atuin"
          ".cache"
          ".config"
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

  # systemd-machine-id-commit.service would fail, but it is not relevant
  # in this specific setup for a persistent machine-id so we disable it
  #
  # see the firstboot example below for an alternative approach
  systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];

  # let the service commit the transient ID to the persistent volume
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "/persistent/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root /persistent"
    ];
  };
}
