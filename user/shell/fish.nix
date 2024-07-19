{ config, pkgs, ... }:

{
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
      # "cd" = "z";
    };
  };
}
