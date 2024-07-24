{ config, lib, pkgs, ... }:

{
  options ={
    fish.enable = lib.mkEnableOption "enable fish";
  };

  config = lib.mkIf config.fish.enable {
    programs = {
      fish.enable = true;
      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [
          "--cmd cd"
        ];
      };
    };

    programs.fish = {
      shellInit = "fish_vi_key_bindings";
      interactiveShellInit = "fish_vi_key_bindings";

      functions = {
        fish_greeting = {
          body = "";
        }; 
      };

      shellAliases = {
        "ls" = "eza -1l --icons";
        "grep" = "rg";
        "find" = "fd";
        # "cd" = "z";
      };
    };
  };
}
