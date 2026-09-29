{lib, ...}: {
  options = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };

    username = lib.mkOption {
      type = lib.types.str;
      default = "dymdym";
    };

    timezone = lib.mkOption {
      type = lib.types.str;
      default = "Europe/London";
    };

    nvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    extraBootEntries = lib.mkOption {
      type = lib.types.str;
      default = '''';
    };

    secureBoot.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    gui.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    virtualisation.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    fingerprint-reader.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    greeter = lib.mkOption {
      type = lib.types.str;
      default = "sddm";
    };

  };
}
