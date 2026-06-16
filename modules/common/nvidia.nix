{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.nvidia.enable {

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "610.43.02";

        sha256_64bit = "sha256-MDSgVLtM33dS/43CclZMsQVROAS/9TU4lFkBsWyndGM=";
        sha256_aarch64 = lib.fakeSha256;
        openSha256 = lib.fakeSha256;
        settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
        persistencedSha256 = lib.fakeSha256;
      };

      # Value of package if you want to get back to stable branch
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;

    };

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "#nvidia-x11"
      ];
  };
}
