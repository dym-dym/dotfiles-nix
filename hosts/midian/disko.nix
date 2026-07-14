{
  fileSystems."/nix".neededForBoot = true;
  # fileSystems."/".neededForBoot = true; # sometimes needed too

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
              "@" = {
                mountOptions = ["subvol=@" "noatime" "compress=zstd"];
                mountpoint = "/";
              };

              "@nix" = {
                mountOptions = ["subvol=@nix" "noatime" "compress=zstd"];
                mountpoint = "/nix";
              };

              "@logs" = {
                mountOptions = ["subvol=@logs" "noatime" "compress=zstd"];
                mountpoint = "/var/log";
              };

              "@home" = {
                mountOptions = ["subvol=@home" "noatime" "compress=zstd"];
                mountpoint = "/home";
              };
            };
          };
        };
      };
    };
  };
}
