{
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persistent".neededForBoot = true; # sometimes needed too

  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=25%"
        "mode=755"
      ];
    };
  };

  disko.devices.disk.main = {
    device = "/dev/nvme0n1"; # MAKE SURE TOO SELECT CORRECT DISK HERE
    type = "disk";

    content = {
      type = "gpt";
      partitions = {

        boot = {
          name = "boot";
          size = "1M";
          type = "EF02";
        };

        esp = {
          name = "ESP";
          size = "2G";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };

        root = {
          name = "root";
          size = "100%";

          content = {
            type = "btrfs";
            extraArgs = ["-f"];

            subvolumes = {
              "/persistent" = {
                mountOptions = ["subvol=persistent" "noatime"];
                mountpoint = "/persistent";
              };

              "/nix" = {
                mountOptions = ["subvol=nix" "noatime"];
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
  };
}
