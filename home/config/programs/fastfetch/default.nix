{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    fastfetch.enable = lib.mkEnableOption "enable fastfetch";
  };

  config = lib.mkIf config.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        # "logo" = {
        #     "type" = "kitty-direct";
        #     "source" = "~/Pictures/wallpaper/gruvbox/minimalistic/uchiha-clan-logo.png ";
        #     "width" = 34;
        #   "height" = 15;
        # };
        "modules" = [
          {
            "type" = "custom";
            "format" = "┌────────── Hardware Information ──────────┐";
          }
          {
            "type" = "cpu";
            "key" = "   ";
            "format" = "{1}";
            "compact" = true;
          }
          {
            "type" = "memory";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "host";
            "key" = "   ";
            "compact" = true;
          }

          {
            "type" = "custom";
            "format" = "├────────── Software Information ──────────┤";
          }
          {
            "type" = "users";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "os";
            "key" = "  󰣇 ";
            "compact" = true;
          }
          {
            "type" = "kernel";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "wm";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "editor";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "shell";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "terminal";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "packages";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "localip";
            "key" = "   ";
            "compact" = true;
          }
          {
            "type" = "custom";
            "format" = "      {#1;33}󰮯 {#0}  {#1;33}• • •{#0}  {#1;31}󰊠 {#0}  {#1;35}󰊠 {#0}  {#1;36}󰊠 {#0}  {#1;34}󰊠 {#0}  {#1;32}󰊠 ";
          }
          {
            "type" = "custom";
            "format" = "└─────────────────────────────────────────┘";
          }
          {
            "type" = "custom";
            "format" = "      {#1;36} {#0}  {#1;32} {#0}  {#1;33} {#0}  {#1;34}   {#1;31}   {#1;35}   {#1;37}   {#1;90} ";
          }
        ];
      };
    };
  };
}
