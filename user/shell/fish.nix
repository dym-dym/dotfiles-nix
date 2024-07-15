{ config, pkgs, ... }:

{
  programs = {
    fish.enable = true;
    starship.enable = true;
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
    };
  };
}
